class SearchBar {
    String[] usLocations;
    String searchQuery = "";
    String departure = "";
    String arrival = "";
    boolean selectingDeparture = true;
    ArrayList<String> suggestions = new ArrayList<String>();
    int selectedSuggestion = -1;
    boolean showSuggestions = false;
    boolean hasFocus = false;
    int cursorPosition = 0;
    boolean clickedOnSearch;
    public boolean searchComplete = false;
    public boolean departureIsCity = false;
    public boolean arrivalIsCity = false;
    
    SearchBar() {
        usLocations = loadStrings("us_locations.txt");
    }

    void draw(int mX, int mY) {
      if (departure.isEmpty()) {
        drawFullWidthSearchBar(mX, mY);
      } else if (arrival.isEmpty()) {
        drawSplitSearchBar(mX, mY);
      } else {
        String[] spl = departure.split(",");
        departureIsCity = spl.length > 1;
        spl = arrival.split(",");
        arrivalIsCity = spl.length > 1;
        searchComplete = true;
      }
    }

    void drawFullWidthSearchBar(int mX, int mY) {
      fill(255);
      stroke(hasFocus ? color(100, 150, 255) : 200);
      strokeWeight(hasFocus ? 2 : 1);
      rect(20, 60, width-40, 40, 5);
      
      fill(150);
      textAlign(LEFT, CENTER);
      text("⌕", 30, 80);
      
      fill(0);
      text(searchQuery, 60, 80);
      
      if (searchQuery.isEmpty()) {
        fill(180);
        text("Search for departure city or state...", 60, 80);
      }
      
      // Draw cursor
      if (frameCount/30 % 2 == 0 && hasFocus && selectingDeparture) {
        String textBeforeCursor = searchQuery.substring(0, cursorPosition);
        float cursorX = 60 + textWidth(textBeforeCursor);
        line(cursorX, 70, cursorX, 90);
      }

      drawSuggestions(20, 105, mX, mY);
    }

    void drawSplitSearchBar(int mX, int mY) {
      // Departure box
      fill(255);
      stroke(hasFocus && selectingDeparture ? color(100, 150, 255) : 200);
      strokeWeight(hasFocus && selectingDeparture ? 2 : 1);
      rect(20, 60, (width-50)/2, 40, 5);
      
      // Departure text
      fill(0);
      textAlign(LEFT, CENTER);
      text(departure, 30, 80);
      
      // Arrow between boxes
      fill(100);
      text("→", width/2 - 10, 80);
      
      // Arrival box
      fill(255);
      stroke(hasFocus && !selectingDeparture ? color(100, 150, 255) : 200);
      strokeWeight(hasFocus && !selectingDeparture ? 2 : 1);
      rect(width/2 + 10, 60, (width-50)/2, 40, 5);
      
      // Arrival text or search query
      fill(0);
      if (searchQuery.isEmpty()) {
        fill(180);
        text("Search for arrival city or state...", width/2 + 20, 80);
      } else {
        fill(0);
        text(searchQuery, width/2 + 20, 80);
      }
      
      // Draw cursor
      if (frameCount/30 % 2 == 0 && hasFocus && !selectingDeparture) {
        String textBeforeCursor = searchQuery.substring(0, cursorPosition);
        float cursorX = width/2 + 20 + textWidth(textBeforeCursor);
        line(cursorX, 70, cursorX, 90);
      }
      
      // Draw suggestions if needed
      drawSuggestions(width/2 + 10, 105, mX, mY);
    }

    void drawResetButton(float x, float y, int mX, int mY) {
      // Check if mouse is hovering over the X
      boolean hover = dist(mX, mY, x, y) < 12;
      
      // Draw X icon
      stroke(hover ? color(200, 100, 100) : color(150));
      strokeWeight(2);
      line(x - 8, y - 8, x + 8, y + 8);
      line(x + 8, y - 8, x - 8, y + 8);
    }

    void drawSuggestions(float x, float y, int mX, int mY) {
      if (!showSuggestions || suggestions.size() == 0) return;
      
      // Calculate maximum width needed
      float maxWidth = 0;
      for (String s : suggestions) {
        float w = textWidth(s);
        if (w > maxWidth) maxWidth = w;
      }
      
      // Draw suggestion box
      fill(255);
      stroke(200);
      strokeWeight(1);
      rect(x, y, max(maxWidth + 20, width-40), suggestions.size() * 30 + 10, 5);
      
      // Draw suggestions
      textAlign(LEFT, CENTER);
      for (int i = 0; i < suggestions.size(); i++) {
        boolean hover = mX >= x + 5 && mX <= x + maxWidth + 15 &&
                       mY >= y + 5 + i * 30 && mY <= y + 30 + i * 30;
        
        if (i == selectedSuggestion || hover) {
          fill(230, 240, 255);
          rect(x + 5, y + 5 + i * 30, maxWidth + 10, 25);
          fill(0);
        } else {
          fill(0);
        }
        text(suggestions.get(i), x + 10, y + 20 + i * 30);
      }
    }

