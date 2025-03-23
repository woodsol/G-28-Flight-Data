class Data {
    String[] FlightsFile;
    Data(SQLite db) {
        
        FlightsFile = loadStrings("./Flights1k.csv");
    }

    public ArrayList<Flight> loadFlightsFromCSV(int range_start, int range_end) {
        ArrayList<Flight> flights = new ArrayList<Flight>();
        for (int i = range_start+1; i < range_end+1; i++) {
            String currentLine = FlightsFile[i];

            String[] values = currentLine.split(",");

            Flight flight = new Flight();
            
            try {
              flight.FLDATE = values[0].split(" ")[0];
              flight.MKTCARRIER = values[1];
              flight.MKTCARRIERFLNUM = values[2];
              flight.ORIGIN = values[3];
              flight.ORIGINCITYNAME = values[4] + "," + values[5];
              flight.ORIGINSTATEABR = values[6];
              flight.ORIGINWAC = values[7];
              flight.DEST = values[8];
              flight.DESTCITYNAME = values[9] + "," + values[10];
              flight.DESTSTATEABR = values[11];
              flight.DESTWAC = values[12];
              flight.CRSARRTIME = values[13];
              flight.ARRTIME = values[14];
              flight.CANCELLED = (int) Float.parseFloat(values[15]);
              flight.DIVERTED = (int) Float.parseFloat(values[16]);
              flight.DISTANCE = (int) Float.parseFloat(values[17]);
            } catch (Exception e) {}
            
            flights.add(flight);
        }
        
        return flights;
    }
    
    public ArrayList<Flight> search(Flight search_query) {
        ArrayList<Flight> results = new ArrayList<Flight>();
        if ( db.connect() ) {
            db.query("SELECT * FROM flights WHERE FL_DATE="+search_query.FLDATE+" AND ORIGIN_CITY_NAME="+search_query.ORIGINCITYNAME+" AND ORIGIN_STATE_ABR="+search_query.ORIGINSTATEABR+" AND DEST_CITY_NAME="+search_query.DESTCITYNAME+" AND DEST_STATE_ABR="+search_query.DESTSTATEABR+" AND CRS_ARR_TIME="+search_query.CRSARRTIME+" AND CRS_DEP_TIME="+search_query.CRSDEPTIME);

            while (db.next()) {
                Flight f = new Flight();
                db.setFromRow( f );
                results.add(f);
            }
        }
        
        return results;
    }
}
