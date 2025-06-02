float noiseScale = 0.01; //teal color
float time = 0; //white color
color color1, color2;

void setup() {
  size(600, 600);
  color1 = color(0, 150, 136);    
  color2 = color(255, 255, 255);  
}

void draw() {
  background(0);
  loadPixels();

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      float nx = x * noiseScale;
      float ny = y * noiseScale + time;
      float noiseVal = noise(nx, ny);

      //blend between two colors
      color c = lerpColor(color1, color2, noiseVal);
      pixels[y * width + x] = c;
    }
  }

  updatePixels();
  time += 0.01;  //animate noise over time
}
