class FlightPath {
      String id;
      float lat1, lon1, lat2, lon2;

      FlightPath(String id, float lat1, float lon1, float lat2, float lon2) {
        this.id = id;
        this.lat1 = lat1;
        this.lon1 = lon1;
        this.lat2 = lat2;
        this.lon2 = lon2;
      }

      void drawPath() {
        stroke(0, 0, 255);
        strokeWeight(2);
        noFill();

        float x1 = map(lon1, -125, -65, 0, width);
        float y1 = map(lat1, 50, 20, 0, height);
        float x2 = map(lon2, -125, -65, 0, width);
        float y2 = map(lat2, 50, 20, 0, height);

        float cx = (x1 + x2) / 2;
        float cy = (y1 + y2) / 2 - 50;

        beginShape();
        vertex(x1, y1);
        quadraticVertex(cx, cy, x2, y2);
        endShape();

        fill(255, 0, 0); ellipse(x1, y1, 8, 8);
        fill(0, 255, 0); ellipse(x2, y2, 8, 8);
      }

      String getID() {
        return id;
      }
}
