class Data {
    String[] FlightsFile;
    Data() {
        FlightsFile = loadStrings("./Flights1k.csv");
    }

    public ArrayList<Flight> loadFlights(int range_start, int range_end) {
        ArrayList<Flight> flights = new ArrayList<Flight>();
        for (int i = range_start+1; i < range_end+1; i++) {
            String currentLine = FlightsFile[i];

            String[] values = currentLine.split(",");

            Flight flight = new Flight();

            flight.FL_DATE = values[0];
            flight.MKT_CARRIER = values[1];
            flight.MKT_CARRIER_FL_NUM = values[2];
            flight.ORIGIN = values[3];
            flight.ORIGIN_CITY_NAME = values[4] + "," + values[5];
            flight.ORIGIN_STATE_ABR = values[6];
            flight.ORIGIN_WAC = values[7];
            flight.DEST = values[8];
            flight.DEST_CITY_NAME = values[9] + "," + values[10];
            flight.DEST_STATE_ABR = values[11];
            flight.DEST_WAC = values[12];
            flight.CRS_ARR_TIME = values[13];
            flight.ARR_TIME = values[14];
            flight.CANCELLED = values[15] == "1";
            flight.DIVERTED = values[16] == "1";
            flight.DISTANCE = values[17];
            
            flights.add(flight);
        }
        
        return flights;
    }
}
