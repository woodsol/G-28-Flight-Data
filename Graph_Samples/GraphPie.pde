// GraphPie class for pie chart
class GraphPie {
  int[] data = {10, 20, 30, 25, 15};
  String[] labels = {"A", "B", "C", "D", "E"};
  color[] pieColors; // Array to store the colors for each slice
  
  // Constructor to initialize the colors
  GraphPie() {
    pieColors = new color[data.length];
    for (int i = 0; i < data.length; i++) {
      pieColors[i] = color(random(255), random(255), random(255)); // Assign random color to each slice
    }
  }
  
  void draw(float xOffset, float yOffset) {
    float total = 0;
    for (int i = 0; i < data.length; i++) {
      total += data[i];
    }

    float angleStart = 0;
    for (int i = 0; i < data.length; i++) {
      float angle = map(data[i], 0, total, 0, TWO_PI);
      fill(pieColors[i]); // Use the pre-assigned color
      arc(xOffset + 150, yOffset + 150, 300, 300, angleStart, angleStart + angle);
      angleStart += angle;
    }
    
    fill(0);
    textSize(16);
    textAlign(CENTER, CENTER);
    angleStart = 0;
    for (int i = 0; i < data.length; i++) {
      float angle = map(data[i], 0, total, 0, TWO_PI);
      float x = xOffset + 150 + cos(angleStart + angle / 2) * 150;
      float y = yOffset + 150 + sin(angleStart + angle / 2) * 150;
      text(labels[i], x, y);
      angleStart += angle;
    }
  }
}
//All code added by Oliver Woods 12:20 17/03/2025
