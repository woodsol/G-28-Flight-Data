import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import controlP5.*; // Import ControlP5 for the slider

class FlightPieChart {

  PImage planebackground, planeCursor;
  Table table;
  HashMap<String, Integer> stateCount = new HashMap<>();
  HashMap<String, Integer> stateColors = new HashMap<>();
  ControlP5 cp5;
  int numItems = 5; // Default number of states to show
  
  
  
  void setup() {
    size(1000, 600);
    table = loadTable("flights2k(1).csv", "csv");
    
    planebackground = loadImage("planebackground.jpg");
    planebackground.resize(width, height);
    
    planeCursor = loadImage("plane_cursor (1).png"); 
    planeCursor.resize(50, 50); 
    
    // Count occurrences of each state
    for (TableRow row : table.rows()) {
      String state = row.getString(5); // Departure state
      stateCount.put(state, stateCount.getOrDefault(state, 0) + 1);
    }
    
    // Assign colors **once** for each state
    for (String state : stateCount.keySet()) {
      stateColors.put(state, color(random(255), random(255), random(255)));
    }
  
    // Create a slider for adjusting the number of items shown
    cp5 = new ControlP5(this);
    cp5.addSlider("numItems")
       .setPosition(50, 550)
       .setSize(500, 20)
       .setRange(1, 15) // Limit between 1 and 20 items
       .setValue(5);    // Default value
  }
  
  void draw() {
    background(planebackground);
    drawPieChart();
    noCursor();
    image(planeCursor, mouseX - planeCursor.width / 2, mouseY - planeCursor.height / 2);
  }
    
    
   
  void drawPieChart() {
    ArrayList<Map.Entry<String, Integer>> sortedStates = new ArrayList<>(stateCount.entrySet());
    Collections.sort(sortedStates, (a, b) -> b.getValue() - a.getValue()); // Sort by flight count
  
    int totalFlights = 0;
    for (int i = 0; i < min(numItems, sortedStates.size()); i++) {
      totalFlights += sortedStates.get(i).getValue();
    }
  
    float lastAngle = 0;
    for (int i = 0; i < min(numItems, sortedStates.size()); i++) {
      Map.Entry<String, Integer> entry = sortedStates.get(i);
      float angle = map(entry.getValue(), 0, totalFlights, 0, TWO_PI);
  
      fill(stateColors.get(entry.getKey())); // Use stored color instead of randomizing every frame
      arc(width/2, height/2, 300, 300, lastAngle, lastAngle + angle);
      
      float angleMid = lastAngle + angle / 2; // Middle of the slice
      float x = width / 2 + cos(angleMid) * 100; // X position for the label
      float y = height / 2 + sin(angleMid) * 100; // Y position for the label
      
      fill(0); // Black text
      textSize(20);
      textAlign(CENTER, CENTER);
      text(entry.getKey(), x, y); // Display state abbreviation at calculated position
      textSize(40);
      text("Most popular airports", 500, 100);
      textSize(20);
      text("Number of airports", 130, 520);
      
      lastAngle += angle;
    }
  }
}
