import java.util.*;
import java.util.stream.*;

// Screen Logic
int currentScreen = 0;
final int HOME_SCREEN = 0;
final int MAP_SCREEN = 1;
final int STATE_SCREEN = 2;
final int RESULTS_SCREEN = 3;
final int GRAPHS_SCREEN = 4;
final int DATE_SCREEN = 5;

// Database
import de.bezier.data.sql.*;
SQLite db;

// Home Screen
HomeScreen homeScreen;

// Graph Screen
GraphScreen graphScreen;

// Map Screen
MapScreen mapScreen;
PVector pan = new PVector(50, 50); // Add panning and zoom
float scale = 0.9;
// int mouseHeldFrames = 0;
PVector prevMousePos = new PVector(0, 0);
PImage planeCursor;
boolean departureSelected = false;
String departureState = "";
String arrivalState = "";
String departureCity = "";
String arrivalCity = "";
String flightDate = "";
SearchBar searchBar;

// Date Selector screen
FlightDateSelectionUI dateScreen;

// Results Screen
ResultsScreen resultsScreen;

Data data;

PFont Montserrat;
PFont MontserratBold;

void setup() {
  size(1000, 600);
  textSize(16);
  windowTitle("Fly Me To The Moon");

  Montserrat = createFont("Montserrat-Medium.ttf", 64);
  MontserratBold = createFont("Montserrat-Bold.ttf", 64);

  planeCursor = loadImage("planeCursor.png"); // Custom cursor image

  db = new SQLite( this, "flights.db" );
  data = new Data(db);
  homeScreen = new HomeScreen(Montserrat);
  graphScreen = new GraphScreen();
  mapScreen = new MapScreen(Montserrat);
  searchBar = new SearchBar();
  dateScreen = new FlightDateSelectionUI();
  resultsScreen = new ResultsScreen();
  //
  // for (Flight f : data.search(query)) {
  //     println(f.ORIGINSTATEABR + " to "+f.DESTSTATEABR);
  // }
}

void draw()
{
  switch(currentScreen) {
  case HOME_SCREEN:
    homeScreen.draw();
    break;
  case MAP_SCREEN:
    scale(scale);
    translate(pan.x, pan.y);
    mapScreen.draw(scale, pan);

    textAlign(CENTER, CENTER);
    textSize(16 / scale);
    fill(0);
    if (departureSelected) {
      text("Select Arrival", width/2, 10);
    } else {
      text("Select Departure", width/2, 10);
    }
    float mX = mouseX / scale - pan.x;
    float mY = mouseY / scale - pan.y;
    searchBar.draw((int) mX, (int) mY);
    if (searchBar.searchComplete) {
      if (searchBar.departureIsCity) {
        departureCity = searchBar.departure;
      } else {
        departureState = mapScreen.getAbbreviation(searchBar.departure);
      }
      if (searchBar.arrivalIsCity) {
        arrivalCity = searchBar.arrival;
      } else {
        arrivalState = mapScreen.getAbbreviation(searchBar.arrival);
      }
      println(departureCity);
      println(departureState);
      println(arrivalCity);
      println(arrivalState);
      currentScreen = DATE_SCREEN;
    }
    break;
  case RESULTS_SCREEN:
    resultsScreen.draw(data.dataReturned);
    break;
  case GRAPHS_SCREEN:
    graphScreen.draw();
    break;
  case DATE_SCREEN:
    scale(0.8);
    dateScreen.draw();
    break;
  default:
    print("Screen does not exist.");
    break;
  }

  // Draws custom plane cursor instead of the default cursor
  //image(planeCursor, mouseX - 16, mouseY - 16, 32, 32);
  //noCursor(); // Hides the system cursor
}

// Handle user input
void keyPressed() {
  switch(currentScreen) {
      case MAP_SCREEN:
        searchBar.keyPressed();
        break;
      case GRAPHS_SCREEN:
        graphScreen.keyPressed();
      default:
        break;
  }
}

// Handle button click
void mousePressed() {
  switch (currentScreen) {
  case HOME_SCREEN:
    int screen_change = homeScreen.handleMousePress();
    if (screen_change != -1) {
      currentScreen = screen_change;
    }
    break;
  case GRAPHS_SCREEN:
    graphScreen.mousePressed();
    break;
  case MAP_SCREEN:
    float mousX = mouseX / scale - pan.x;
    float mousY = mouseY / scale - pan.y;
    searchBar.mousePressed((int) mousX, (int) mousY);
    if (searchBar.hasFocus || searchBar.clickedOnSearch) {
      return;
    }
    prevMousePos.x = mouseX;
    prevMousePos.y = mouseY;
    for (State state : mapScreen.states) {
      if (state.isMouseOver( scale, pan )) {
        if (departureSelected) {
          arrivalState = state.abbr;
          currentScreen = DATE_SCREEN;
        } else {
          departureState = state.abbr;
          departureSelected = true;
        }
      }
    }
    break;
  case DATE_SCREEN:
    int mX = (int) Math.round(mouseX / 0.8);
    int mY = (int) Math.round(mouseY / 0.8);
    String date = dateScreen.handleMousePress(mX, mY);
    if (!date.equals("NULL")) {
      flightDate = date;
      data.dataReturned = false;
      thread("search");
      currentScreen = RESULTS_SCREEN;
    }
    break;
  default:
    break;
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
  switch (currentScreen) {
  case MAP_SCREEN:
    float e = event.getCount();
    scale += e * 0.01;
    if (scale < 0.5) {
      scale = 0.5;
    } else if (scale > 4) {
      scale = 4;
    }
    break;
  case DATE_SCREEN:
    dateScreen.mouseWheel(event);
    break;
  case GRAPHS_SCREEN:
    graphScreen.mouseWheel(event);
    break;
  case RESULTS_SCREEN:
    break;
  default:
    break;
  }
}

void mouseReleased() {
  if (currentScreen == RESULTS_SCREEN) {
    resultsScreen.unlock();
  }
}

void search() {
  Flight query = new Flight();
  query.originStateAbr(departureState);
  query.destinationStateAbr(arrivalState);
  query.originCityName(departureCity);
  query.destinationCityName(arrivalCity);
  query.flightDate(flightDate);
  String[] date = flightDate.split("/"); // month, day, year
  String[] months = {"January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
  windowTitle("Flights on " + date[1] + endingOf(date[0]) + " of " + months[Integer.parseInt(date[0])] + " " + date[2]);

  ArrayList<Flight> results = data.search(query);
  println(results.size());
  resultsScreen.loadResults(results);
  currentScreen = RESULTS_SCREEN;
}

String endingOf(String month) {
    switch (month.charAt(month.length() - 1)) {
        case '1':
            return "st";
        case '2':
            return "nd";
        case '3':
            return "rd";
    }
    return "th";
}

void mouseMoved() {
  if (currentScreen == HOME_SCREEN) {
    homeScreen.mouseMoved();
  }
}

// Code by Christian Barton Randall
