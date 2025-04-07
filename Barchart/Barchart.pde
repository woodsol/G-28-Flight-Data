import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.Collections;
import controlP5.*; // Import ControlP5 for the slider

class FlightBarChart extends PApplet {  // Ensure FlightBarChart extends PApplet

  PImage planebackground, planeCursor;
  Table table;
  HashMap<String, Integer> stateCount = new HashMap<>();
  HashMap<String, Integer> stateColors = new HashMap<>();
  ControlP5 cp5;
  int numItems = 5; // Default number of states to show
  
  float[] currentHeights;  // Array to store the animated heights of the bars
  float[] targetHeights;   // Array to store the target heights

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
    cp5 = new ControlP5(this);  // This now correctly passes the PApplet reference to ControlP5
    cp5.addSlider("numItems")
       .setPosition(50, 550)
       .setSize(500, 20)
       .setRange(1, 15) // Limit between 1 and 15 items
       .setValue(5);    // Default value

    // Initialize the heights for the bars
    currentHeights = new float[numItems];
    targetHeights = new float[numItems];
  }

  void draw() {
    background(planebackground);
    drawBarChart();
    noCursor();
    image(planeCursor, mouseX - planeCursor.width / 2, mouseY - planeCursor.height / 2);
  }

  void drawBarChart() {
    ArrayList<Map.Entry<String, Integer>> sortedStates = new ArrayList<>(stateCount.entrySet());
    Collections.sort(sortedStates, (a, b) -> b.getValue() - a.getValue()); // Sort by flight count
    
    // Calculate the total flight counts for the top states
    int totalFlights = 0;
    for (int i = 0; i < min(numItems, sortedStates.size()); i++) {
      totalFlights += sortedStates.get(i).getValue();
      targetHeights[i] = map(sortedStates.get(i).getValue(), 0, totalFlights, 0, height - 100); // Target heights
    }
    
    // Animate the bars' heights
    for (int i = 0; i < numItems; i++) {
      currentHeights[i] = lerp(currentHeights[i], targetHeights[i], 0.05); // Smooth transition

      // Get the state data
      Map.Entry<String, Integer> entry = sortedStates.get(i);
      float barWidth = (width - 100) / (float)numItems; // Bar width based on number of items
      float xPos = 50 + i * barWidth + 20; // X position for the bar
      float yPos = height - currentHeights[i] - 50; // Y position for the bar
      
      // Draw the bar
      fill(stateColors.get(entry.getKey()));
      rect(xPos, yPos, barWidth - 10, currentHeights[i]);
      
      // Draw the labels and values
      fill(0);
      textAlign(CENTER);
      textSize(12);
      text(entry.getKey(), xPos + barWidth / 2, height - 20);  // State abbreviation at X axis
      textSize(14);
      text(entry.getValue(), xPos + barWidth / 2, yPos - 10);  // Flight count above the bar
    }

    // Draw chart title
    fill(0);
    textSize(30);
    textAlign(CENTER, CENTER);
    text("Top States by Flight Count", width / 2, 50);
  }

  void mousePressed() {
    // Randomly adjust the target heights when the mouse is pressed
    ArrayList<Map.Entry<String, Integer>> sortedStates = new ArrayList<>(stateCount.entrySet());
    Collections.sort(sortedStates, (a, b) -> b.getValue() - a.getValue());
    
    // Randomize the top states' target heights
    for (int i = 0; i < min(numItems, sortedStates.size()); i++) {
      targetHeights[i] = random(50, height - 100); // Set random target heights
    }
  }
  
  public static void main(String[] args) {
    PApplet.main("FlightBarChart");  // Start the Processing sketch from here
  }
}
