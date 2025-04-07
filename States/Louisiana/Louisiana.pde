int dotX1 = 350; // X-coordinate for the first dot (New Orleans)
int dotY1 = 400; // Y-coordinate for the first dot (New Orleans)
int dotSize1 = 20; // Size of the first dot

PImage louisiana; // Declare an image object for the background

void setup() {
  size(600, 600); // Set the canvas size
  background(255); // Set the background color to white
  louisiana = loadImage("Louisiana.jpg"); // Load the image for the background (country image)
}

void draw() {
  image(louisiana, 0, 0, width, height); // Display the image as the background

  if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
    fill(255, 0, 0); // Red when hovered
  } else {
    fill(0); // Black otherwise
  }
  ellipse(dotX1, dotY1, dotSize1, dotSize1); // Draw the first dot
  drawLabel("New Orleans", dotX1, dotY1);
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
