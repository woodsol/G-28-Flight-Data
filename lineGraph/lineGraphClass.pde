class FlightDistanceVisualizer {
  GraphLine graphLine;
  boolean animationRunning = false;
  float[] distanceArray;
  
  PImage planebackground, planeCursor;
  
  Table table;
  ArrayList<Float> flightDistances;
  ArrayList<String> flightLabels;
  
  int xPos, yPos;
  int graphWidth, graphHeight;
  
  public FlightDistanceVisualizer(int x, int y, int w, int h) {
    xPos = x;
    yPos = y;
    graphWidth = w;
    graphHeight = h;
    
    flightDistances = new ArrayList<Float>();
    flightLabels = new ArrayList<String>();
    
    loadData();
    processData();
  }
  
  private void loadData() {
    table = loadTable("flights2k(1).csv", "csv");
  }
  
  private void processData() {
    HashSet<String> uniqueFlights = new HashSet<>();
    
    for (int i = 1; i < table.getRowCount(); i++) {
      TableRow row = table.getRow(i);
      float distance = row.getFloat(17); // Distance
      String destination = row.getString(4); 
      String arrival = row.getString(8); 
      
      String flightKey = destination + " → " + arrival;
      
      if (!uniqueFlights.contains(flightKey)) {
        uniqueFlights.add(flightKey);
        flightDistances.add(distance);
        flightLabels.add(flightKey); 
      }
    }
    
    ArrayList<FlightData> flightDataList = new ArrayList<>();
    for (int i = 0; i < flightDistances.size(); i++) {
      flightDataList.add(new FlightData(flightDistances.get(i), flightLabels.get(i)));
    }
    
    Collections.sort(flightDataList, (a, b) -> Float.compare(b.distance, a.distance));
    
    int topCount = min(10, flightDataList.size());
    distanceArray = new float[topCount];
    String[] labelsArray = new String[topCount];
    for (int i = 0; i < topCount; i++) {
      distanceArray[i] = flightDataList.get(i).distance;
      labelsArray[i] = flightDataList.get(i).label;
    }
    
    graphLine = new GraphLine(distanceArray, labelsArray, graphWidth, graphHeight);
  }
  
  public void draw() {
    pushMatrix();
    translate(xPos, yPos);
    
    fill(0);
    textAlign(LEFT, CENTER);
    text("Click to animate the top 10 flight distances", 50, 30);
    
    graphLine.drawAnimated(100, 100);
    
    if (mousePressed && !animationRunning) {
      graphLine.startAnimation();
      animationRunning = true;
    }
    
    if (animationRunning) {
      graphLine.updateAnimation();
      
      if (graphLine.isAnimationComplete()) {
        animationRunning = false;
      }
    }
    
    popMatrix();
  }
  
  public void mousePressed() {
    if (!animationRunning) {
      graphLine.startAnimation();
      animationRunning = true;
    }
  }
  
  class FlightData {
    float distance;
    String label;

    FlightData(float distance, String label) {
      this.distance = distance;
      this.label = label;
    }
  }
}

// Then in your main sketch you would use it like this:
/*
FlightDistanceVisualizer visualizer;

void setup() {
  size(600, 600);
  smooth();
  visualizer = new FlightDistanceVisualizer(0, 0, width - 200, height - 200);
}

void draw() {
  background(255);
  visualizer.draw();
}

void mousePressed() {
  visualizer.mousePressed();
}
*/
