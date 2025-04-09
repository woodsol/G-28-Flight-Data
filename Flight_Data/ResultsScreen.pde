class ResultsScreen {
  ArrayList<Flight> results = new ArrayList<Flight>();
  int scrollY = 0;
  int totalHeight;
  int gap = 1; // Amount of pixels to scroll to bypass one result
  float ratio;
  float scrollbarWidth = 10;
  boolean locked;
  int prevMy;
  int resultHeight = 100;
  color bg_color = color(255);
  color scrollbarColor = color(135, 206, 235);
  PImage delta = loadImage("airlines/Delta.png");
  PImage united = loadImage("airlines/United.png");
  PImage southwest = loadImage("airlines/Southwest.png");
  PImage americanairlines = loadImage("airlines/American.png");
  PImage spirit = loadImage("airlines/Spirit.png");
  PImage alaska = loadImage("airlines/Alaska.png");
  PImage frontier = loadImage("airlines/Frontier.png");
  int frame_count = 0;

  ResultsScreen() {
    totalHeight = height * gap;
    ratio = ((float) height) / ((float) totalHeight);
  }

  public void loadResults(ArrayList<Flight> results) {
    this.results = results;
    ArrayList<Flight> cancelled = new ArrayList<Flight>();

    for (int i = 0; i < this.results.size(); i++) {
        Flight result = this.results.get(i);
        if (result.CANCELLED == 1 || result.DIVERTED == 1) {
            cancelled.add(result);
            results.remove(i--);
        }
    }
    results.addAll(cancelled);
    totalHeight = this.results.size() * resultHeight;
    ratio = ((float) height) / ((float) totalHeight);
  }

  void drawScrollbar() {
    ellipseMode(CORNER);
    noStroke();
    fill(224);
    rect(width-((int) scrollbarWidth), 0, scrollbarWidth, height);
    fill(scrollbarColor);
    rect(width-((int) scrollbarWidth), scrollY, scrollbarWidth, height * ratio);
  }

  void handleScrollLogic() {
    if (mouseX > width - scrollbarWidth) {
      if (scrollbarWidth < 15) {
        scrollbarWidth += 0.3;
      }
    } else if (scrollbarWidth > 10) {
      scrollbarWidth -= 0.3;
    }

    if (mousePressed) {
      if (locked) {
        scrollY += mouseY - prevMy;
        prevMy = mouseY;

        if (scrollY + ((int) height * ratio) > height) {
          scrollY = height - ((int) (height * ratio));
        }
        if (scrollY < 0) {
          scrollY = 0;
        }
      } else if (mouseX > width - scrollbarWidth) {
        prevMy = mouseY;
        locked = true;
      }
    }
  }

  public void draw(boolean dataReturned) {
    background(bg_color);

    if (results.size() == 0) {
        if (frame_count < 1000 && !dataReturned) {
            textFont(MontserratBold);
            textSize(16);
            fill(80);
            textAlign(CENTER, CENTER);
            text("Loading" + new String(new char[(frame_count / 10) % 3]).replace("\0", "."), width / 2, height / 2);
        } else {
            textFont(MontserratBold);
            textSize(16);
            fill(80);
            textAlign(CENTER, CENTER);
            text("No Results Found", width / 2, height / 2);
        }

        frame_count += 1;
        return;
    }
    
    int scrollCoord = (int ((float) scrollY / gap / ratio));

    for (int index = scrollCoord / resultHeight; index < results.size(); index++) {
      Flight result = results.get(index);
      fill(120);
      stroke(1);
      strokeWeight(1);
      int line_y = (index - scrollCoord / resultHeight) * resultHeight - scrollCoord % resultHeight + resultHeight;
      if (line_y > height + resultHeight) { break; }
      line(10, line_y, width - 10 - scrollbarWidth, line_y);
      strokeWeight(4);
      drawResult(result, (index - scrollCoord / resultHeight) * resultHeight - scrollCoord % resultHeight, result.CANCELLED == 1 || result.DIVERTED == 1);
    }

    drawScrollbar();
    handleScrollLogic();
  }

  void drawResult(Flight result, int ypos, boolean cancelled_or_diverted) {
    if (ypos > height) {
        return;
    }
    textAlign(LEFT, CENTER);
    textFont(MontserratBold);
    textSize(14);
    float r = 1;
    switch(result.MKTCARRIER) {
      case "AA":
        r = (float) americanairlines.height / (float) americanairlines.width;
        image(americanairlines, 45, ypos + resultHeight / 2 - 60, 120 * r, 120);
        break;
      case "AS":
        r = (float) alaska.height / (float) alaska.width;
        image(alaska, 45, ypos + resultHeight / 2 - 50, 100 * r, 100);
        break;
      case "F9":
        r = (float) frontier.height / (float) frontier.width;
        image(frontier, 45, ypos + resultHeight / 2 - 50, 100 * r, 100);
        break;
      case "WN":
        r = (float) southwest.height / (float) southwest.width;
        image(southwest, 45, ypos + resultHeight / 2 - 50, 100 * r, 100);
        break;
      case "DL":
        r = (float) delta.height / (float) delta.width;
        image(delta, 45, ypos + resultHeight / 2 - 50, 100 * r, 100);
        break;
      case "NK":
        r = (float) spirit.height / (float) spirit.width;
        image(spirit, 45, ypos + resultHeight / 2 - 50, 100 * r, 100);
        break;
      case "UA":
        r = (float) united.height / (float) united.width;
        image(united, 20, ypos + resultHeight / 2 - 70, 150 * r, 140);
        break;
      default:
        break;
    }
    fill(scrollbarColor);
    text(result.MKTCARRIER + result.MKTCARRIERFLNUM, 170, ypos + resultHeight / 2);
    textFont(Montserrat);
    textSize(16);
    fill(80);
    if (cancelled_or_diverted) {
        if (result.DIVERTED == 1) {
            fill(160, 160, 30);
            text("DIVERTED", 700, ypos + resultHeight / 2);
        } else {
            fill(255, 30, 30);
            text("CANCELLED", 700, ypos + resultHeight / 2);
        }
    } else {
        text(result.ORIGINCITYNAME + " -> " + result.DESTCITYNAME, 280, ypos + resultHeight / 2);
        text(processTime(result.DEPTIME) + " -> " + processTime(result.ARRTIME), 700, ypos + resultHeight / 2);
    }
  }

  String processTime(String t) {
    if (t.length() == 0) {
      return "";
    }
    StringBuilder str = new StringBuilder(t);
    str.insert(2, ":");
    return str.toString();
  }

  public void unlock() {
    locked = false;
  }
}

// Christian Barton Randall 24/3/2025
