import java.util.*;

class FlightBarChart {
  PImage planebackground, planeCursor;
  Table table;
  HashMap<String, Integer> stateCount = new HashMap<>();
  HashMap<String, Integer> stateColors = new HashMap<>();
  int numItems = 5; // Default number of states to show
  float[] barHeights; // To store the current heights of bars for animation
  float[] targetHeights; // Final target heights for the bars

  FlightBarChart() {
    table = loadTable("flights1k.csv", "csv");

    planebackground = loadImage("planebackground.jpg");
    planebackground.resize(width, height);

    for (TableRow row : table.rows()) {
      String state = row.getString(5); // Column 5 contains the state
      stateCount.put(state, stateCount.getOrDefault(state, 0) + 1);
    }

    // Assign random colors to each state
    for (String state : stateCount.keySet()) {
      stateColors.put(state, color(random(255), random(255), random(255)));
    }

    // Initialize the arrays for bar heights
    barHeights = new float[numItems];
    targetHeights = new float[numItems];
  }

  void draw() {
    background(planebackground);
    drawBarChart();
  }

  // Draw bar chart with X and Y axes
  void drawBarChart() {
    ArrayList<Map.Entry<String, Integer>> sortedStates = new ArrayList<>(stateCount.entrySet());
    Collections.sort(sortedStates, (a, b) -> b.getValue() - a.getValue());

    int totalFlights = 0;
    for (int i = 0; i < min(numItems, sortedStates.size()); i++) {
      totalFlights += sortedStates.get(i).getValue();
    }

    int barWidth = 80;
    int barSpacing = 150;
    int chartHeight = height - 150; // Adjust the height of the chart

    // Draw bars
    for (int i = 0; i < min(numItems, sortedStates.size()); i++) {
      Map.Entry<String, Integer> entry = sortedStates.get(i);
      float targetHeight = map(entry.getValue(), 0, totalFlights, 0, chartHeight); // Scale the height

      // Animate the bar height using lerp
      barHeights[i] = lerp(barHeights[i], targetHeight, 0.1f); // Smooth transition to the target height

      fill(stateColors.get(entry.getKey())); // Use stored color
      rect(100 + i * barSpacing, height - barHeights[i] - 50, barWidth, barHeights[i]); // Draw the bars

      // Display the state abbreviation and its count
      fill(0); // Black text
      textSize(12);
      textAlign(PConstants.CENTER, PConstants.CENTER);
      text(entry.getKey(), 100 + i * barSpacing + barWidth / 2, height - 35); // State abbreviation
      textSize(14);
      text(entry.getValue(), 100 + i * barSpacing + barWidth / 2, height - barHeights[i] - 60); // Flight count
    }

    // Draw the title and labels
    textSize(20);
    textAlign(PConstants.CENTER, PConstants.CENTER);
    text("Most Popular Departure States", width / 2, 50); // Title

    textSize(16);
    text("Number of Flights", 90, height - 560); // Label for flights

    drawAxes(); // Call to draw X and Y axes
  }

  // Draw X and Y axes with labels
  void drawAxes() {
    stroke(0); // Black color for axis lines

    // Draw the Y-axis (vertical line)
    line(50, height - 50, 50, 50); // Y-axis from (50, height-100) to (50, 50)

    // Draw the X-axis (horizontal line)
    line(50, height - 50, width - 50, height - 50); // X-axis from (50, p.height-100) to (p.width-50, p.height-100)

    // Y-axis labels (flight counts)
    int maxFlights = Collections.max(stateCount.values());
    int yInterval = 40; // Increased interval between numbers (e.g., 40 instead of 20)
    int tickInterval = 1000; // Decreased interval for the distance between each tick mark

    for (int i = 0; i <= maxFlights; i += yInterval) {
      float yPos = map(i, 0, maxFlights, height - 100, 50); // Map flight count to y-axis position
      line(45, yPos, 50, yPos); // Tick mark on Y-axis

    }

    // X-axis labels (states)
    ArrayList<Map.Entry<String, Integer>> sortedStates = new ArrayList<>(stateCount.entrySet());
    Collections.sort(sortedStates, (a, b) -> b.getValue() - a.getValue());

    for (int i = 0; i < min(numItems, sortedStates.size()); i++) {
      String state = sortedStates.get(i).getKey();
      float xPos = 100 + i * 150 + 40; // Position for each state abbreviation
      textSize(12);
      textAlign(PConstants.CENTER, PConstants.CENTER);
      text(state, xPos, height - 85); // Label the X-axis with state abbreviations
    }
  }

  // For ControlP5 slider
  void setNumItems(int val) {
    this.numItems = val;
  }
}
