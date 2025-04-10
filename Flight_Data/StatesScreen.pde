PImage newyork;
PImage alaska;
PImage southcarolina;
PImage virginia;
PImage washington;
PImage vermont;
PImage southdakota;
PImage georgia;
PImage connecticut;
PImage alabama;
PImage oklahoma;
PImage ohio;
PImage maine;
PImage utah;
PImage delaware;
PImage indiana;
PImage iowa;
PImage illinois;
PImage wisconsin;
PImage arizona;
PImage northcarolina;
PImage colerado;
PImage wyoming;
PImage florida;
PImage kentucky;
PImage northdakota;
PImage louisiana;
PImage maryland;
PImage texas;
PImage hawaii;
PImage rhodeisland;
PImage kansas;
PImage pennsylvania;
PImage tennessee;
PImage idaho;
PImage oregon;
PImage california;
PImage westvirginia;
PImage newmexico;
PImage massachusetts;
PImage new_hampshire;
PImage nebraska;
PImage arkansas;
PImage nevada;
PImage new_jersey;
PImage michigan;
PImage minnesota;
PImage mississippi;
PImage missouri;
PImage montana;

class StatesScreen {
    HashMap<String, stateData> statesList;
    stateData currentState;
    public boolean originMode = false;
    int buttonSize = 12;
    String abbr;
    StatesScreen() {
        statesList = new HashMap<String, stateData>();

        michigan = loadImage("michigan.jpg");
        minnesota = loadImage("minnesota.jpg");
        mississippi = loadImage("mississippi.jpg");
        missouri = loadImage("missouri.jpg");
        montana = loadImage("montana.jpg");
        newyork = loadImage("new_york.jpeg");
        new_jersey = loadImage("new_jersey.jpg");
        massachusetts = loadImage("massachusetts.jpg");
        alaska = loadImage("alaska.jpg");
        southcarolina = loadImage("south_carolina.jpeg");
        virginia = loadImage("Virginia.jpg");
        washington = loadImage("Washington.jpg");
        vermont = loadImage("Vermont.jpg");
        southdakota = loadImage("South_Dakota.jpg");
        georgia = loadImage("georgia.jpg");
        connecticut = loadImage("connecticut.png");
        alabama = loadImage("alabama.jpg");
        oklahoma = loadImage("oklahoma_outline.jpeg");
        ohio = loadImage("ohio.jpeg");
        maine = loadImage("Maine.jpg");
        utah = loadImage("Utah.jpg");
        delaware = loadImage("delaware.jpg");
        indiana = loadImage("indiana.gif");
        illinois = loadImage("illinois.jpg");
        iowa = loadImage("Iowa.jpg");
        wisconsin = loadImage("Wisconsin.jpeg");
        arizona = loadImage("arizona.jpg");
        northcarolina = loadImage("north_carolina.jpg");
        colerado = loadImage("colerado.jpg");
        wyoming = loadImage("Wyoming.jpg");
        florida = loadImage("florida.jpg");
        kentucky = loadImage("Kentucky.jpg");
        northdakota = loadImage("north_dakota.jpg");
        louisiana = loadImage("lousiana.jpg");
        maryland = loadImage("maryland.jpg");
        texas = loadImage("Texas.png");
        hawaii = loadImage("Hawaii.png");
        rhodeisland = loadImage("rhode_island.png");
        kansas = loadImage("kansas.jpg");
        pennsylvania = loadImage("pennsylvania.jpg");
        tennessee = loadImage("Tennessee.jpg");
        idaho = loadImage("Idaho outline.jpg");
        oregon = loadImage("oregon.jpg");
        california = loadImage("california.png");
        westvirginia = loadImage("West_Virginia.jpg");
        newmexico = loadImage("new_mexico_outline.jpg");
        new_hampshire = loadImage("new_hampshire.jpg");
        nebraska = loadImage("nebraska.jpg");
        nevada = loadImage("nevada.jpg");
        arkansas = loadImage("arkansas.jpg");
        

        HashMap<String, PVector> temp = new HashMap<String, PVector>();
        temp.put("New York City", new PVector(300, 290));
        statesList.put("New York", new stateData(newyork, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Airport", new PVector(300, 290));
        temp.put("Little Rock", new PVector(460, 290));
        temp.put("Fort Smith", new PVector(250, 300));
        temp.put("Fayetteville", new PVector(250, 200));
        statesList.put("Arkansas", new stateData(arkansas, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Lincoln", new PVector(700, 400));
        statesList.put("Nebraska", new stateData(southcarolina, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Columbia", new PVector(300, 290));
        statesList.put("South Carolina", new stateData(southcarolina, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Richmond", new PVector(420, 380.0));
        temp.put("Washington DC", new PVector(430, 250.0));
        temp = new HashMap<String, PVector>();
        temp.put("Boston", new PVector(600, 190.0));
        statesList.put("Massachusetts", new stateData(massachusetts, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Seattle", new PVector(200, 250.0));
        statesList.put("Washington", new stateData(washington, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Burlington", new PVector(300, 280.0));
        statesList.put("Vermont", new stateData(vermont, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Newark", new PVector(300, 190.0));
        statesList.put("New_Jersey", new stateData(new_jersey, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Airport", new PVector(300, 290));
        statesList.put("Oklahoma", new stateData(oklahoma, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Manchester", new PVector(600, 290));
        statesList.put("New Hampshire", new stateData(new_hampshire, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Chicago", new PVector(220, 420));
        statesList.put("Illinois", new stateData(illinois, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Airport", new PVector(300, 290));
        statesList.put("Ohio", new stateData(ohio, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Portland", new PVector(270, 180));
        statesList.put("Maine", new stateData(maine, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Salt Lake City", new PVector(300, 220.0));
        statesList.put("Utah", new stateData(utah, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Indianapolis", new PVector(300, 300));
        statesList.put("Indiana", new stateData(indiana, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Cedar Rapids/Iowa City", new PVector(250, 300));
        statesList.put("Iowa", new stateData(iowa, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Milwaukee", new PVector(450, 490.0));
        temp.put("Madison", new PVector(330, 500.0));
        statesList.put("Wisconsin", new stateData(wisconsin, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Raleigh", new PVector(300, 290));
        statesList.put("North Carolina", new stateData(northcarolina, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Jackson", new PVector(50, 230.0));
        statesList.put("Wyoming", new stateData(wyoming, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Louisville", new PVector(300, 350));
        statesList.put("Kentucky", new stateData(kentucky, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Bismarck", new PVector(300, 290));
        statesList.put("North Dakota", new stateData(northdakota, temp));
        temp = new HashMap<String, PVector>();
        temp.put("New Orleans", new PVector(350, 400));
        statesList.put("Louisiana", new stateData(louisiana, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Baltimore", new PVector(355, 220.0));
        statesList.put("Maryland", new stateData(maryland, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Houston", new PVector(470, 410.0));
        temp.put("Austin", new PVector(390, 380.0));
        temp.put("Dallas", new PVector(400, 250.0));
        statesList.put("Texas", new stateData(texas, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Honolulu", new PVector(355, 220.0));
        statesList.put("Hawaii", new stateData(hawaii, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Airport", new PVector(300, 290));
        statesList.put("Rhode Island", new stateData(rhodeisland, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Wichita", new PVector(350, 350));
        statesList.put("Kansas", new stateData(kansas, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Airport", new PVector(300, 290));
        statesList.put("Pennsylvania", new stateData(pennsylvania, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Nashville", new PVector(320, 300.0));
        temp.put("Memphis", new PVector(100, 380.0));
        statesList.put("Tennessee", new stateData(tennessee, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Boise", new PVector(220, 420));
        temp.put("Idaho Falls", new PVector(350, 500));
        statesList.put("Idaho", new stateData(idaho, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Salem", new PVector(300, 290));
        statesList.put("Oregon", new stateData(oregon, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Ashville", new PVector(145, 410.0));
        temp.put("Charlestown", new PVector(240, 380.0));
        statesList.put("West Virginia", new stateData(westvirginia, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Albuquerque", new PVector(300, 290));
        statesList.put("New Mexico", new stateData(newmexico, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Phoenix", new PVector(300, 290));
        statesList.put("Arizona", new stateData(arizona, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Minneapolis", new PVector(400, 290));
        statesList.put("Minnesotas", new stateData(michigan, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Minneapolis", new PVector(100, 290));
        statesList.put("Mississippi", new stateData(mississippi, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Springfield", new PVector(400, 390));
        statesList.put("Missouri", new stateData(missouri, temp));
        temp = new HashMap<String, PVector>();
        temp.put("Missoula", new PVector(500, 390));
        statesList.put("Montana", new stateData(montana, temp));
    }

    void loadState(String name, String abbr) {
        currentState = statesList.get(name);
        this.abbr = abbr;
    }

    void draw() {
        background(255);
        image(currentState.image, 0, 0, width, height);
        drawButtons();
    }

    void mousePressed() {
        for (String item : currentState.cities.keySet()) {
            PVector point = currentState.cities.get(item);
            boolean isOver = dist(point.x, point.y, mouseX, mouseY) <= buttonSize;

            if (isOver) {
                if (!originMode) {
                    arrivalCity = item + ", " + this.abbr;
                    println(arrivalCity);
                    currentScreen = DATE_SCREEN;
                } else {
                    departureCity = item + ", " + this.abbr;
                    currentScreen = MAP_SCREEN;
                }
            }
        }

    }

    void drawButtons() {
        for (String item : currentState.cities.keySet()) {
            PVector point = currentState.cities.get(item);
            fill(255, 0, 0);
            circle(point.x, point.y, buttonSize);
            textSize(14);
            fill(30);
            text(item, point.x+10, point.y+10);
        }
    }
}
