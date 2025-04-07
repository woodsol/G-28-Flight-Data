int dotX1 = 250; // X-coordinate for the first dot (Cedar Rapids/Iowa City)
int dotY1 = 300; // Y-coordinate for the first dot (Cedar Rapids/Iowa City)
int dotSize1 = 20; // Size of the first dot

PImage iowa; // Declare an image object for the background

void setup() {
  size(600, 600); // Set the canvas size
  background(255); // Set the background color to white
  iowa = loadImage("iowa.jpg"); // Load the image for the background
}

void draw() {
  image(iowa, 0, 0, width, height); // Display the image as the background

  if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
    fill(255, 0, 0); // Red when hovered
  } else {
    fill(0); // Black otherwise
  }
  ellipse(dotX1, dotY1, dotSize1, dotSize1); // Draw the first dot
  drawLabel("Cedar Rapids/Iowa City", dotX1, dotY1);
}

void drawLabel(String name, int x, int y) {
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(name, x, y + dotSize1 / 2 - 30);
}

void mousePressed() {
  if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
    fill(0, 0, 255); // Change to blue
    ellipse(dotX1, dotY1, dotSize1, dotSize1);
    noLoop(); // Stop animation
  }
}
