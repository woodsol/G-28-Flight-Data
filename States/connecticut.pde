int dotX1 = 340; // X-coordinate for the first dot (Nashville)
int dotY1 = 200; // Y-coordinate for the first dot (Nashville)
int dotSize1 = 20; // Size of the first dot
int dotX2 = 280; // X-coordinate for the second dot (Memphis)
int dotY2 = 400; // Y-coordinate for the second dot (Memphis)
int dotSize2 = 20; // Size of the second dot
int dotX3 = 150;
int dotY3 = 350;
int dotSize3 = 20;
PImage connecticut; // Declare an image object for the background

void setup() {
  size(600, 600); // Set the canvas sizexa
  background(255); // Set the background color to white
  connecticut = loadImage("connecticut.png"); // Load the image for the background
}

void draw() {
  image(connecticut, 50, 50, width-100, height-100); // Display the image as the background
  
  if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
    fill(255, 0, 0); // Change color to red if hovered
  } else {
    fill(0); // Change color to black if not hovered
  }
  ellipse(dotX1, dotY1, dotSize1, dotSize1); // Draw the first dot
  
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Hartford Brainard", dotX1, dotY1 + dotSize1 / 2 + 20);
  
  if (dist(mouseX, mouseY, dotX2, dotY2) < dotSize2 / 2) {
    fill(255, 0, 0); // Change color to red if hovered
  } else {
    fill(0); // Change color to black if not hovered
  }
  ellipse(dotX2, dotY2, dotSize2, dotSize2); // Draw the second dot
  
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Tweed New-Haven", dotX2, dotY2 + dotSize2 / 2 + 20);
  
  if (dist(mouseX, mouseY, dotX3, dotY3) < dotSize3 / 2) {
    fill(255, 0, 0); // Change color to red if hovered
  } else {
    fill(0); // Change color to black if not hovered
  }
  ellipse(dotX3, dotY3, dotSize3, dotSize3); // Draw the first dot
  
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Danbury Municipal", dotX3, dotY3 + dotSize3 / 2 + 20);
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
  
  if (dist(mouseX, mouseY, dotX3, dotY3) < dotSize3 / 2) {
    fill(0, 0, 255); // Change color to blue
    ellipse(dotX3, dotY3, dotSize3, dotSize3);
    noLoop(); // Stop the animation (to keep the color change permanent)
  }
}
