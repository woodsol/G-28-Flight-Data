HomeScreenButton searchFlightsButton, graphsButton;
HomeScreenButton barChartButton, pieChartButton, lineChartButton, trajectoryButton, heatMapButton, backButton;
PImage searchImage, graphsImage, planebackground;
PImage barChartImage, pieChartImage, lineChartImage, trajectoryImage, heatMapImage;

class HomeScreen {
    PFont font;
    
    HomeScreen(PFont font) {
      this.font = font;
      textFont(font);

      // Load images for UI elements
      searchImage = loadImage("search.jpeg");
      graphsImage = loadImage("graphs.png");
      planebackground = loadImage("planebackground.jpg");
      planebackground.resize(width, height);


      // Create main menu buttons
      float buttonWidth = 240 * 1.5;
      float buttonHeight = 140 * 1.5;
      float spacing = (width - (2 * buttonWidth)) / 3;
      searchFlightsButton = new HomeScreenButton("Search Flights", spacing, 180, buttonWidth, buttonHeight, searchImage);
      graphsButton = new HomeScreenButton("Graphs", spacing * 2 + buttonWidth, 180, buttonWidth, buttonHeight, graphsImage);

      // Create graph selection buttons
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

    // Home screen with main menu buttons
    void draw() {
      background(planebackground);
      fill(0);
      textSize(32);
      textAlign(CENTER);
      text("Flight Dashboard", width / 2, 100);
      
      searchFlightsButton.display();
      graphsButton.display();
    }

    // Search flights screen
    void drawSearchFlightsScreen() {
      background(planebackground);
      fill(0);
      textSize(24);
      textAlign(LEFT);
      text("Search Flights", 100, 100);
      backButton.display();
    }

    int handleMousePress() {
        if (searchFlightsButton.isClicked(mouseX, mouseY)) {
            return 1;// SEARCH
        } else if (graphsButton.isClicked(mouseX, mouseY)) {
            return 4; // GRAPHS
        }

        return -1;
    }

    void mouseMoved() {
        searchFlightsButton.checkHover(mouseX, mouseY);
        graphsButton.checkHover(mouseX, mouseY);
        barChartButton.checkHover(mouseX, mouseY);
        pieChartButton.checkHover(mouseX, mouseY);
        lineChartButton.checkHover(mouseX, mouseY);
        trajectoryButton.checkHover(mouseX, mouseY);
        heatMapButton.checkHover(mouseX, mouseY);
        backButton.checkHover(mouseX, mouseY);
    }

    // // Handles button clicks
    // void mousePressed() {
    //   if (currentScreen.equals("HOME")) {
    //     if (searchFlightsButton.isClicked(mouseX, mouseY)) {
    //       currentScreen = "SEARCH";
    //     } else if (graphsButton.isClicked(mouseX, mouseY)) {
    //       currentScreen = "GRAPHS";
    //     }
    //   } else if (currentScreen.equals("GRAPHS")) {
    //     if (barChartButton.isClicked(mouseX, mouseY)) {
    //       println("Bar Chart Screen");
    //     } else if (pieChartButton.isClicked(mouseX, mouseY)) {
    //       println("Pie Chart Screen");
    //     } else if (lineChartButton.isClicked(mouseX, mouseY)) {
    //       println("Line Chart Screen");
    //     } else if (trajectoryButton.isClicked(mouseX, mouseY)) {
    //       println("Flight Trajectory Screen");
    //     } else if (heatMapButton.isClicked(mouseX, mouseY)) {
    //       println("Heat Map Screen");
    //     } else if (backButton.isClicked(mouseX, mouseY)) {
    //       currentScreen = "HOME"; // Returns to home screen
    //     }
    //   } else if (currentScreen.equals("SEARCH")) {
    //     if (backButton.isClicked(mouseX, mouseY)) {
    //       currentScreen = "HOME"; // Returns to home screen
    //     }
    //   }
    // }

}
// New code written by Daniel Doolan and merged with Chrity Hosford's code at 10:44 am 03/04/2025
