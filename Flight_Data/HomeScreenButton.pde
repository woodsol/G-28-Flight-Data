class HomeScreenButton {
  String label;
  float x, y, w, h;
  public PImage img;
  boolean isHovered;

  HomeScreenButton(String label, float x, float y, float w, float h, PImage img) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = img;
  }

  // Displays the button with hover effects
  void display() {
    float displayX = x;
    float displayY = y;
    float displayW = w;
    float displayH = h;

    if (isHovered) {
      displayX -= 5; // Slightly shift position for smooth expansion
      displayY -= 5;
      displayW += 10; // Increase size on hover
      displayH += 10;
      strokeWeight(4); // Thicker outline when hovered
      stroke(50);
    } else {
      strokeWeight(2);
      stroke(0);
    }

    fill(255);
    rect(displayX, displayY, displayW, displayH, 20);

    if (img != null) {
      image(img, displayX + 10, displayY + 10, displayW - 20, displayH - 40);
    }
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, displayX + displayW / 2, displayY + displayH - 20);
  }

  // Checks if the button is clicked
  boolean isClicked(float mx, float my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }

  // Checks if the mouse is hovering over the button
  void checkHover(float mx, float my) {
    isHovered = mx > x && mx < x + w && my > y && my < y + h;
  }

  // Updates hover states for buttons based on mouse movement
}
// Code by Christy Hosford
