import processing.data.JSONObject;
import processing.data.JSONArray;

class MapScreen {
    JSONObject statesData;
    ArrayList<State> states = new ArrayList<State>();
    PFont mapFont;

    MapScreen(PFont font) {
        mapFont = font;
        statesData = loadJSONObject("us-states.json");
        JSONArray features = statesData.getJSONArray("features");

        for (int i = 0; i < features.size(); i++) {
            JSONObject feature = features.getJSONObject(i);
            JSONObject geometry = feature.getJSONObject("geometry");
            String geometryType = geometry.getString("type");
            JSONArray coordinates = geometry.getJSONArray("coordinates");
            String name = feature.getJSONObject("properties").getString("name");
            String abbr = feature.getJSONObject("properties").getString("abbreviation");

            State state = new State(name, abbr, coordinates, geometryType);
            states.add(state);
        }
    }

    String getAbbreviation(String stateName) {
        for (State state : states) {
            if (stateName.equals(state.name)) {
                return state.abbr;
            }
        }
        
        return "";
    }

    void draw(float scale, PVector pan) {
        background(255);

        ArrayList<State> delayedRendering = new ArrayList<State>();

        for (State state : states) {
            if (state.isMouseOver(scale, pan)) {
                state.highlight();
                delayedRendering.add(state);
                continue;
            }
            state.draw(scale, pan);
        }

        // Delay the rendering of the states (state really but handle edge cases i guess) where the mouse is over them until the end so that the white border doesn't get drawn over
        for (State state : delayedRendering) {
            state.draw(scale, pan);
        }
    }
}

// Christian Barton Randall 24/3/2025
