int dotX1 = 220; // X-coordinate for the first dot (Chicago)
int dotY1 = 420; // Y-coordinate for the first dot (Chicago)
int dotSize1 = 20; // Size of the first dot

PImage Illinoise; // Declare an image object for the background

void setup() {
  size(600, 600); // Set the canvas size
  background(255); // Set the background color to white
  Illinoise = loadImage("Illinoise.jpg"); // Load the image for the background
}

void draw() {
  image(Illinoise, 0, 0, width, height); // Display the image as the background

  // Chicago (First Dot) - Check if the mouse is over the dot
  if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
    fill(255, 0, 0); // Red when hovered
  } else {
    fill(0); // Black otherwise
  }
  ellipse(dotX1, dotY1, dotSize1, dotSize1); // Draw the first dot
  drawLabel("Chicago", dotX1, dotY1);
}

void drawLabel(String name, int x, int y) {
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(name, x, y + dotSize1 / 2 - 30);
}

void mousePressed() {
  // Check if Chicago is clicked
  if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
    fill(0, 0, 255); // Change to blue
    ellipse(dotX1, dotY1, dotSize1, dotSize1);
    noLoop(); // Stop animation
  }
}
