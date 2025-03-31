PFont font;
Button searchFlightsButton, graphsButton;
PImage searchImage, graphsImage, planebackground;
String currentScreen = "HOME";

void setup() {
  size(800, 600);
  font = createFont("Arial", 16, true);
  textFont(font);
  
  // Load images
  searchImage = loadImage("search.jpeg");
  graphsImage = loadImage("graphs.png");
  
  planebackground = loadImage("planebackground.jpg");
  planebackground.resize(width, height);
  
  // Initialize buttons with larger image areas
  float buttonWidth = 240 * 1.5; // Increase size by 1.5x
  float buttonHeight = 140 * 1.5;
  float spacing = (width - (2 * buttonWidth)) / 3; // Space between and on sides
  
  searchFlightsButton = new Button("Search Flights", spacing, 180, buttonWidth, buttonHeight, searchImage);
  graphsButton = new Button("Graphs", spacing * 2 + buttonWidth, 180, buttonWidth, buttonHeight, graphsImage);
}

void draw() {
  background(planebackground);
  
  if (currentScreen.equals("HOME")) {
    drawHomeScreen();
  } else if (currentScreen.equals("SEARCH")) {
    drawSearchFlightsScreen();
  } else if (currentScreen.equals("GRAPHS")) {
    drawGraphsScreen();
  }
}

void drawHomeScreen() {
  fill(0);
  textSize(32);
  textAlign(CENTER);
  text("Flight UI Dashboard", width / 2, 100);
  
  // Draw buttons
  searchFlightsButton.display();
  graphsButton.display();
}

void drawSearchFlightsScreen() {
  fill(0);
  textSize(24);
  textAlign(LEFT);
  text("Search Flights", 100, 100);
  // TODO: Add search input and display results
}

void drawGraphsScreen() {
  fill(0);
  textSize(24);
  textAlign(LEFT);
  text("Graphs", 100, 100);
  // TODO: Implement graph visualization
}

void mousePressed() {
  if (searchFlightsButton.isClicked(mouseX, mouseY)) {
    currentScreen = "SEARCH";
  } else if (graphsButton.isClicked(mouseX, mouseY)) {
    currentScreen = "GRAPHS";
  } 
}

class Button {
  String label;
  float x, y, w, h;
  PImage img;
  
  Button(String label, float x, float y, float w, float h, PImage img) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = img;
  }
  
  void display() {
    fill(255);
    rect(x, y, w, h, 20);
    if (img != null) {
      image(img, x + 10, y + 10, w - 20, h - 40);
    }
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x + w / 2, y + h - 20);
  }
  
  boolean isClicked(float mx, float my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }
}
