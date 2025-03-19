ArrayList<Flight> allFlights = new ArrayList<Flight>();  // All flights
ArrayList<Flight> filteredFlights = new ArrayList<Flight>();  // Filtered results

String startDate = "";
String endDate = "";
boolean enteringStartDate = true;  
boolean showError = false;  

Button filterButton;

void setup() {
    size(600, 400);
    textSize(16);
    
    
    filterButton = new Button(50, 120, 150, 40, "Filter Flights");
}

void draw() {
    background(220);
    
    
    fill(0);
    text("Start Date (YYYYMMDD): " + startDate, 50, 50);
    text("End Date (YYYYMMDD): " + endDate, 50, 80);
    
    
    if (showError) {
        fill(255, 0, 0);
        text("Invalid dates! Check format and order.", 50, 110);
    }

    // button
    filterButton.draw();
    
    // Display the filtered flights
    int y = 180;
    fill(0);
    for (Flight f : filteredFlights) {
        text(f.flightDate + " - " + f.origin + " to " + f.destination, 50, y);
        y += 20;
    }
}

// Handle user input
void keyPressed() {
    if (key == BACKSPACE) {
        if (enteringStartDate && startDate.length() > 0) {
            startDate = startDate.substring(0, startDate.length() - 1);
        } else if (!enteringStartDate && endDate.length() > 0) {
            endDate = endDate.substring(0, endDate.length() - 1);
        }
    } else if (key == TAB) {
        enteringStartDate = !enteringStartDate;
    } else if (key >= '0' && key <= '9') {
        if (enteringStartDate && startDate.length() < 8) {
            startDate += key;
        } else if (!enteringStartDate && endDate.length() < 8) {
            endDate += key;
        }
    }
}

// Handle button click
void mousePressed() {
    if (filterButton.isClicked(mouseX, mouseY)) {
        applyDateFilter();
    }
}

// **Filter function**
void applyDateFilter() {
    showError = false;  

    // Validate input
    if (startDate.length() != 8 || endDate.length() != 8) {
        showError = true;  
        return;
    }
    if (int(startDate) > int(endDate)) {
        showError = true;  // Start date must be before end date
        return;
    }

    
    FlightDateFilter dateFilter = new FlightDateFilter();
    filteredFlights = dateFilter.filterByDate(allFlights, startDate, endDate);
}

// code done by Daniel Doolan at 5:28 pm 19/03/2025
    
