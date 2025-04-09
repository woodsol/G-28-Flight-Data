import controlP5.*;
import java.util.*;

class FlightBarChart {
  PApplet p;
  PImage planebackground, planeCursor;
  Table table;
  HashMap<String, Integer> stateCount = new HashMap<>();
  HashMap<String, Integer> stateColors = new HashMap<>();
  ControlP5 cp5;
  int numItems = 5; // Default number of states to show
  float[] barHeights; // To store the current heights of bars for animation
  float[] targetHeights; // Final target heights for the bars

  FlightBarChart(PApplet p) {
    this.p = p;
  }

  void setup() {
    table = p.loadTable("flights2k(1).csv", "csv");

    planebackground = p.loadImage("planebackground.jpg");
    planebackground.resize(p.width, p.height);

    planeCursor = p.loadImage("plane_cursor (1).png"); 
    planeCursor.resize(50, 50); 

    for (TableRow row : table.rows()) {
      String state = row.getString(5); // Column 5 contains the state
      stateCount.put(state, stateCount.getOrDefault(state, 0) + 1);
    }

    // Assign random colors to each state
    for (String state : stateCount.keySet()) {
      stateColors.put(state, p.color(p.random(255), p.random(255), p.random(255)));
    }

    // Initialize the arrays for bar heights
    barHeights = new float[numItems];
    targetHeights = new float[numItems];
  }

  void draw() {
    p.background(planebackground);
    drawBarChart();
    p.noCursor();
    p.image(planeCursor, p.mouseX - planeCursor.width / 2, p.mouseY - planeCursor.height / 2);
  }

  // Draw bar chart with X and Y axes
  void drawBarChart() {
    ArrayList<Map.Entry<String, Integer>> sortedStates = new ArrayList<>(stateCount.entrySet());
    Collections.sort(sortedStates, (a, b) -> b.getValue() - a.getValue());

    int totalFlights = 0;
    for (int i = 0; i < p.min(numItems, sortedStates.size()); i++) {
      totalFlights += sortedStates.get(i).getValue();
    }

    int barWidth = 80;
    int barSpacing = 150;
    int chartHeight = p.height - 150; // Adjust the height of the chart

    // Draw bars
    for (int i = 0; i < p.min(numItems, sortedStates.size()); i++) {
      Map.Entry<String, Integer> entry = sortedStates.get(i);
      float targetHeight = p.map(entry.getValue(), 0, totalFlights, 0, chartHeight); // Scale the height

      // Animate the bar height using lerp
      barHeights[i] = p.lerp(barHeights[i], targetHeight, 0.1f); // Smooth transition to the target height

      p.fill(stateColors.get(entry.getKey())); // Use stored color
      p.rect(100 + i * barSpacing, p.height - barHeights[i] - 50, barWidth, barHeights[i]); // Draw the bars

      // Display the state abbreviation and its count
      p.fill(0); // Black text
      p.textSize(12);
      p.textAlign(PConstants.CENTER, PConstants.CENTER);
      p.text(entry.getKey(), 100 + i * barSpacing + barWidth / 2, p.height - 35); // State abbreviation
      p.textSize(14);
      p.text(entry.getValue(), 100 + i * barSpacing + barWidth / 2, p.height - barHeights[i] - 60); // Flight count
    }

    // Draw the title and labels
    p.textSize(20);
    p.textAlign(PConstants.CENTER, PConstants.CENTER);
    p.text("Most Popular Departure States", p.width / 2, 50); // Title

    p.textSize(16);
    p.text("Number of Flights", 90, p.height - 560); // Label for flights

    drawAxes(); // Call to draw X and Y axes
  }

  // Draw X and Y axes with labels
  void drawAxes() {
    p.stroke(0); // Black color for axis lines

    // Draw the Y-axis (vertical line)
    p.line(50, p.height - 50, 50, 50); // Y-axis from (50, p.height-100) to (50, 50)

    // Draw the X-axis (horizontal line)
    p.line(50, p.height - 50, p.width - 50, p.height - 50); // X-axis from (50, p.height-100) to (p.width-50, p.height-100)

    // Y-axis labels (flight counts)
    int maxFlights = Collections.max(stateCount.values());
    int yInterval = 40; // Increased interval between numbers (e.g., 40 instead of 20)
    int tickInterval = 1000; // Decreased interval for the distance between each tick mark

    for (int i = 0; i <= maxFlights; i += yInterval) {
      float yPos = p.map(i, 0, maxFlights, p.height - 100, 50); // Map flight count to y-axis position
      p.line(45, yPos, 50, yPos); // Tick mark on Y-axis

    }

    // X-axis labels (states)
    ArrayList<Map.Entry<String, Integer>> sortedStates = new ArrayList<>(stateCount.entrySet());
    Collections.sort(sortedStates, (a, b) -> b.getValue() - a.getValue());

    for (int i = 0; i < p.min(numItems, sortedStates.size()); i++) {
      String state = sortedStates.get(i).getKey();
      float xPos = 100 + i * 150 + 40; // Position for each state abbreviation
      p.textSize(12);
      p.textAlign(PConstants.CENTER, PConstants.CENTER);
      p.text(state, xPos, p.height - 85); // Label the X-axis with state abbreviations
    }
  }

  // For ControlP5 slider
  void setNumItems(int val) {
    this.numItems = val;
  }
}
