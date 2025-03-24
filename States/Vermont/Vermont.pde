int dotX = 300; // X-coordinate for the dot
int dotY = 250; // Y-coordinate for the dot
int dotSize = 20; // Size of the dot
PImage Vermont; 

void setup() {
  size(600, 600); // Set the canvas size
  background(255); // Set the background color to white
  Vermont = loadImage("Vermont.jpg");
}

void draw() {
  image(Vermont, 0, 0, width, height);
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
  text("Burlington", dotX, dotY + dotSize / 2 + 20);
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
