class Button {
    int x, y, w, h;
    String label;
    
    Button(int x, int y, int w, int h, String label) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.label = label;
    }
    
    void draw() {
        fill(200);
        rect(x, y, w, h, 10);
        fill(0);
        text(label, x + 10, y + 25);
    }
    
    boolean isClicked(int mx, int my) {
        return (mx > x && mx < x + w && my > y && my < y + h);
    }
}
// code done by Daniel Doolan at 5:28 pm 19/03/2025
