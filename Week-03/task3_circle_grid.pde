float cols = 3;
float rows = 5;
float circleSize = 60;

color fixedColor = color(255, 20, 147); 

void setup() {
  size(200, 310);
  noStroke();
  noLoop();
}

void draw() {
  background(0);
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      float cx = x * circleSize + circleSize /1.6;
      float cy = y * circleSize + circleSize / 1.8;

      if ((x + y) % 2 == 0) {
       fill(random(0), random(100, 255), random(0));
      } else {
       fill(fixedColor);
       
     }
      
    ellipse(cx, cy, circleSize, circleSize);
    
    }
  }
}
