final int MAIN = 0;
final int BAR_CHART = 1;
final int LINE_CHART = 2;
final int TRAJECTORY = 3;
final int HEAT_MAP = 4;
final int PIE_CHART = 5;

FlightTrajectoryMap flightTrajectory;
FlightBarChart barChart;
FlightHeatMap heatMap;
FlightPieChart pieChart;
FlightLineChart lineChart;

class GraphScreen {
    int subScreen = 0;
    GraphScreen() {
      flightTrajectory = new FlightTrajectoryMap();
      barChart = new FlightBarChart();
      heatMap = new FlightHeatMap();
      pieChart = new FlightPieChart();
      lineChart = new FlightLineChart();

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
        switch (subScreen) {
            case MAIN:
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
                break;
            case TRAJECTORY:
                flightTrajectory.draw();
                backButton.display();
                break;
            case HEAT_MAP:
                heatMap.draw();
                backButton.display();
                break;
            case PIE_CHART:
                pieChart.draw();
                backButton.display();
                break;
            case BAR_CHART:
                barChart.draw();
                backButton.display();
                break;
            case LINE_CHART:
                lineChart.draw();
                backButton.display();
                break;
        }
    }
    
    void mousePressed() {
        if (subScreen == MAIN) {
            if (barChartButton.isClicked(mouseX, mouseY)) {
              subScreen = BAR_CHART;
            } else if (pieChartButton.isClicked(mouseX, mouseY)) {
              subScreen = PIE_CHART;
            } else if (lineChartButton.isClicked(mouseX, mouseY)) {
              subScreen = LINE_CHART;
            } else if (trajectoryButton.isClicked(mouseX, mouseY)) {
              subScreen = TRAJECTORY;
            } else if (heatMapButton.isClicked(mouseX, mouseY)) {
              subScreen = HEAT_MAP;
            } else if (backButton.isClicked(mouseX, mouseY)) {
              currentScreen = HOME_SCREEN; // Returns to home screen
            }
        } else {
            if (subScreen == TRAJECTORY) {
                flightTrajectory.mousePressed();
            }
            if (backButton.isClicked(mouseX, mouseY)) {
                subScreen = MAIN;
            }
        }
    }

    void keyPressed() {
        switch (subScreen) {
            case TRAJECTORY:
                flightTrajectory.keyPressed();
                break;
        }
    }

    void mouseWheel(MouseEvent event) {
        switch (subScreen) {
            case TRAJECTORY:
                flightTrajectory.mouseWheel(event);
                break;
        }
    }


    void mouseMoved() {
        if (subScreen == MAIN) {
          searchFlightsButton.checkHover(mouseX, mouseY);
          graphsButton.checkHover(mouseX, mouseY);
          barChartButton.checkHover(mouseX, mouseY);
          pieChartButton.checkHover(mouseX, mouseY);
          lineChartButton.checkHover(mouseX, mouseY);
          trajectoryButton.checkHover(mouseX, mouseY);
          heatMapButton.checkHover(mouseX, mouseY);
          backButton.checkHover(mouseX, mouseY);
        }
    }

    void numItems(int val) {
        pieChart.setNumItems(val);
    }
}
