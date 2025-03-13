// widget class 
class Widget {
  int x, y, width, height;   // Position and size of the widget
  String label;              // Label text displayed on the widget
  color widgetColor;         // Color of the widget (used for filling)
  boolean hover;             // State to track whether the widget is hovered over
  
  // initialize a new widget with position, size, and label
  Widget(int x, int y, int width, int height, String label) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.label = label;
    this.widgetColor = color(200);  // Default color is light gray
    this.hover = false;  // Initially, the widget is not being hovered
  }
  
  // draws the widget on the screen
  void draw() {
    // Part 2: Change border color based on hover state
    if (hover) {
      stroke(255); // White border when hovering
    } else {
      stroke(0);   // Black border normally
    }
    
    fill(widgetColor);  // Fill the widget with its color
    rect(x, y, width, height);  // Draw the rectangle (widget) at specified position
    
    fill(0);  // Set text color to black
    textAlign(CENTER, CENTER);  // Align text in the center
    text(label, x + width/2, y + height/2);  // Display the label in the center of the widget
  }
  
  // checks if the mouse position (mx, my) is inside the widget's bounds
  boolean isInside(int mx, int my) {
    return (mx >= x && mx <= x + width && my >= y && my <= y + height);
  }
}

// screen class manages a collection of widgets and handles screen drawing and event detection
class Screen {
  ArrayList<Widget> widgets;   // List of widgets on the screen
  color backgroundColor;       // Background color of the screen
  
  // Constructor to initialize a screen with a background color
  Screen(color backgroundColor) {
    this.backgroundColor = backgroundColor;
    this.widgets = new ArrayList<Widget>();  // Initialize the widget list
  }
  
  // adds a widget to the screen's list
  void addWidget(Widget w) {
    widgets.add(w);
  }
  
  //checking if the mouse position is inside any widget
  Widget getEvent(int mx, int my) {
    for (Widget w : widgets) {
      if (w.isInside(mx, my)) {
        return w;  // Return the widget if the mouse is inside it
      }
    }
    return null; // Return null if no widget was clicked
  }
  
  // draws the screen's background and all the widgets
  void draw() {
    background(backgroundColor);  // Set background color
    for (Widget w : widgets) {
      w.draw();  // Draw each widget on the screen
    }
  }
  
  // updates the hover state of each widget based on the mouse position
  void checkHover(int mx, int my) {
    for (Widget w : widgets) {
      w.hover = w.isInside(mx, my);  // Set hover state based on mouse position
    }
  }
}

// global variables to manage screens and UI elements
Screen screen1, screen2, screen3, screen4, screen5, screen6, currentScreen;  // Two screens and a reference to the current screen
color squareColor;  // Color of the square displayed on screen 1

// setup() function is called once when the program starts
void setup() {
  size(400, 400);  // Set the canvas size
  squareColor = color(128);  // Default square color is gray
  
  // create screens with different background colors
  screen1 = new Screen(color(220, 220, 255));  // Light blue background
  screen2 = new Screen(color(255, 220, 220));  // Light pink background
  screen3 = new Screen(color(100, 100, 100));  // Light blue background
  screen4 = new Screen(color(10, 10, 10));  // Light pink background
  screen5 = new Screen(color(200, 200, 200));  // Light blue background
  screen6 = new Screen(color(20, 20, 20));  // Light pink background
  
  
  // create and add widgets for screen 1 (color buttons and navigation button)
  //Widget redButton = new Widget(50, 300, 80, 40, "red");
  //Widget greenButton = new Widget(160, 300, 80, 40, "green");
  //Widget blueButton = new Widget(270, 300, 80, 40, "blue");
  Widget nextButton2 = new Widget(150, 350, 100, 30, "Screen2");
  Widget nextButton3= new Widget(150, 350, 100, 30, "Screen3");
  Widget nextButton4= new Widget(150, 350, 100, 30, "Screen4");
  Widget nextButton5 = new Widget(150, 350, 100, 30, "Screen5");
  Widget nextButton6 = new Widget(150, 350, 100, 30, "Screen6");
  
  screen1.addWidget(nextButton2);  // Add next button for navigation
  screen2.addWidget(nextButton3);
  screen3.addWidget(nextButton4);
  screen4.addWidget(nextButton5);
  screen5.addWidget(nextButton6);

  
  
  // create and add widgets for screen 2 (back and action buttons)
  Widget backButton = new Widget(30, 30, 130, 40, "Back to Screen 1");
//  Widget actionButton = new Widget(210, 300, 140, 40, "Click Me");
  
  screen2.addWidget(backButton);
  screen3.addWidget(backButton);
  screen4.addWidget(backButton);
  screen5.addWidget(backButton);
  screen6.addWidget(backButton);  // Add back button and action button to screen 2
 // screen2.addWidget(actionButton);
  
  // set the initial screen to screen1
  currentScreen = screen1;
}

// draw() function is continuously called to render the content
void draw() {
  currentScreen.draw();  // Draw the current screen
  
  // draw the color square on screen 1, based on the selected color
  if (currentScreen == screen1) {
    fill(squareColor);  // Set square color to the selected color
  }
}

// Part 2 - handle mouse movement for hover effect
void mouseMoved() {
  currentScreen.checkHover(mouseX, mouseY);  // Update hover state when mouse moves
}

// handle mouse click events
void mousePressed() {
  Widget clicked = currentScreen.getEvent(mouseX, mouseY);  // Get widget under the mouse
  
  if (clicked != null) {
    // Handle navigation between screens
    if (clicked.label.equals("Screen2")) {
      currentScreen = screen2;  // Switch to screen 2
    }
    else if (clicked.label.equals("Back to Screen 1")) {
      currentScreen = screen1;  // Switch back to screen 1
    }
    else if (clicked.label.equals("Screen3")) {
      currentScreen = screen3;  // Switch to screen 3
    }
    else if (clicked.label.equals("Screen4")) {
      currentScreen = screen4;  // Switch to screen 4
    }
    else if (clicked.label.equals("Screen5")) {
      currentScreen = screen5;  // Switch to screen 5
    }
    else if (clicked.label.equals("Screen6")) {
      currentScreen = screen6;  // Switch to screen 6
    }
    // Handle color buttons on screen 1
    
    // Handle action button on screen 2
   
  }
}
