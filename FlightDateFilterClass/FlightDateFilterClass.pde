class FlightDateFilter {
  
    // Method to filter flights based on a given date range
    ArrayList<Flight> filterByDate(ArrayList<Flight> flights, String startDate, String endDate) {
        ArrayList<Flight> filteredFlights = new ArrayList<Flight>();

        for (Flight f : flights) {
            if (f.flightDate.compareTo(startDate) >= 0 && f.flightDate.compareTo(endDate) <= 0) {
                filteredFlights.add(f);
            }
        }
        
        return filteredFlights;
    }
}


// code done by Daniel Doolan at 5:28 pm 19/03/2025
