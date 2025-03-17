int currentScreen = 0; // Keeps track of the current screen
GraphLine graphLine;
GraphBar graphBar;
GraphPie graphPie;
GraphScatter graphScatter;
GraphHistogram graphHistogram;

void setup() {
  size(800, 800);
  graphLine = new GraphLine();
  graphBar = new GraphBar();
  graphPie = new GraphPie();
  graphScatter = new GraphScatter();
  graphHistogram = new GraphHistogram();
}

void draw() {
  background(255);
  
  // Display the appropriate screen
  if (currentScreen == 0) {
    drawMainMenu();
  } else if (currentScreen == 1) {
    graphLine.draw(50, 50);
  } else if (currentScreen == 2) {
    graphBar.draw(50, 50);
  } else if (currentScreen == 3) {
    graphPie.draw(50, 50);
  } else if (currentScreen == 4) {
    graphScatter.draw(50, 50);
  } else if (currentScreen == 5) {
    graphHistogram.draw(50, 50);
  }
  
  // Always draw the back button
  drawBackButton();
}

// Draws the back button
void drawBackButton() {
  fill(200);
  rect(700, 700, 50, 50);
  fill(0);
  textSize(12);
  text("Back", 715, 730);
}

void mousePressed() {
  // Main menu buttons
  if (mouseX > 50 && mouseX < 200 && mouseY > 50 && mouseY < 100) {
    currentScreen = 1; // Line Graph
  } else if (mouseX > 50 && mouseX < 200 && mouseY > 150 && mouseY < 200) {
    currentScreen = 2; // Bar Graph
  } else if (mouseX > 50 && mouseX < 200 && mouseY > 250 && mouseY < 300) {
    currentScreen = 3; // Pie Chart
  } else if (mouseX > 50 && mouseX < 200 && mouseY > 350 && mouseY < 400) {
    currentScreen = 4; // Scatter Plot
  } else if (mouseX > 50 && mouseX < 200 && mouseY > 450 && mouseY < 500) {
    currentScreen = 5; // Histogram
  }
  
  // Go back to the main menu
  if (mouseX > 700 && mouseX < 750 && mouseY > 700 && mouseY < 750) {
    currentScreen = 0;
  }
}

void drawMainMenu() {
  textSize(24);
  fill(0);
  text("Main Menu", 50, 40);
  
  // Button for Line Graph
  fill(200);
  rect(50, 50, 150, 50);
  fill(0);
  text("Line Graph", 100, 80);
  
  // Button for Bar Graph
  fill(200);
  rect(50, 150, 150, 50);
  fill(0);
  text("Bar Graph", 100, 180);
  
  // Button for Pie Chart
  fill(200);
  rect(50, 250, 150, 50);
  fill(0);
  text("Pie Chart", 100, 280);
  
  // Button for Scatter Plot
  fill(200);
  rect(50, 350, 150, 50);
  fill(0);
  text("Scatter Plot", 100, 380);
  
  // Button for Histogram
  fill(200);
  rect(50, 450, 150, 50);
  fill(0);
  text("Histogram", 100, 480);
}

// GraphLine class for line graph
class GraphLine {
  int[] data = {10, 20, 30, 25, 40, 35, 50};
  
  void draw(float xOffset, float yOffset) {
    stroke(0);
    noFill();
    beginShape();
    for (int i = 0; i < data.length; i++) {
      float x = map(i, 0, data.length - 1, xOffset, xOffset + 300);
      float y = map(data[i], 0, 50, yOffset + 200, yOffset);
      vertex(x, y);
    }
    endShape();
  }
}

//All code added by Oliver Woods 12:20 17/03/2025
