PImage usaMap;
Table table;
ArrayList<Flight> flights = new ArrayList<Flight>();
Dropdown dropdown;
HashMap<String, float[]> coords = new HashMap<String, float[]>();

void setup() {
  size(1000, 600);
  usaMap = loadImage("map_of_america.png");
  table = loadTable("flights2k(1).csv", "header");
  defineCoords();

  for (TableRow row : table.rows()) {
    String origin = row.getString("ORIGIN");
    String dest = row.getString("DEST");
    String flDate = row.getString("FL_DATE");

    if (flDate == null || flDate.trim().equals("") ||
        !coords.containsKey(origin) || !coords.containsKey(dest)) {
      continue;
    }

    String[] dateParts = flDate.trim().split(" ");
    if (dateParts.length == 0 || dateParts[0] == null || dateParts[0].trim().equals("")) {
      continue;
    }

    String id = dateParts[0] + " - " +
                row.getString("MKT_CARRIER") + " " +
                row.getInt("MKT_CARRIER_FL_NUM");

    float[] o = coords.get(origin);
    float[] d = coords.get(dest);
    flights.add(new Flight(id, o[0], o[1], d[0], d[1]));
  }

  dropdown = new Dropdown(flights);
}

void draw() {
  background(255);
  image(usaMap, 0, 0, width, height);
  dropdown.display();
  Flight selected = dropdown.getSelectedFlight();
  if (selected != null) {
    selected.drawPath();
  }
}

void mousePressed() {
  dropdown.mousePressed();
}

void mouseWheel(MouseEvent event) {
  dropdown.scroll(int(event.getCount()));
}

void keyPressed() {
  dropdown.keyPressed(key);
}

class Flight {
  String id;
  float lat1, lon1, lat2, lon2;

  Flight(String id, float lat1, float lon1, float lat2, float lon2) {
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

class Dropdown {
  String[] allLabels;
  String[] visibleLabels;
  int selectedIndex = 0;
  String filter = "";
  float x, y, w = 200, h = 25;
  int scrollOffset = 0;
  int maxVisible = 3;

  Dropdown(ArrayList<Flight> flights) {
    allLabels = new String[flights.size()];
    for (int i = 0; i < flights.size(); i++) {
      allLabels[i] = flights.get(i).getID();
    }
    updateVisible();

    // Bottom-right positioning with margin
    x = width - w - 30;
    y = height - (h * (maxVisible + 1)) - 30;
  }

  void updateVisible() {
    ArrayList<String> filtered = new ArrayList<String>();
    for (String label : allLabels) {
      if (label.toLowerCase().contains(filter.toLowerCase())) {
        filtered.add(label);
      }
    }
    visibleLabels = filtered.toArray(new String[0]);
    selectedIndex = constrain(selectedIndex, 0, visibleLabels.length - 1);
    scrollOffset = 0;
  }

  void display() {
    fill(240);
    stroke(0);
    rect(x, y, w, h);
    fill(0);
    textAlign(LEFT, CENTER);
    if (visibleLabels.length > 0) {
      text(visibleLabels[selectedIndex], x + 5, y + h / 2);
    } else {
      text("No match", x + 5, y + h / 2);
    }

    for (int i = 0; i < min(maxVisible, visibleLabels.length); i++) {
      int listIndex = scrollOffset + i;
      if (listIndex >= visibleLabels.length) break;
      fill(i == selectedIndex - scrollOffset ? 200 : 255);
      rect(x, y + h * (i + 1), w, h);
      fill(0);
      text(visibleLabels[listIndex], x + 5, y + h * (i + 1) + h / 2);
    }
  }

  void mousePressed() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h * (maxVisible + 1)) {
      int clicked = int((mouseY - y) / h);
      if (clicked > 0 && scrollOffset + clicked - 1 < visibleLabels.length) {
        selectedIndex = scrollOffset + clicked - 1;
      } else {
        selectedIndex = (selectedIndex + 1) % visibleLabels.length;
      }
    }
  }

  void scroll(int amount) {
    scrollOffset += amount;
    scrollOffset = constrain(scrollOffset, 0, max(0, visibleLabels.length - maxVisible));
  }

  void keyPressed(char key) {
    if (key == BACKSPACE && filter.length() > 0) {
      filter = filter.substring(0, filter.length() - 1);
    } else if (key != ENTER && key != RETURN) {
      filter += key;
    }
    updateVisible();
  }

  Flight getSelectedFlight() {
    if (visibleLabels.length == 0) return null;
    String selectedID = visibleLabels[selectedIndex];
    for (Flight f : flights) {
      if (f.getID().equals(selectedID)) return f;
    }
    return null;
  }
}

