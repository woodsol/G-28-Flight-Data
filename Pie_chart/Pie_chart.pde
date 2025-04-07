import controlP5.*;
import java.util.*;

class FlightPieChart {
  PApplet p;
  PImage planebackground, planeCursor;
  Table table;
  HashMap<String, Integer> stateCount = new HashMap<>();
  HashMap<String, Integer> stateColors = new HashMap<>();
  ControlP5 cp5;
  int numItems = 5; // Default number of states to show

  FlightPieChart(PApplet p) {
    this.p = p;
  }

  void setup() {
    table = p.loadTable("flights2k(1).csv", "csv");
  
    planebackground = p.loadImage("planebackground.jpg");
    planebackground.resize(p.width, p.height);
  
    planeCursor = p.loadImage("plane_cursor (1).png"); 
    planeCursor.resize(50, 50); 

    for (TableRow row : table.rows()) {
      String state = row.getString(5);
      stateCount.put(state, stateCount.getOrDefault(state, 0) + 1);
    }

    for (String state : stateCount.keySet()) {
      stateColors.put(state, p.color(p.random(255), p.random(255), p.random(255)));
    }

    cp5 = new ControlP5(p);
    cp5.addSlider("numItems")
       .setPosition(50, 550)
       .setSize(500, 20)
       .setRange(1, 15)
       .setValue(5);
  }

  void draw() {
    p.background(planebackground);
    drawPieChart();
    p.noCursor();
    p.image(planeCursor, p.mouseX - planeCursor.width / 2, p.mouseY - planeCursor.height / 2);
  }

  void drawPieChart() {
    ArrayList<Map.Entry<String, Integer>> sortedStates = new ArrayList<>(stateCount.entrySet());
    Collections.sort(sortedStates, (a, b) -> b.getValue() - a.getValue());

    int totalFlights = 0;
    for (int i = 0; i < p.min(numItems, sortedStates.size()); i++) {
      totalFlights += sortedStates.get(i).getValue();
    }

    float lastAngle = 0;
    for (int i = 0; i < p.min(numItems, sortedStates.size()); i++) {
      Map.Entry<String, Integer> entry = sortedStates.get(i);
      float angle = p.map(entry.getValue(), 0, totalFlights, 0, PConstants.TWO_PI);

      p.fill(stateColors.get(entry.getKey()));
      p.arc(p.width/2, p.height/2, 300, 300, lastAngle, lastAngle + angle);

      float angleMid = lastAngle + angle / 2;
      float x = p.width / 2 + p.cos(angleMid) * 100;
      float y = p.height / 2 + p.sin(angleMid) * 100;

      p.fill(0);
      p.textSize(20);
      p.textAlign(PConstants.CENTER, PConstants.CENTER);
      p.text(entry.getKey(), x, y);

      p.textSize(40);
      p.text("Most popular airports", 500, 100);

      p.textSize(20);
      p.text("Number of airports", 130, 520);

      lastAngle += angle;
    }
  }

  // For ControlP5 slider
  void setNumItems(int val) {
    this.numItems = val;
  }
}
