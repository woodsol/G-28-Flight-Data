FlightBarChart chart;

void setup() {
  size(1000, 600);         // ✅ size() must be here!
  chart = new FlightBarChart(this);
  chart.setup();
}

void draw() {
  chart.draw();
}

void numItems(int val) {
  chart.setNumItems(val); // For slider to work
}
