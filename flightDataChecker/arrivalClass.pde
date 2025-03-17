class Arrivals
{
    String arrival;
    ArrayList<Flight> flights;

    Departure(String arrival, ArrayList<Flight> allFlights) 
    {
        this.arrival = arrival;
        this.flights = new ArrayList<>();
        for (Flight flight : allFlights) 
        {
            if (flight.arrival.equals(arrival)) 
            {
                this.flights.add(flight);
            }
        }
    }

    // This gets the number of flights at the arrival destination
    int getNumberOfArrivals() 
    {
        return flights.size();
    }

    // This gets the flight codes
    ArrayList<String> getFlightCodes() 
    {
        ArrayList<String> flightCodes = new ArrayList<>();
        for (Flight flight : flights) 
        {
            flightCodes.add(flight.flightCode);
        }
        return flightCodes;
    }

    // This shows the details of the arrivals
    void displayFlightDetails() 
    {
        System.out.println("Flights arriving at " + arrival + ":");
        for (Flight flight : flights) 
        {
            System.out.println("Flight Code: " + flight.flightCode);
        }
    }
}

//All code added by Joseph Hegarty 16:12 17/03/2025
