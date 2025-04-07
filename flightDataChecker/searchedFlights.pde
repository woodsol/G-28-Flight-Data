class searchedFlight
{
  String city;
  ArrayList<Flight> flights;
  
  searchedFlight(String searchedCity, ArrayList<Flight> allFlights)
  {
    this.city = searchedCity;
    this.flights = new ArrayList<>();
    for (Flight f : allFlights)
    {
      if (f.ORIGIN.equals(city))
      {
        flights.add(f);
      }
    }
  }
  
  int getNumberOfFlights()
  {
    return flights.size();
  }
}

//All code added by Joseph Hegarty 14:00 21/03/2025
