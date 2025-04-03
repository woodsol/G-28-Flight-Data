PFont font;
Button searchFlightsButton, graphsButton;
Button barChartButton, pieChartButton, lineChartButton, trajectoryButton, heatMapButton, backButton;
PImage searchImage, graphsImage, planebackground;
PImage barChartImage, pieChartImage, lineChartImage, trajectoryImage, heatMapImage;
PImage planeCursor;
String currentScreen = "HOME"; // Tracks which screen the user is currently on

void setup() {
  size(800, 600);
  font = createFont("Arial", 16, true);
  textFont(font);

  // Load images for UI elements
  searchImage = loadImage("search.jpeg");
  graphsImage = loadImage("graphs.png");
  planebackground = loadImage("planebackground.jpg");
  planebackground.resize(width, height);

  barChartImage = loadImage("barChartImage2.png");
  pieChartImage = loadImage("pieChartImage2.png");
  lineChartImage = loadImage("lineChartImage2.png");
  trajectoryImage = loadImage("flightTrajectoryImage2.png");
  heatMapImage = loadImage("heatMapImage2.png");

  planeCursor = loadImage("planeCursor.png"); // Custom cursor image

  // Create main menu buttons
  float buttonWidth = 240 * 1.5;
  float buttonHeight = 140 * 1.5;
  float spacing = (width - (2 * buttonWidth)) / 3;
  searchFlightsButton = new Button("Search Flights", spacing, 180, buttonWidth, buttonHeight, searchImage);
  graphsButton = new Button("Graphs", spacing * 2 + buttonWidth, 180, buttonWidth, buttonHeight, graphsImage);

  // Create graph selection buttons
  float graphButtonWidth = 160 * 1.5;
  float graphButtonHeight = 90 * 1.5;
  float spacingX = (width - (3 * graphButtonWidth)) / 4;
  float spacingY = 50;

  barChartButton = new Button("Bar Chart", spacingX, 150, graphButtonWidth, graphButtonHeight, barChartImage);
  pieChartButton = new Button("Pie Chart", spacingX * 2 + graphButtonWidth, 150, graphButtonWidth, graphButtonHeight, pieChartImage);
  lineChartButton = new Button("Line Chart", spacingX * 3 + graphButtonWidth * 2, 150, graphButtonWidth, graphButtonHeight, lineChartImage);
  trajectoryButton = new Button("Trajectory", spacingX * 1.5 + graphButtonWidth * 0.5, 150 + graphButtonHeight + spacingY, graphButtonWidth, graphButtonHeight, trajectoryImage);
  heatMapButton = new Button("Heat Map", spacingX * 2.5 + graphButtonWidth * 1.5, 150 + graphButtonHeight + spacingY, graphButtonWidth, graphButtonHeight, heatMapImage);
  
  // Back button to return to home screen
  backButton = new Button("Back", width / 2 - 60, height - 100, 120, 50, null);
}

void draw() {
  // Determines which screen to display
  if (currentScreen.equals("HOME")) {
    drawHomeScreen();
  } else if (currentScreen.equals("SEARCH")) {
    drawSearchFlightsScreen();
  } else if (currentScreen.equals("GRAPHS")) {
    drawGraphsScreen();
  }

  // Draws custom plane cursor instead of the default cursor
  image(planeCursor, mouseX - 16, mouseY - 16, 32, 32);
  noCursor(); // Hides the system cursor
}

// Home screen with main menu buttons
void drawHomeScreen() {
  background(planebackground);
  fill(0);
  textSize(32);
  textAlign(CENTER);
  text("Flight UI Dashboard", width / 2, 100);

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

// Graph selection screen
void drawGraphsScreen() {
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

// Handles button clicks
void mousePressed() {
  if (currentScreen.equals("HOME")) {
    if (searchFlightsButton.isClicked(mouseX, mouseY)) {
      currentScreen = "SEARCH";
    } else if (graphsButton.isClicked(mouseX, mouseY)) {
      currentScreen = "GRAPHS";
    }
  } else if (currentScreen.equals("GRAPHS")) {
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
      currentScreen = "HOME"; // Returns to home screen
    }
  } else if (currentScreen.equals("SEARCH")) {
    if (backButton.isClicked(mouseX, mouseY)) {
      currentScreen = "HOME"; // Returns to home screen
    }
  }
}

// Button class
class Button {
  String label;
  float x, y, w, h;
  PImage img;
  boolean isHovered;

  Button(String label, float x, float y, float w, float h, PImage img) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = img;
  }

  // Displays the button with hover effects
  void display() {
    float displayX = x;
    float displayY = y;
    float displayW = w;
    float displayH = h;

    if (isHovered) {
      displayX -= 5; // Slightly shift position for smooth expansion
      displayY -= 5;
      displayW += 10; // Increase size on hover
      displayH += 10;
      strokeWeight(4); // Thicker outline when hovered
      stroke(50);
    } else {
      strokeWeight(2);
      stroke(0);
    }

    fill(255);
    rect(displayX, displayY, displayW, displayH, 20);

    if (img != null) {
      image(img, displayX + 10, displayY + 10, displayW - 20, displayH - 40);
    }
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, displayX + displayW / 2, displayY + displayH - 20);
  }

  // Checks if the button is clicked
  boolean isClicked(float mx, float my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }

  // Checks if the mouse is hovering over the button
  void checkHover(float mx, float my) {
    isHovered = mx > x && mx < x + w && my > y && my < y + h;
  }
}

// Updates hover states for buttons based on mouse movement
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
// New code written by Daniel Doolan and merged with Chrity Hosford's code at 10:44 am 03/04/2025
