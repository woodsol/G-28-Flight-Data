import java.util.*;

class FlightPieChart {
  PImage planebackground, planeCursor;
  Table table;
  HashMap<String, Integer> stateCount = new HashMap<>();
  HashMap<String, Integer> stateColors = new HashMap<>();
  int numItems = 5; // Default number of states to show
  boolean sliderAdded = false;

  FlightPieChart() {
    table = loadTable("flights1k.csv", "csv");
  
    planebackground = loadImage("planebackground.jpg");
    planebackground.resize(width, height);

    for (TableRow row : table.rows()) {
      String state = row.getString(5);
      stateCount.put(state, stateCount.getOrDefault(state, 0) + 1);
    }

    for (String state : stateCount.keySet()) {
      stateColors.put(state, color(random(255), random(255), random(255)));
    }
  }

  void draw() {
    if (!sliderAdded) {
      cp5.addSlider("numItems")
       .setPosition(50, 550)
       .setSize(500, 20)
       .setRange(1, 15)
       .setValue(5);
      sliderAdded = true;
    }
    background(planebackground);
    drawPieChart();
    cp5.draw();
  }

  void drawPieChart() {
    ArrayList<Map.Entry<String, Integer>> sortedStates = new ArrayList<>(stateCount.entrySet());
    Collections.sort(sortedStates, (a, b) -> b.getValue() - a.getValue());

    int totalFlights = 0;
    for (int i = 0; i < min(numItems, sortedStates.size()); i++) {
      totalFlights += sortedStates.get(i).getValue();
    }

    float lastAngle = 0;
    for (int i = 0; i < min(numItems, sortedStates.size()); i++) {
      Map.Entry<String, Integer> entry = sortedStates.get(i);
      float angle = map(entry.getValue(), 0, totalFlights, 0, PConstants.TWO_PI);

      fill(stateColors.get(entry.getKey()));
      arc(width/2, height/2, 300, 300, lastAngle, lastAngle + angle);

      float angleMid = lastAngle + angle / 2;
      float x = width / 2 + cos(angleMid) * 100;
      float y = height / 2 + sin(angleMid) * 100;

      fill(0);
      textSize(20);
      textAlign(PConstants.CENTER, PConstants.CENTER);
      text(entry.getKey(), x, y);

      textSize(40);
      text("Most popular airports", 500, 100);

      textSize(20);
      text("Number of airports", 130, 520);

      lastAngle += angle;
    }
  }

  // For ControlP5 slider
  void setNumItems(int val) {
    this.numItems = val;
  }
}
