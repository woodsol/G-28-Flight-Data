int dotX1 = 320; // X-coordinate for the first dot (Nashville)
int dotY1 = 270; // Y-coordinate for the first dot (Nashville)
int dotSize1 = 20; // Size of the first dot
int dotX2 = 100; // X-coordinate for the second dot (Memphis)
int dotY2 = 350; // Y-coordinate for the second dot (Memphis)
int dotSize2 = 20; // Size of the second dot
PImage Tennessee; // Declare an image object for the background

void setup() {
  size(600, 600); // Set the canvas size
  background(255); // Set the background color to white
  Tennessee = loadImage("Tennessee.jpg"); // Load the image for the background
}

void draw() {
  image(Tennessee, 0, 0, width, height); // Display the image as the background
  
  // Nashville (First Dot) - Check if the mouse is over the dot
  if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
    fill(255, 0, 0); // Change color to red if hovered
  } else {
    fill(0); // Change color to black if not hovered
  }
  ellipse(dotX1, dotY1, dotSize1, dotSize1); // Draw the first dot
  
  // Draw label for Nashville
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Nashville", dotX1, dotY1 + dotSize1 / 2 + 20);
  
  // Memphis (Second Dot) - Check if the mouse is over the dot
  if (dist(mouseX, mouseY, dotX2, dotY2) < dotSize2 / 2) {
    fill(255, 0, 0); // Change color to red if hovered
  } else {
    fill(0); // Change color to black if not hovered
  }
  ellipse(dotX2, dotY2, dotSize2, dotSize2); // Draw the second dot
  
  // Draw label for Memphis
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Memphis", dotX2, dotY2 + dotSize2 / 2 + 20);
}

void mousePressed() {
  // Check if the mouse is clicked on the first dot (Nashville)
  if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
    fill(0, 0, 255); // Change color to blue if clicked on Nashville
    ellipse(dotX1, dotY1, dotSize1, dotSize1);
    noLoop(); // Stop the animation (to keep the color change permanent)
  }
  
  // Check if the mouse is clicked on the second dot (Memphis)
  if (dist(mouseX, mouseY, dotX2, dotY2) < dotSize2 / 2) {
    fill(0, 0, 255); // Change color to blue if clicked on Memphis
    ellipse(dotX2, dotY2, dotSize2, dotSize2);
    noLoop(); // Stop the animation (to keep the color change permanent)
  }
}
