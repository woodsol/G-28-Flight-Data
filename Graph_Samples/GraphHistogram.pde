// GraphHistogram class for histogram
class GraphHistogram {
  int[] data = {2, 5, 7, 10, 5, 3, 6, 7, 8, 9, 2, 4};
  int[] histogram = new int[10];
  
  void draw(float xOffset, float yOffset) {
    // Compute histogram values
    for (int i = 0; i < data.length; i++) {
      histogram[data[i] - 1]++;
    }
    
    // Draw histogram
    for (int i = 0; i < histogram.length; i++) {
      float barHeight = map(histogram[i], 0, max(histogram), 0, 200);
      fill(100, 150, 255);
      rect(xOffset + i * 40, yOffset + 200 - barHeight, 30, barHeight);
    }
  }
}
//All code added by Oliver Woods 12:20 17/03/2025
