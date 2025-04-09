class Flight {
    // CRS means scheduled
    public String FLDATE, MKTCARRIER, MKTCARRIERFLNUM, ORIGIN, ORIGINCITYNAME, ORIGINSTATEABR, ORIGINWAC, DEST, DESTCITYNAME, DESTSTATEABR, DESTWAC, CRSDEPTIME, DEPTIME, CRSARRTIME, ARRTIME;
    public int CANCELLED, DIVERTED, DISTANCE; // 1 is true for cancelled and diverted

    Flight() {
        // for searching
        this.FLDATE = "FL_DATE";
        this.ORIGINCITYNAME = "ORIGIN_CITY_NAME";
        this.ORIGINSTATEABR = "ORIGIN_STATE_ABR";
        this.DESTCITYNAME = "DEST_CITY_NAME";
        this.DESTSTATEABR = "DEST_STATE_ABR";
        this.CRSARRTIME = "CRS_ARR_TIME"; // Scheduled arrival time
        this.CRSDEPTIME = "CRS_DEP_TIME"; // Scheduled departure time
    }
    
    void flightDate(String value) {
      if (value.equals("")) { return; }
      value = value.concat(" 12:00:00 AM");
      this.FLDATE = "\"" + value + "\"";
    }
    
    void originStateAbr(String value) {
      if (value.equals("")) { return; }
      this.ORIGINSTATEABR = "\"" + value + "\"";
    }
    
    void originCityName(String value) {
      if (value.equals("")) { return; }
      this.ORIGINSTATEABR = "\"" + value + "\"";
    }
    
    void destinationStateAbr(String value) {
      if (value.equals("")) { return; }
      this.DESTSTATEABR = "\"" + value + "\"";
    }
    
    void destinationCityName(String value) {
      if (value.equals("")) { return; }
      this.DESTCITYNAME = "\"" + value + "\"";
    }
    
    void arrivalTime(String value) {
      if (value.equals("")) { return; }
      this.CRSARRTIME = "\"" + value + "\"";
    }
    
    void departureTime(String value) {
      if (value.equals("")) { return; }
      this.CRSDEPTIME = "\"" + value + "\"";
    }
}

// Christian Barton Randall 24/3/2025
