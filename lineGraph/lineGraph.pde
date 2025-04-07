GraphLine graphLine;
int[]distanceArray;
boolean animationRunning = false;

// Database
import de.bezier.data.sql.*;
SQLite db;

void setup()
{
  size(600, 600);
  smooth();
  
  db = new SQLite( this, "flights.db" );
  Data data = new Data(db);
  ArrayList<Flight> flights = data.loadFlightsFromCSV(0, 1000); 
  
  ArrayList<Flight> topTenFlights = getTopTenFlights(flights);
  ArrayList<Integer> distances = getDistances(topTenFlights); 
  
  distanceArray = new int[distances.size()];
  for (int i = 0; i < distances.size(); i++) 
  {
    distanceArray[i] = distances.get(i);
  }
  
  graphLine = new GraphLine(distanceArray);
}

void draw()
{
  if (mousePressed && !animationRunning) 
  {
    graphLine.startAnimation();
    animationRunning = true;
  }
  
  if (animationRunning) 
  {
    graphLine.updateAnimation();
    graphLine.drawAnimated(100, 100);
    
    if (graphLine.isAnimationComplete()) {
      animationRunning = false;
    }
  }
}

public ArrayList<Flight> getTopTenFlights(ArrayList<Flight> flights) 
{
  ArrayList<Flight> sortedFlights = new ArrayList<Flight>(flights);
  
  sortedFlights.sort((f1, f2) -> f2.DISTANCE - f1.DISTANCE);
  
  return new ArrayList<Flight>(sortedFlights.subList(0, min(10, sortedFlights.size())));
}

public ArrayList<Integer> getDistances(ArrayList<Flight> flights) 
{
    ArrayList<Integer> distances = new ArrayList<Integer>();
    for (Flight flight : flights) 
    {
        distances.add(flight.DISTANCE);
    }
    return distances;
}

public ArrayList<Flight> searchTopNByDistance(int topN) 
{
        ArrayList<Flight> results = new ArrayList<Flight>();
        if ( db.connect() ) {
            db.query("SELECT TOP " + topN + "  * FROM flights ORDER BY flight.DISTANCE DESC");

            while (db.next()) {
                Flight f = new Flight();
                db.setFromRow( f );
                results.add(f);
            }
        }
        
        return results;
    }
