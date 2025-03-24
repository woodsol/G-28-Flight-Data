class ResultsScreen {
    ArrayList<Flight> results;
    int scrollY = 0;
    int totalHeight;
    float ratio;
    float scrollbarWidth = 10;
    boolean locked;
    int prevMy;
    int resultHeight = 60;

    ResultsScreen() {
        totalHeight = height;
        ratio = ((float) height) / ((float) totalHeight);
    }

    public void loadResults(ArrayList<Flight> results) {
        this.results = results;
        totalHeight = this.results.size() * resultHeight;
        ratio = ((float) height) / ((float) totalHeight);
    }

    void drawScrollbar() {
        ellipseMode(CORNER);
        noStroke();
        fill(105, 105, 105);
        rect(width-((int) scrollbarWidth), 0, scrollbarWidth, height);
        fill(213, 197, 200);
        rect(width-((int) scrollbarWidth), scrollY, scrollbarWidth, height * ratio);
    }
    
    void handleScrollLogic() {
        if (mouseX > width - scrollbarWidth) {
            if (scrollbarWidth < 15) {
                scrollbarWidth += 0.3;
            }
        } else if (scrollbarWidth > 10) {;
            scrollbarWidth -= 0.3;
        }
        
        if (mousePressed) {
            if (locked) {
                scrollY += mouseY - prevMy;
                prevMy = mouseY;
                
                if (scrollY + ((int) height * ratio) > height) {
                    scrollY = height - ((int) (height * ratio));
                } else if (scrollY < 0) {
                    scrollY = 0;
                }
            } else if (mouseX > width - scrollbarWidth) {
                prevMy = mouseY;
                locked = true;
            }
        }
    }

    public void draw() {
        background(42, 43, 46);
        
        for (int index = scrollY / resultHeight; index < results.size(); index++) {
            fill(42, 43, 46);
            stroke(2);
            rect(0, (index - scrollY / resultHeight) * resultHeight - scrollY % resultHeight, width - 10, resultHeight);
        }
        
        drawScrollbar();
        handleScrollLogic();
    }
    
    public void unlock() {
        locked = false;
    }
}

// Christian Barton Randall 24/3/2025
