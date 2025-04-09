//PImage mapImage;
//ArrayList<StateButton> states = new ArrayList<StateButton>();

//void setup() {
//  size(1000, 600);
//  mapImage = loadImage("map of america.png");
  
//  // Define state buttons manually with precise positions (adjust as needed)
//  states.add(new StateButton(750, 460)); // Alabama
//  states.add(new StateButton(100, 500)); // Alaska
//  states.add(new StateButton(200, 420)); // Arizona
//  states.add(new StateButton(500, 420)); // Arkansas
//  states.add(new StateButton(100, 400)); // California
//  states.add(new StateButton(350, 350)); // Colorado
//  states.add(new StateButton(870, 180)); // Connecticut
//  states.add(new StateButton(860, 220)); // Delaware
//  states.add(new StateButton(800, 500)); // Florida
//  states.add(new StateButton(750, 460)); // Georgia
//  states.add(new StateButton(200, 550)); // Hawaii
//  states.add(new StateButton(200, 250)); // Idaho
//  states.add(new StateButton(600, 300)); // Illinois
//  states.add(new StateButton(640, 320)); // Indiana
//  states.add(new StateButton(540, 280)); // Iowa
//  states.add(new StateButton(450, 340)); // Kansas
//  states.add(new StateButton(670, 360)); // Kentucky
//  states.add(new StateButton(520, 470)); // Louisiana
//  states.add(new StateButton(900, 100)); // Maine
//  states.add(new StateButton(850, 230)); // Maryland
//  states.add(new StateButton(880, 160)); // Massachusetts
//  states.add(new StateButton(680, 250)); // Michigan
//  states.add(new StateButton(550, 200)); // Minnesota
//  states.add(new StateButton(600, 450)); // Mississippi
//  states.add(new StateButton(550, 350)); // Missouri
//  states.add(new StateButton(300, 180)); // Montana
//  states.add(new StateButton(450, 300)); // Nebraska
//  states.add(new StateButton(180, 320)); // Nevada
//  states.add(new StateButton(880, 140)); // New Hampshire
//  states.add(new StateButton(860, 200)); // New Jersey
//  states.add(new StateButton(300, 420)); // New Mexico
//  states.add(new StateButton(850, 200)); // New York
//  states.add(new StateButton(770, 390)); // North Carolina
//  states.add(new StateButton(500, 160)); // North Dakota
//  states.add(new StateButton(690, 300)); // Ohio
//  states.add(new StateButton(420, 400)); // Oklahoma
//  states.add(new StateButton(120, 250)); // Oregon
//  states.add(new StateButton(800, 250)); // Pennsylvania
//  states.add(new StateButton(890, 170)); // Rhode Island
//  states.add(new StateButton(770, 430)); // South Carolina
//  states.add(new StateButton(500, 220)); // South Dakota
//  states.add(new StateButton(660, 400)); // Tennessee
//  states.add(new StateButton(400, 450)); // Texas
//  states.add(new StateButton(250, 350)); // Utah
//  states.add(new StateButton(870, 120)); // Vermont
//  states.add(new StateButton(780, 340)); // Virginia
//  states.add(new StateButton(120, 180)); // Washington
//  states.add(new StateButton(750, 310)); // West Virginia
//  states.add(new StateButton(620, 240)); // Wisconsin
//  states.add(new StateButton(350, 250)); // Wyoming
//}

//void draw() {
//  background(255);
//  image(mapImage, 0, 0, width, height);
  
//  for (StateButton s : states) {
//    s.display();
//  }
//}

//void mousePressed() {
//  for (StateButton s : states) {
//    if (s.isHovered()) {
//      s.clicked = !s.clicked;
//    }
//  }
//}

//class StateButton {
//  int x, y;
//  boolean clicked = false;
  
//  StateButton(int x, int y) {
//    this.x = x;
//    this.y = y;
//  }
  
//  void display() {
//    fill(clicked ? color(255, 0, 0) : color(0, 0, 255));
//    ellipse(x, y, 10, 10);
//  }
  
//  boolean isHovered() {
//    return dist(mouseX, mouseY, x, y) < 5;
//  }
//}
