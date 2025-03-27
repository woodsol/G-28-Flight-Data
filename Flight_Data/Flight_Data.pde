// Screen Logic
int currentScreen = 0;
final int MAP_SCREEN = 0;
final int STATE_SCREEN = 1;
final int RESULTS_SCREEN = 2;

// Database
import de.bezier.data.sql.*;
SQLite db;

// Map Screen
MapScreen mapScreen;
PVector pan = new PVector(50, 50); // Add panning and zoom
float scale = 0.90;
// int mouseHeldFrames = 0;
PVector prevMousePos = new PVector(0,0);

// Results Screen
ResultsScreen resultsScreen;

Data data;

void setup() {
    size(1000, 600);
    textSize(16);

    db = new SQLite( this, "flights.db" );
    data = new Data(db);
    mapScreen = new MapScreen(createFont("Arial", 12));
    resultsScreen = new ResultsScreen();

    Flight query = new Flight();
    query.originStateAbr("VA");
    query.destinationStateAbr("WA");
    
    ArrayList<Flight> results = data.search(query);
    println(results.size());
    resultsScreen.loadResults(results);
    //
    // for (Flight f : data.search(query)) {
    //     println(f.ORIGINSTATEABR + " to "+f.DESTSTATEABR);
    // }
}

void draw()
{
  switch(currentScreen) {
    case MAP_SCREEN:
        scale(scale);
        translate(pan.x, pan.y);
        mapScreen.draw(scale, pan);
        break;
    case RESULTS_SCREEN:
        resultsScreen.draw();
        break;
    default:
        print("Screen does not exist.");
        break;
  }
}

// Handle user input
void keyPressed() {
}

// Handle button click
void mousePressed() {
    if (currentScreen == MAP_SCREEN) {
        prevMousePos.x = mouseX;
        prevMousePos.y = mouseY;
        for (State state : mapScreen.states) {
            if (state.isMouseOver( scale, pan )) {
                println(state.name + ", " + state.abbr);
            }
        }
    }
}

void mouseDragged() {
    if (currentScreen == MAP_SCREEN) {
        pan.x += 0.01 * (mouseX - prevMousePos.x);
        pan.y += 0.01 * (mouseY - prevMousePos.y);
    }
}

// Handle Zooming
void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    scale += e * 0.01;
    if (scale < 0.5) {
      scale = 0.5;
    } else if (scale > 4) {
      scale = 4;
    }
}

void mouseReleased() {
    if (currentScreen == RESULTS_SCREEN) {
        resultsScreen.unlock();
    }
}

// Christian Barton Randall 24/3/2025
