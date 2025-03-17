class Departure 
{
    String origin;
    ArrayList<Flight> flights;

    Departure(String origin, ArrayList<Flight> allFlights) 
    {
        this.origin = origin;
        this.flights = new ArrayList<>();
        for (Flight flight : allFlights) 
        {
            if (flight.origin.equals(origin)) 
            {
                this.flights.add(flight);
            }
        }
    }

    // This gets the number of flights from the origin
    int getNumberOfDepartures() 
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

    // This shows the details from the origin
    void displayFlightDetails() 
    {
        System.out.println("Flights departing from " + origin + ":");
        for (Flight flight : flights) 
        {
            System.out.println("Flight Code: " + flight.flightCode);
        }
    }
}

//All code added by Joseph Hegarty 16:12 17/03/2025
