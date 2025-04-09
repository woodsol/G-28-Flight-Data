class TrajectoryDropdown {
      String[] allLabels;
      String[] visibleLabels;
      int selectedIndex = 0;
      String filter = "";
      float x, y, w = 200, h = 25;
      int scrollOffset = 0;
      int maxVisible = 3;

      TrajectoryDropdown(ArrayList<FlightPath> flights) {
        allLabels = new String[flights.size()];
        for (int i = 0; i < flights.size(); i++) {
          allLabels[i] = flights.get(i).getID();
        }
        updateVisible();

        // Bottom-right positioning with margin
        x = width - w - 130;
        y = height - (h * (maxVisible + 1)) - 30;
      }

      void updateVisible() {
        ArrayList<String> filtered = new ArrayList<String>();
        for (String label : allLabels) {
          if (label.toLowerCase().contains(filter.toLowerCase())) {
            filtered.add(label);
          }
        }
        visibleLabels = filtered.toArray(new String[0]);
        selectedIndex = constrain(selectedIndex, 0, visibleLabels.length - 1);
        scrollOffset = 0;
      }

      void display() {
        fill(240);
        stroke(0);
        rect(x, y, w, h);
        fill(0);
        textAlign(LEFT, CENTER);
        if (visibleLabels.length > 0) {
          text(visibleLabels[selectedIndex], x + 5, y + h / 2);
        } else {
          text("No match", x + 5, y + h / 2);
        }

        for (int i = 0; i < min(maxVisible, visibleLabels.length); i++) {
          int listIndex = scrollOffset + i;
          if (listIndex >= visibleLabels.length) break;
          fill(i == selectedIndex - scrollOffset ? 200 : 255);
          rect(x, y + h * (i + 1), w, h);
          fill(0);
          text(visibleLabels[listIndex], x + 5, y + h * (i + 1) + h / 2);
        }
      }

      void mousePressed() {
        if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h * (maxVisible + 1)) {
          int clicked = int((mouseY - y) / h);
          if (clicked > 0 && scrollOffset + clicked - 1 < visibleLabels.length) {
            selectedIndex = scrollOffset + clicked - 1;
          } else {
            selectedIndex = (selectedIndex + 1) % visibleLabels.length;
          }
        }
      }

      void scroll(int amount) {
        scrollOffset += amount;
        scrollOffset = constrain(scrollOffset, 0, max(0, visibleLabels.length - maxVisible));
      }

      void keyPressed(char key) {
        if (key == BACKSPACE && filter.length() > 0) {
          filter = filter.substring(0, filter.length() - 1);
        } else if (key != ENTER && key != RETURN) {
          filter += key;
        }
        updateVisible();
      }

      FlightPath getSelectedFlight() {
        if (visibleLabels.length == 0) return null;
        String selectedID = visibleLabels[selectedIndex];
        for (FlightPath f : flights) {
          if (f.getID().equals(selectedID)) return f;
        }
        return null;
      }
    }
