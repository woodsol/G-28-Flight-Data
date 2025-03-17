
class FlightDataChecker 
{
    ArrayList<Flight> flights; 

    FlightManager() {
        flights = new ArrayList<>();
    }

    // add a flight
    public void addFlight(Flight flight) 
    {
        flights.add(flight);
    }

    // get the list of canclled flights
    public List<Flight> getCancelledFlights() 
    {
        List<Flight> cancelledFlights = new ArrayList<>();
        for (Flight flight : flights) 
        {
            if (flight.CANCELLED == "1") 
            {
                cancelledFlights.add(flight);
            }
        }
        return cancelledFlights;
    }

    // displays cancelld flight details
    public void displayCancelledFlights() 
    {
        List<Flight> cancelledFlights = getCancelledFlights();
        if (cancelledFlights.isEmpty()) 
        {
            System.out.println("No cancelled flights found.");
        } else 
        {
            System.out.println("Cancelled Flights:");
            for (Flight flight : cancelledFlights) 
            {
                System.out.println(flight);
            }
        }
    }
    
    // get the list of diverted flights
    public List<Flight> getDivertedFlights() 
    {
        List<Flight> divertedFlights = new ArrayList<>();
        for (Flight flight : flights) 
        {
            if (flight.DIVERTED == "1") {
                divertedFlights.add(flight);
            }
        }
        return divertedFlights;
    }

    // displays divetted flight details
    public void displayDivertedFlights() 
    {
        List<Flight> divertedFlights = getDivertedFlights();
        if (divertedFlights.isEmpty()) 
        {
            System.out.println("No diverted flights found.");
        } else 
        {
            System.out.println("Diverted Flights:");
            for (Flight flight : divertedFlights) 
            {
                System.out.println(flight);
            }
        }
    }
}

//All code added by Joseph Hegarty 16:12 17/03/2025