    void keyPressed() {
      if (!hasFocus) return;
      
      if (key == CODED) {
        if (keyCode == UP && showSuggestions) {
          selectedSuggestion = max(-1, selectedSuggestion - 1);
        } else if (keyCode == DOWN && showSuggestions) {
          selectedSuggestion = min(suggestions.size() - 1, selectedSuggestion + 1);
        } else if (keyCode == LEFT) {
          cursorPosition = max(0, cursorPosition - 1);
        } else if (keyCode == RIGHT) {
          cursorPosition = min(searchQuery.length(), cursorPosition + 1);
        }
        return;
      }
      
      if (key == ENTER || key == RETURN) {
        if (showSuggestions && selectedSuggestion >= 0 && selectedSuggestion < suggestions.size()) {
          selectLocation(suggestions.get(selectedSuggestion));
        }
        return;
      }
      
      if (key == BACKSPACE) {
        if (searchQuery.length() > 0 && cursorPosition > 0) {
          searchQuery = searchQuery.substring(0, cursorPosition - 1) + 
                       searchQuery.substring(cursorPosition);
          cursorPosition--;
          updateSuggestions();
        }
        return;
      }
      
      if (key == DELETE) {
        if (cursorPosition < searchQuery.length()) {
          searchQuery = searchQuery.substring(0, cursorPosition) + 
                       searchQuery.substring(cursorPosition + 1);
          updateSuggestions();
        }
        return;
      }
      
      if (key >= 32 && key <= 126) { // Printable characters
        searchQuery = searchQuery.substring(0, cursorPosition) + key + 
                     searchQuery.substring(cursorPosition);
        cursorPosition++;
        updateSuggestions();
      }
    }

    void mousePressed(int mX, int mY) {
      // Check if clicked on search bar areas
      clickedOnSearch = false;
      
      if (departure.isEmpty()) {
        // Full width search bar
        if (mX >= 20 && mX <= width-20 && mY >= 60 && mY <= 100) {
          hasFocus = true;
          selectingDeparture = true;
          clickedOnSearch = true;
        }
      } else if (arrival.isEmpty()) {
        if (mX >= 20 && mX <= 20 + (width-50)/2 && mY >= 60 && mY <= 100) {
          hasFocus = true;
          selectingDeparture = true;
          clickedOnSearch = true;
        } else if (mX >= width/2 + 10 && mX <= width/2 + 10 + (width-50)/2 && 
                   mY >= 60 && mY <= 100) {
          hasFocus = true;
          selectingDeparture = false;
          clickedOnSearch = true;
        }
      }
      
      if (showSuggestions && suggestions.size() > 0) {
        float suggestionX = departure.isEmpty() ? 20 : width/2 + 10;
        float suggestionY = 105;
        float maxWidth = 0;
        for (String s : suggestions) {
          float w = textWidth(s);
          if (w > maxWidth) maxWidth = w;
        }
        
        if (mX >= suggestionX && mX <= suggestionX + max(maxWidth + 20, width-40) &&
            mY >= suggestionY && mY <= suggestionY + suggestions.size() * 30 + 10) {
          int clickedIndex = (int)((mY - suggestionY - 5) / 30);
          if (clickedIndex >= 0 && clickedIndex < suggestions.size()) {
            selectLocation(suggestions.get(clickedIndex));
            clickedOnSearch = true;
          }
        }
      }
      
      if (!departure.isEmpty() && !arrival.isEmpty()) {
        if (dist(mX, mY, width - 40, 80) < 12) {
          resetSearch();
          clickedOnSearch = true;
        }
      }
      
      if (!clickedOnSearch) {
        hasFocus = false;
      }
    }

    void updateSuggestions() {
      if (searchQuery.length() < 1) {
        suggestions.clear();
        showSuggestions = false;
        return;
      }
      
      String queryLower = searchQuery.toLowerCase();
      suggestions = Arrays.stream(usLocations)
        .filter(loc -> loc.toLowerCase().contains(queryLower))
        .collect(Collectors.toCollection(ArrayList::new));
      
      showSuggestions = suggestions.size() > 0;
      selectedSuggestion = -1;
    }

    void selectLocation(String location) {
      if (departure.isEmpty()) {
        departure = location;
        selectingDeparture = false;
      } else {
        arrival = location;
        selectingDeparture = true;
      }
      searchQuery = "";
      cursorPosition = 0;
      showSuggestions = false;
    }


    void resetSearch() {
      departure = "";
      arrival = "";
      searchQuery = "";
      cursorPosition = 0;
      selectingDeparture = true;
      showSuggestions = false;
      hasFocus = true;
    }
}
