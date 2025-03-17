// GraphBar class for bar graph
class GraphBar {
  int[] data = {10, 20, 30, 25, 40, 35, 50};
  
  void draw(float xOffset, float yOffset) {
    noStroke();
    for (int i = 0; i < data.length; i++) {
      float x = map(i, 0, data.length, xOffset, xOffset + 300);
      float barHeight = map(data[i], 0, 50, 0, 200);
      fill(100, 150, 255);
      rect(x - 10, yOffset + 200 - barHeight, 20, barHeight);
    }
  }
}
//All code added by Oliver Woods 12:20 17/03/2025
