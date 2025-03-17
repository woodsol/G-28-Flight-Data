// GraphScatter class for scatter plot
class GraphScatter {
  float[][] points = {{50, 30}, {100, 80}, {150, 20}, {200, 90}, {250, 60}, {300, 110}, {350, 50}};
  
  void draw(float xOffset, float yOffset) {
    stroke(0);
    fill(255, 0, 0);
    for (int i = 0; i < points.length; i++) {
      ellipse(xOffset + points[i][0], yOffset + points[i][1], 10, 10);
    }
  }
}
//All code added by Oliver Woods 12:20 17/03/2025