void defineCoords() {
  coords.put("ABQ", new float[]{35.0494, -106.617});
  coords.put("ADQ", new float[]{57.75, -152.494});
  coords.put("ALB", new float[]{42.7483, -73.8029});
  coords.put("ANC", new float[]{61.1743, -149.9982});
  coords.put("ATL", new float[]{33.6407, -84.4277});
  coords.put("ATW", new float[]{44.2581, -88.5191});
  coords.put("AUS", new float[]{30.1975, -97.6664});
  coords.put("AZA", new float[]{33.3078, -111.6556});
  coords.put("BDL", new float[]{41.9389, -72.6832});
  coords.put("BET", new float[]{60.7798, -161.8379});
  coords.put("BHM", new float[]{33.5629, -86.7535});
  coords.put("BNA", new float[]{36.1263, -86.6774});
  coords.put("BOI", new float[]{43.5644, -116.2228});
  coords.put("BOS", new float[]{42.3656, -71.0096});
  coords.put("BRW", new float[]{71.2854, -156.766});
  coords.put("BUR", new float[]{34.2007, -118.3587});
  coords.put("BWI", new float[]{39.1754, -76.6684});
  coords.put("CHS", new float[]{32.8986, -80.0405});
  coords.put("CID", new float[]{41.8847, -91.7108});
  coords.put("CLE", new float[]{41.4117, -81.8498});
  coords.put("CLT", new float[]{35.214, -80.9431});
  coords.put("CMH", new float[]{39.998, -82.8919});
  coords.put("COS", new float[]{38.8058, -104.7008});
  coords.put("CVG", new float[]{39.0533, -84.6626});
  coords.put("DCA", new float[]{38.8512, -77.0402});
  coords.put("DEN", new float[]{39.8561, -104.6737});
  coords.put("DFW", new float[]{32.8998, -97.0403});
  coords.put("DTW", new float[]{42.2162, -83.3554});
  coords.put("ELP", new float[]{31.8072, -106.3786});
  coords.put("EUG", new float[]{44.12, -123.222});
  coords.put("EWR", new float[]{40.6895, -74.1745});
  coords.put("FAI", new float[]{64.8151, -147.856});
  coords.put("FAR", new float[]{46.9207, -96.8158});
  coords.put("FAT", new float[]{36.7762, -119.7181});
  coords.put("FLL", new float[]{26.0726, -80.1527});
  coords.put("GEG", new float[]{47.6199, -117.535});
  coords.put("GSP", new float[]{34.8957, -82.2189});
  coords.put("HNL", new float[]{21.3187, -157.9225});
  coords.put("IAH", new float[]{29.9902, -95.3368});
  coords.put("IND", new float[]{39.7173, -86.2944});
  coords.put("JAX", new float[]{30.4941, -81.6879});
  coords.put("JFK", new float[]{40.6413, -73.7781});
  coords.put("KOA", new float[]{19.7388, -156.0456});
  coords.put("LAS", new float[]{36.084, -115.1537});
  coords.put("LAX", new float[]{33.9416, -118.4085});
  coords.put("LBB", new float[]{33.6636, -101.8228});
  coords.put("LGA", new float[]{40.7769, -73.874});
  coords.put("LIH", new float[]{21.975, -159.339});
  coords.put("MCI", new float[]{39.2976, -94.7139});
  coords.put("MCO", new float[]{28.4312, -81.3081});
  coords.put("MDW", new float[]{41.7868, -87.7522});
  coords.put("MEM", new float[]{35.0424, -89.9767});
  coords.put("MIA", new float[]{25.7959, -80.2871});
  coords.put("MKE", new float[]{42.9472, -87.8966});
  coords.put("MSP", new float[]{44.8848, -93.2223});
  coords.put("MSY", new float[]{29.9934, -90.258});
  coords.put("OAK", new float[]{37.7126, -122.2197});
  coords.put("OGG", new float[]{20.8986, -156.4305});
  coords.put("OKC", new float[]{35.3931, -97.6007});
  coords.put("ONT", new float[]{34.0559, -117.6005});
  coords.put("ORD", new float[]{41.9742, -87.9073});
  coords.put("ORF", new float[]{36.8946, -76.2012});
  coords.put("PBI", new float[]{26.6832, -80.0956});
  coords.put("PDX", new float[]{45.5898, -122.5951});
  coords.put("PHL", new float[]{39.8744, -75.2424});
  coords.put("PHX", new float[]{33.4342, -112.0116});
  coords.put("PIT", new float[]{40.4915, -80.2329});
  coords.put("PSP", new float[]{33.8297, -116.507});
  coords.put("PVD", new float[]{41.7263, -71.4311});
  coords.put("RDU", new float[]{35.8776, -78.7875});
  coords.put("RIC", new float[]{37.5052, -77.3197});
  coords.put("RNO", new float[]{39.4991, -119.7681});
  coords.put("ROC", new float[]{43.1189, -77.6724});
  coords.put("RSW", new float[]{26.5362, -81.7552});
  coords.put("SAN", new float[]{32.7338, -117.1933});
  coords.put("SAT", new float[]{29.5337, -98.4698});
  coords.put("SAV", new float[]{32.1276, -81.2021});
  coords.put("SDF", new float[]{38.1744, -85.736});
  coords.put("SEA", new float[]{47.4502, -122.3088});
  coords.put("SFO", new float[]{37.6213, -122.379});
  coords.put("SJC", new float[]{37.3626, -121.929});
  coords.put("SJU", new float[]{18.4394, -66.0018});
  coords.put("SLC", new float[]{40.7899, -111.9791});
  coords.put("SMF", new float[]{38.6951, -121.5908});
  coords.put("SNA", new float[]{33.6757, -117.8682});
  coords.put("SRQ", new float[]{27.3956, -82.5544});
  coords.put("STL", new float[]{38.75, -90.37});
  coords.put("TPA", new float[]{27.9755, -82.5332});
  coords.put("TUL", new float[]{36.1984, -95.8881});
  coords.put("XNA", new float[]{36.2819, -94.3068});
}
