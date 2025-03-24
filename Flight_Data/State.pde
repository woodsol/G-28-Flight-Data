class State {
    String name;
    String abbr;
    JSONArray coordinates;
    String geometryType;
    color fillColor = color(213, 197, 200);
    color highlightColor = color(255);
    color edgeColor = color(166, 176, 186);
    boolean mouseOver = false;
    ArrayList<PVector> points = new ArrayList<PVector>();
    PVector centre;

    State(String name, String abbr, JSONArray coordinates, String geometryType) {
        this.name = name;
        this.abbr = abbr;
        this.coordinates = coordinates;
        this.geometryType = geometryType;
        loadPoints();
        calculateCentre();
    }

    void loadPoints() {
        if (geometryType.equals("Polygon")) {
          JSONArray polygon = coordinates.getJSONArray(0);
          for (int i = 0; i < polygon.size(); i++) {
              JSONArray point = polygon.getJSONArray(i);
              float x = map(point.getFloat(0), -130, -65, 0, width);
              float y = map(point.getFloat(1), 25, 50, height, 0);
              points.add(new PVector(x, y));
          }
        } else if (geometryType.equals("MultiPolygon")) {
            for (int i = 0; i < coordinates.size(); i++) {
                JSONArray polygon = coordinates.getJSONArray(i).getJSONArray(0);
                for (int j = 0; j < polygon.size(); j++) {
                    JSONArray point = polygon.getJSONArray(j);
                    float x = map(point.getFloat(0), -130, -65, 0, width);
                    float y = map(point.getFloat(1), 25, 50, height, 0);
                    points.add(new PVector(x, y));
                }
            }
        }
    }

    void calculateCentre() {
        // just average out all points (centroid i guess)
        float sumX = 0, sumY = 0;
        for (PVector point : points) {
          sumX += point.x;
          sumY += point.y;
        }
        centre = new PVector(sumX / points.size(), sumY / points.size());
    }

    void draw(float scale, PVector pan) {
        stroke(edgeColor);
        fill(fillColor);
        if (mouseOver) {
          stroke(highlightColor);
          strokeWeight(2);
          if (!isMouseOver(scale, pan)) {
            mouseOver = false;
          }
        } else {
          strokeWeight(1);
        }

        beginShape();
        for (PVector point : points) {
          vertex(point.x, point.y);
        }
        endShape(CLOSE);

        // State Abbreviations
        fill(0);
        textSize(12);
        textAlign(CENTER, CENTER);
        text(abbr, centre.x, centre.y);
    }

    void highlight() {
        mouseOver = true;
    }

    boolean isMouseOver(float scale, PVector pan) {
        return pointInPolygon(mouseX / scale - pan.x, mouseY / scale - pan.y, points);
    }

    boolean pointInPolygon(float x, float y, ArrayList<PVector> polygon) { // Ray casting algorithm https://en.wikipedia.org/wiki/Point_in_polygon
        boolean inside = false;
        for (int i = 0, j = polygon.size() - 1; i < polygon.size(); j = i++) {
            float xi = polygon.get(i).x, yi = polygon.get(i).y;
            float xj = polygon.get(j).x, yj = polygon.get(j).y;

            boolean intersect = ((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
            if (intersect) {
                inside = !inside;
            }
        }
        return inside;
    }
}

// Christian Barton Randall 24/3/2025
