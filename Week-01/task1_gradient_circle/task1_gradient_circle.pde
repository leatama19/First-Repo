void setup() {
  size(400, 400);
}

void draw() {
  loadPixels();
  
  float centerX = width / 2;
  float centerY = height / 2;
  float maxDist = dist(0, 0, centerX, centerY);
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float d = dist(x, y, centerX, centerY);
      float D = d / maxDist;
      
      
      int red = 255;
      int green = (int)(255 - 105 * D);
      int blue = (int)(180 * D);
      
      color c = color(red, green, blue);
      pixels[x + y * width] = c;
    }
  }
  
  updatePixels();
}
