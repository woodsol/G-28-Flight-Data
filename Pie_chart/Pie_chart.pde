import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

Table table;
HashMap<String, Integer> stateCount = new HashMap<String, Integer>();

void setup() {
  size(600, 600);
  table = loadTable("flights2k(1).csv", "csv");
  
  // Read and count state occurrences
  for (TableRow row : table.rows()) {
    String state = row.getString(5); // Departure state
    stateCount.put(state, stateCount.getOrDefault(state, 0) + 1);
  }
  
  // Sort states by count
  ArrayList<Map.Entry<String, Integer>> sortedStates = new ArrayList<>(stateCount.entrySet());
  Collections.sort(sortedStates, (a, b) -> b.getValue() - a.getValue());
  
  // Get the top 5
  int totalFlights = 0;
  for (int i = 0; i < min(5, sortedStates.size()); i++) {
    totalFlights += sortedStates.get(i).getValue();
  }

  // Draw pie chart
  float lastAngle = 0;
  for (int i = 0; i < min(5, sortedStates.size()); i++) {
    Map.Entry<String, Integer> entry = sortedStates.get(i);
    float angle = map(entry.getValue(), 0, totalFlights, 0, TWO_PI);
    fill(color(random(255), random(255), random(255))); // Random color
    arc(width/2, height/2, 300, 300, lastAngle, lastAngle + angle);
    
    float angleMid = lastAngle + angle / 2; // Middle of the slice
    float x = width / 2 + cos(angleMid) * 100; // X position for the label
    float y = height / 2 + sin(angleMid) * 100; // Y position for the label
    
    fill(0); // Black text
    textSize(40);
    textAlign(CENTER, CENTER);
    text(entry.getKey(), x, y); // Display state abbreviation at calculated position
    
    lastAngle += angle;
  }
}
