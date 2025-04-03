 int dotX1 = 220; // X-coordinate for the first dot (Boise)
int dotY1 = 420; // Y-coordinate for the first dot (Boise)
int dotSize1 = 20; // Size of the first dot

int dotX2 = 350; // X-coordinate for the second dot (Idaho Falls)
int dotY2 = 500; // Y-coordinate for the second dot (Idaho Falls)
int dotSize2 = 20; // Size of the second dot

PImage Idaho; // Declare an image object for the background

void setup() {
  size(600, 600); // Set the canvas size
  background(255); // Set the background color to white
  Idaho = loadImage("Idaho outline.jpg"); // Load the image for the background
}

void draw() {
  image(Idaho, 0, 0, width, height); // Display the image as the background

  // Boise (First Dot) - Check if the mouse is over the dot
  if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
    fill(255, 0, 0); // Red when hovered
  } else {
    fill(0); // Black otherwise
  }
  ellipse(dotX1, dotY1, dotSize1, dotSize1); // Draw the first dot
  drawLabel("Boise", dotX1, dotY1);
  
  // Idaho Falls (Second Dot) - Check if the mouse is over the dot
  if (dist(mouseX, mouseY, dotX2, dotY2) < dotSize2 / 2) {
    fill(255, 0, 0); // Red when hovered
  } else {
    fill(0); // Black otherwise
  }
  ellipse(dotX2, dotY2, dotSize2, dotSize2); // Draw the second dot
  drawLabel("Idaho Falls", dotX2, dotY2);
}

void drawLabel(String name, int x, int y) {
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(name, x, y + dotSize1 / 2 - 30);
}

void mousePressed() {
  // Check if Boise is clicked
  if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
    fill(0, 0, 255); // Change to blue
    ellipse(dotX1, dotY1, dotSize1, dotSize1);
    noLoop(); // Stop animation
  }
  
  // Check if Idaho Falls is clicked
  if (dist(mouseX, mouseY, dotX2, dotY2) < dotSize2 / 2) {
    fill(0, 0, 255); // Change to blue
    ellipse(dotX2, dotY2, dotSize2, dotSize2);
    noLoop(); // Stop animation
  }
}
