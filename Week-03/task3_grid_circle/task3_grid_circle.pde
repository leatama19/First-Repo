int cols = 3; //number of columns
int rows = 5; //number of rows
float circleSize = 100; //diameter of circle

//fiixed color is pink
color fixedColor = color(255, 20, 147); 

void setup() {
  size(300, 500);
  noStroke();
  noLoop();
}

void draw() {
  background(255); //white background
  
  
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
     float cx = x * circleSize + circleSize / 2;
     float cy = y * circleSize + circleSize / 2;

      
      if ((x + y) % 2 == 0) { //modulo to alternate between random and fixed color
        fill(random(255), random(255), random(255));
      } else {
        fill(fixedColor);
      }

      ellipse(cx, cy, circleSize, circleSize); //circle drawn
    }
  }
}
