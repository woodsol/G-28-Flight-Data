int dotX = 300;
int dotY = 250;
int dotSize = 20;
PImage state;

void setup() {
  size(600, 600);
  background(255);
  state = loadImage("oklahoma_outline.jpeg");
}

void draw() {
  image(state, 0, 0, width, height);
  
  // Determine dot color based on mouse position
  color dotColor = dist(mouseX, mouseY, dotX, dotY) < dotSize / 2 
                   ? color(255, 0, 0) 
                   : color(0);
  fill(dotColor);
  
  // Draw dot and label
  ellipse(dotX, dotY, dotSize, dotSize);
  
  textSize(20);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Airport", dotX, dotY + dotSize + 20);
}

void mousePressed() {
  // Stop animation if dot is clicked
  if (dist(mouseX, mouseY, dotX, dotY) < dotSize / 2) {
    fill(0, 0, 255);
    ellipse(dotX, dotY, dotSize, dotSize);
    noLoop();
  }
}
