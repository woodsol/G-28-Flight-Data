int dotX1 = 385; // X-coordinate for the first dot (Baltimore)
 int dotY1 = 240; // Y-coordinate for the first dot (Baltimore)
 int dotSize1 = 20; // Size of the first dot
 PImage maryland; // Declare an image object for the background
 
 void setup() {
   size(600, 600); // Set the canvas size
   background(255); // Set the background color to white
   maryland = loadImage("maryland.jpg"); // Load the image for the background
 }
 
 void draw() {
   image(maryland, 0, 0, width, height); // Display the image as the background
   
   // Baltimore (First Dot) - Check if the mouse is over the dot
   if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
     fill(255, 0, 0); // Change color to red if hovered
   } else {
     fill(0); // Change color to black if not hovered
   }
   ellipse(dotX1, dotY1, dotSize1, dotSize1); // Draw the first dot
   
   // Draw label for Baltimore
   fill(0,0,0);
   textSize(20);
   textAlign(CENTER, CENTER);
   text("Baltimore", dotX1  - 30, dotY1 + dotSize1 / 2 - 30);
   
   
   
 }
 
 void mousePressed() {
   // Check if the mouse is clicked on the first dot (Baltimore)
   if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
     fill(0, 0, 255); // Change color to blue if clicked on Baltimore
     ellipse(dotX1, dotY1, dotSize1, dotSize1);
     noLoop(); // Stop the animation (to keep the color change permanent)
   
   }
 }
