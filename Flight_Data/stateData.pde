class stateData {
    public PImage image;
    public HashMap<String, PVector> cities; // City Name, PVector

    stateData(PImage image, HashMap<String, PVector> cities) {
        this.image = image;
        this.cities = cities;
    }
}
