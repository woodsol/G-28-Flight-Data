int dotX = 200; // X-coordinate for the dot
int dotY = 220; // Y-coordinate for the dot
int dotSize = 20; // Size of the dot
PImage Washington; 

void setup() {
  size(600, 600); // Set the canvas size
  background(255); // Set the background color to white
  Washington = loadImage("Washington.jpg");
}

void draw() {
  image(Washington, 0, 0, width, height);
  // Check if the mouse is over the dot
  if (dist(mouseX, mouseY, dotX, dotY) < dotSize / 2) {
    // Change the dot color to red if hovered
    fill(255, 0, 0);
  } else {
    // Change the dot color to black if not hovered
    fill(0);
  }
  
  // Draw the dot
  ellipse(dotX, dotY, dotSize, dotSize);
  
  // Draw the label
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Seattle", dotX, dotY + dotSize / 2 + 20);
}

void mousePressed() {
  // Check if the mouse is clicked on the dot
  if (dist(mouseX, mouseY, dotX, dotY) < dotSize / 2) {
    // Change the dot color to blue if clicked
    fill(0, 0, 255);
    ellipse(dotX, dotY, dotSize, dotSize);
    noLoop();
  }
}
