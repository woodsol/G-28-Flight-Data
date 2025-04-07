GraphLine graphLine;
boolean animationRunning = false;
float[] distanceArray;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

// Database
Table table;
ArrayList<Float> flightDistances = new ArrayList<Float>();
ArrayList<String> flightLabels = new ArrayList<>();

PImage planebackground, planeCursor;

void setup()
{
  size(1000, 600);
  smooth();
  
  table = loadTable("flights2k(1).csv", "csv");
  
  planebackground = loadImage("planebackground.jpg");
  planebackground.resize(width, height);
    
  planeCursor = loadImage("plane_cursor (1).png"); 
  planeCursor.resize(50, 50); 
  
  HashSet<String> uniqueFlights = new HashSet<>();
  
  for (int i = 1; i < table.getRowCount(); i++) 
  {
    TableRow row = table.getRow(i);
    float distance = row.getFloat(17); // Distance
    String destination = row.getString(4); 
    String arrival = row.getString(8); 
    
    // Create a unique key for each flight as "Destination → Arrival"
    String flightKey = destination + " → " + arrival;
    
    if (!uniqueFlights.contains(flightKey)) 
    {
      uniqueFlights.add(flightKey);
      flightDistances.add(distance);
      flightLabels.add(flightKey); 
    }
  }
  
  ArrayList<FlightData> flightDataList = new ArrayList<>();
  for (int i = 0; i < flightDistances.size(); i++) 
  {
    flightDataList.add(new FlightData(flightDistances.get(i), flightLabels.get(i)));
  }
  
  Collections.sort(flightDataList, (a, b) -> Float.compare(b.distance, a.distance));
  
  // Get the top 10 distances and labels
  int topCount = min(10, flightDataList.size());
  distanceArray = new float[topCount];
  String[] labelsArray = new String[topCount];
  for (int i = 0; i < topCount; i++) 
  {
    distanceArray[i] = flightDataList.get(i).distance;
    labelsArray[i] = flightDataList.get(i).label;
  }
  
  graphLine = new GraphLine(distanceArray, labelsArray, 500, 1000);
}

void draw()
{
  background(planebackground); 
  
  noCursor();
  image(planeCursor, mouseX - planeCursor.width / 2, mouseY - planeCursor.height / 2);

    fill(0);
    textAlign(LEFT, CENTER);
    textSize(24);
    text("Click to animate the top 10 flight distances", 300, 150);
    textSize(12);
    
  graphLine.drawAnimated(350, 200);
  
  if (mousePressed && !animationRunning) 
  {
    graphLine.startAnimation();
    animationRunning = true;
  }
  
  if (animationRunning) 
  {
    graphLine.updateAnimation();
    
    if (graphLine.isAnimationComplete()) 
    {
      animationRunning = false;
    }
  } 
  else 
  {
   
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
