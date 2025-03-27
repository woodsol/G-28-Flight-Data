int dotX1 = 300; // X-coordinate for the first dot (Nashville)
int dotY1 = 430; // Y-coordinate for the first dot (Nashville)
int dotSize1 = 20; // Size of the first dot
int dotX2 = 240; // X-coordinate for the second dot (Memphis)
int dotY2 = 220; // Y-coordinate for the second dot (Memphis)
int dotSize2 = 20; // Size of the second dot
PImage Delaware; // Declare an image object for the background

void setup() {
  size(600, 600); // Set the canvas sizexa
  background(255); // Set the background color to white
  Delaware = loadImage("Delaware.jpg"); // Load the image for the background
}

void draw() {
  image(Delaware, 50, 50, width-100, height-100); // Display the image as the background
  
  if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
    fill(255, 0, 0); // Change color to red if hovered
  } else {
    fill(0); // Change color to black if not hovered
  }
  ellipse(dotX1, dotY1, dotSize1, dotSize1); // Draw the first dot
  
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Delaware Coastal", dotX1, dotY1 + dotSize1 / 2 + 20);
  
  if (dist(mouseX, mouseY, dotX2, dotY2) < dotSize2 / 2) {
    fill(255, 0, 0); // Change color to red if hovered
  } else {
    fill(0); // Change color to black if not hovered
  }
  ellipse(dotX2, dotY2, dotSize2, dotSize2); // Draw the second dot
  
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Summit", dotX2, dotY2 + dotSize2 / 2 + 20);
}  


void mousePressed() {
  // Check if the mouse is clicked on the first dot (Nashville)
  if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
    fill(0, 0, 255); // Change color to blue if clicked on Nashville
    ellipse(dotX1, dotY1, dotSize1, dotSize1);
    noLoop(); // Stop the animation (to keep the color change permanent)
  }
  
  if (dist(mouseX, mouseY, dotX2, dotY2) < dotSize2 / 2) {
    fill(0, 0, 255); // Change color to blue
    ellipse(dotX2, dotY2, dotSize2, dotSize2);
    noLoop(); // Stop the animation (to keep the color change permanent)
  }
}
