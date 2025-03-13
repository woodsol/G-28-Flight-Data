

float xpos, ypos;

float xspeed = 2.8;  // Speed of the shape
float yspeed = 2.2;  // Speed of the shape

int xdirection = 1;  // Left or Right
int ydirection = 1;  // Top to Bottom

void setup()
{
  size(200,200);
background(0);
frameRate(30);



xpos = width/2;
ypos = height/4;

}
void draw()
{
  background(0);
  // Update the position of the shape
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );

  
  square(20, ypos, 40);
  noStroke(); fill(255, 0, 0);
  square(xpos, 40, 40);
  noStroke(); fill(250, 100, 0);
  square(xpos, ypos, 40);
  noStroke(); fill(25, 100, 200);

}
