final int MAIN = 0;
final int BAR_CHART = 1;
final int LINE_CHART = 2;
final int TRAJECTORY = 3;
final int HEAT_MAP = 4;

class GraphScreen {
    int subScreen = 0;
    GraphScreen() {
      barChartImage = loadImage("barChartImage2.png");
      pieChartImage = loadImage("pieChartImage2.png");
      lineChartImage = loadImage("lineChartImage2.png");
      trajectoryImage = loadImage("flightTrajectoryImage2.png");
      heatMapImage = loadImage("heatMapImage2.png");

      float graphButtonWidth = 160 * 1.5;
      float graphButtonHeight = 90 * 1.5;
      float spacingX = (width - (3 * graphButtonWidth)) / 4;
      float spacingY = 50;

      barChartButton = new HomeScreenButton("Bar Chart", spacingX, 150, graphButtonWidth, graphButtonHeight, barChartImage);
      pieChartButton = new HomeScreenButton("Pie Chart", spacingX * 2 + graphButtonWidth, 150, graphButtonWidth, graphButtonHeight, pieChartImage);
      lineChartButton = new HomeScreenButton("Line Chart", spacingX * 3 + graphButtonWidth * 2, 150, graphButtonWidth, graphButtonHeight, lineChartImage);
      trajectoryButton = new HomeScreenButton("Trajectory", spacingX * 1.5 + graphButtonWidth * 0.5, 150 + graphButtonHeight + spacingY, graphButtonWidth, graphButtonHeight, trajectoryImage);
      heatMapButton = new HomeScreenButton("Heat Map", spacingX * 2.5 + graphButtonWidth * 1.5, 150 + graphButtonHeight + spacingY, graphButtonWidth, graphButtonHeight, heatMapImage);
      
      // Back button to return to home screen
      backButton = new HomeScreenButton("Back", width / 2 - 60, height - 100, 120, 50, null);
    }

    // Graph selection screen
    void draw() {
      background(planebackground);
      fill(0);
      textSize(32);
      textAlign(CENTER);
      text("Data Type Selection", width / 2, 80);

      barChartButton.display();
      pieChartButton.display();
      lineChartButton.display();
      trajectoryButton.display();
      heatMapButton.display();
      backButton.display();
    }
    
    void mousePressed() {
        if (barChartButton.isClicked(mouseX, mouseY)) {
          println("Bar Chart Screen");
        } else if (pieChartButton.isClicked(mouseX, mouseY)) {
          println("Pie Chart Screen");
        } else if (lineChartButton.isClicked(mouseX, mouseY)) {
          println("Line Chart Screen");
        } else if (trajectoryButton.isClicked(mouseX, mouseY)) {
          println("Flight Trajectory Screen");
        } else if (heatMapButton.isClicked(mouseX, mouseY)) {
          println("Heat Map Screen");
        } else if (backButton.isClicked(mouseX, mouseY)) {
          currentScreen = HOME_SCREEN; // Returns to home screen
        }
    }
}
