  int dotX1 = 385; // X-coordinate for the first dot (Honolulu)
 int dotY1 = 240; // Y-coordinate for the first dot (Honolulu)
 int dotSize1 = 20; // Size of the first dot
 PImage Hawaii; // Declare an image object for the background
 
 void setup() {
   size(600, 600); // Set the canvas size
   background(255); // Set the background color to white
   Hawaii = loadImage("Hawaii.jpg"); // Load the image for the background
 }
 
 void draw() {
   image(Hawaii, 0, 0, width, height); // Display the image as the background
   
   // Honolulu (First Dot) - Check if the mouse is over the dot
   if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
     fill(255, 0, 0); // Change color to red if hovered
   } else {
     fill(0); // Change color to black if not hovered
   }
   ellipse(dotX1, dotY1, dotSize1, dotSize1); // Draw the first dot
   
   // Draw label for Honolulu
   fill(0,0,0);
   textSize(20);
   textAlign(CENTER, CENTER);
   text("Honolulu", dotX1  - 30, dotY1 + dotSize1 / 2 - 30);
   
   
   
 }
 
 void mousePressed() {
   // Check if the mouse is clicked on the first dot (Honolulu)
   if (dist(mouseX, mouseY, dotX1, dotY1) < dotSize1 / 2) {
     fill(0, 0, 255); // Change color to blue if clicked on Honolulu
     ellipse(dotX1, dotY1, dotSize1, dotSize1);
     noLoop(); // Stop the animation (to keep the color change permanent)
   
   }
 }
