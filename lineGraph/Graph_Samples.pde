
// GraphLine class for line graph
class GraphLine {
  int[] data;
  float animationProgress; // goes from 0 to 1
  int lastAnimatedPoint; 
  int animationSpeed;
  
  GraphLine(int[] data)
  {
    this.data = data;
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
    
    int minVal = min(data);
    int maxVal = max(data);
    
    stroke(150);
    line(xOffset, yOffset + 200, xOffset + 300, yOffset + 200); 
    line(xOffset, yOffset, xOffset, yOffset + 200);
    
    stroke(0);
    noFill();
    beginShape();
    for (int i = 0; i <= lastAnimatedPoint; i++) {
      float x = map(i, 0, data.length - 1, xOffset, xOffset + 300);
      float y = map(data[i], minVal, maxVal, yOffset + 200, yOffset);
      vertex(x, y);
      
      if (i == lastAnimatedPoint || i % 5 == 0) 
      { 
        fill(255, 0, 0);
        ellipse(x, y, 5, 5);
        noFill();
      }
    }
    endShape();
    
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
}


//All code added by Oliver Woods 12:20 17/03/2025
