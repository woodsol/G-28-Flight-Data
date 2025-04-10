// GraphLine class for line graph
class GraphLine {
  float[] data;
  String[] labels;
  int xLength, yLength;
  float animationProgress; // goes from 0 to 1
  int lastAnimatedPoint; 
  int animationSpeed;
  
  GraphLine(float[] data, String labels[], int xLength, int yLength)
  {
    this.data = data;
    this.labels = labels;
    this.xLength = xLength;
    this.yLength = yLength;
    this.animationProgress = 0;
    this.lastAnimatedPoint = 0;
    this.animationSpeed = 1; 
  }
  
  void startAnimation() // sets/resets animation
  {
    animationProgress = 0.0;
    lastAnimatedPoint = 0;
  }
  
  void updateAnimation() { // use each frame 
    if (animationProgress < 1.0) 
    {
      animationProgress += 0.01; 
      lastAnimatedPoint = (int)(animationProgress * (data.length - 1));
      lastAnimatedPoint = constrain(lastAnimatedPoint, 0, data.length - 1);
    }
  }
  
  void drawAnimated(float xOffset, float yOffset) 
  {
    if (data.length == 0) return;
    
    float minVal = 4000;
    float maxVal = 5300;
    
    stroke(50);
    line(xOffset, yOffset + 250, xOffset + 400, yOffset + 250); 
    line(xOffset, yOffset, xOffset, yOffset + 250);
    
    stroke(0);
    noFill();
    
    for (int i = 0; i < lastAnimatedPoint; i++) {
    float x1 = map(i, 0, data.length - 1, xOffset, xOffset + 300);
    float y1 = map(data[i], minVal, maxVal, yOffset + 200, yOffset);
    float x2 = map(i + 1, 0, data.length - 1, xOffset, xOffset + 300);
    float y2 = map(data[i + 1], minVal, maxVal, yOffset + 200, yOffset);
    
    // Draw line segment between two points
    line(x1, y1, x2, y2);
    
    // Draw data points as red ellipses
    fill(255, 0, 0);
    ellipse(x1, y1, 5, 5);
    noFill();
    
    // Use the drawLabel method for label drawing
        if (labels != null && labels.length > i) 
        {
            drawLabel(x1, y1, labels[i], data[i]);
        }
    }
    
    if (lastAnimatedPoint > 0 && animationProgress < 1.0) {
      float headX = map(lastAnimatedPoint, 0, data.length - 1, xOffset, xOffset + 300);
      float headY = map(data[lastAnimatedPoint], minVal, maxVal, yOffset + 200, yOffset);
      fill(255, 0, 0);
      ellipse(headX, headY, 8, 8);
    }
  }
  
  boolean isAnimationComplete() 
  {
    return animationProgress >= 1.0;
  }
  
  void drawLabel(float x, float y, String label, float distance) {
    // Check if the mouse is hovering over the point
    if (dist(mouseX, mouseY, x, y) < 5) {
        textAlign(CENTER);
        fill(0);
        text(label + ", Distance: " + distance + "km", x, y - 15); 
    } else {
        noFill();
        stroke(150);
        ellipse(x, y, 10, 10); 
    }
}
}


// Code added by Oliver Woods 12:20 17/03/2025
