// Flight Data Heatmap Visualization
// Optimized for large datasets (1,000,000+ flights)

Table flightData;
PImage worldMap;
int[] heatmapGrid;
int gridWidth = 1000;
int gridHeight = 600;
float maxDensity = 0;

// Color scheme for heatmap
color[] heatColors = {
  color(0, 0, 100),      // Dark blue for low density
  color(0, 100, 255),    // Blue
  color(0, 255, 255),    // Cyan
  color(0, 255, 100),    // Green-cyan
  color(0, 255, 0),      // Green
  color(255, 255, 0),    // Yellow
  color(255, 100, 0),    // Orange
  color(255, 0, 0)       // Red for high density
};

class FlightHeatMap {
    FlightHeatMap() {
      // Initialize heatmap grid
      heatmapGrid = new int[gridWidth * gridHeight];
      
      // Load world map background (optional)
      worldMap = loadImage("map_of_america.png");
      worldMap.resize(width, height);
      
      // Load and process flight data
      loadFlightData("heatmap.csv");
      
      // Find maximum density for normalization
      for (int i = 0; i < heatmapGrid.length; i++) {
        if (heatmapGrid[i] > maxDensity) {
          maxDensity = heatmapGrid[i];
        }
      }
    }

    void loadFlightData(String filename) {
      // Load CSV file
      flightData = loadTable(filename, "header");
      println("Processing " + flightData.getRowCount() + " flights...");
      
      // Expected columns: origin_lat, origin_lon, dest_lat, dest_lon
      // (adjust column names based on your actual CSV structure)
      
      // Process in batches to avoid memory issues
      int batchSize = 500;
      int totalRows = flightData.getRowCount();
      
      println(batchSize + " | " + totalRows);
      
      for (int i = 0; i < totalRows; i += batchSize) {
        int endIndex = min(i + batchSize, totalRows);
        processBatch(i, endIndex);
      }
    }

    void processBatch(int startIndex, int endIndex) {
      println("TEST " + startIndex + " " + endIndex)
      for (int i = startIndex; i < endIndex; i++) {
        TableRow row = flightData.getRow(i);
        
        try {
          // Get coordinates (adjust column names as needed)
          float originLat = row.getFloat("origin_lat");
          float originLon = row.getFloat("origin_lon");
          float destLat = row.getFloat("dest_lat");
          float destLon = row.getFloat("dest_lon");
          
          // Skip invalid data
          if (Float.isNaN(originLat) || Float.isNaN(originLon) || 
              Float.isNaN(destLat) || Float.isNaN(destLon)) {
            println("nan test");
            continue;
          }
          
          // Plot flight path with Bresenham's line algorithm for efficiency
          plotFlightPath(originLon, originLat, destLon, destLat);
          
        } catch (Exception e) {
          print("exception test");
          // Skip rows with missing data
          continue;
        }
      }
    }

    void plotFlightPath(float x0, float y0, float x1, float y1) {
      // Convert geo coordinates to screen coordinates
      int sx0 = lonToScreenX(x0);
      int sy0 = latToScreenY(y0);
      int sx1 = lonToScreenX(x1);
      int sy1 = latToScreenY(y1);
      
      // Use Bresenham's line algorithm for efficiency
      int dx = abs(sx1 - sx0);
      int dy = -abs(sy1 - sy0);
      int sx = sx0 < sx1 ? 1 : -1;
      int sy = sy0 < sy1 ? 1 : -1;
      int err = dx + dy;
      int e2;
      
      while (true) {
        // Update heatmap at this point
        print("test");
        if (sx0 >= 0 && sx0 < gridWidth && sy0 >= 0 && sy0 < gridHeight) {
          heatmapGrid[sy0 * gridWidth + sx0]++;
          print("TEST");
        }
        
        if (sx0 == sx1 && sy0 == sy1) break;
        e2 = 2 * err;
        if (e2 >= dy) { err += dy; sx0 += sx; }
        if (e2 <= dx) { err += dx; sy0 += sy; }
      }
    }

    void draw() {
      // Draw background map if available
      // if (worldMap != null) {
      //   image(worldMap, 0, 0);
      // }
      
      // Draw heatmap with logarithmic scaling for better visualization
      background(worldMap);
      colorMode(HSB, 255);
      loadPixels();
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          int density = heatmapGrid[y * gridWidth + x];
          if (density > 0) {
            // Apply logarithmic scaling for better visualization
            float scaledDensity = log(1 + density) / log(1 + maxDensity);
            color pixelColor = getHeatmapColor(scaledDensity);
            pixels[y * width + x] = pixelColor;
            print("TEST");
          }
        }
      }
      updatePixels();
      
      // Draw title and legend
      drawLegend();
      
      colorMode(RGB);
    }

    color getHeatmapColor(float intensity) {
      // Map intensity value to color gradient
      float colorPosition = intensity * (heatColors.length - 1);
      int colorIndex = floor(colorPosition);
      float colorFraction = colorPosition - colorIndex;
      
      if (colorIndex >= heatColors.length - 1) {
        return heatColors[heatColors.length - 1];
      }
      
      // Interpolate between colors
      color c1 = heatColors[colorIndex];
      color c2 = heatColors[colorIndex + 1];
      
      return lerpColor(c1, c2, colorFraction);
    }

    void drawLegend() {
      // Draw title
      fill(255);
      textSize(24);
      textAlign(CENTER);
      text("Flight Density Heatmap (537K flights)", width/2, 30);
      
      // Draw legend
      int legendWidth = 300;
      int legendHeight = 20;
      int legendX = width - legendWidth - 20;
      int legendY = height - 50;
      
      // Draw gradient bar
      for (int i = 0; i < legendWidth; i++) {
        float ratio = (float)i / legendWidth;
        color legendColor = getHeatmapColor(ratio);
        stroke(legendColor);
        line(legendX + i, legendY, legendX + i, legendY + legendHeight);
      }
      
      // Draw legend labels
      fill(255);
      textSize(12);
      textAlign(LEFT);
      text("Low", legendX, legendY + legendHeight + 15);
      textAlign(RIGHT);
      text("High", legendX + legendWidth, legendY + legendHeight + 15);
    }

    // Convert longitude to screen X coordinate
    int lonToScreenX(float lon) {
      return (int)map(lon, -180, 180, 0, gridWidth - 1);
    }

    // Convert latitude to screen Y coordinate
    int latToScreenY(float lat) {
      return (int)map(lat, 90, -90, 0, gridHeight - 1);
    }

    // Mouse interaction to show density at cursor position
    void mouseMoved() {
      if (mouseX >= 0 && mouseX < width && mouseY >= 0 && mouseY < height) {
        int density = heatmapGrid[mouseY * gridWidth + mouseX];
        float lon = map(mouseX, 0, width - 1, -180, 180);
        float lat = map(mouseY, 0, height - 1, 90, -90);
        
        // Display info in window title
        surface.setTitle(String.format("Flight Heatmap | Position: %.2f, %.2f | Density: %d", lon, lat, density));
      }
    }
}
