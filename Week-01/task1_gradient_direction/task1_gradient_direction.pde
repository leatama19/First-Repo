void setup() {
  size(400, 400); //set the size
}

void draw() {
  
  loadPixels(); 
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      float normalizedY = map(y, 0, height, 0, 1);
      int red = 250;
      int green = int(150 * normalizedY);
      int blue = int(180 * normalizedY);
      
      color c = color(red, green, blue);
      
      pixels[x + y * width] = c; //correctly index to 1D pixels
     }
  }
  updatePixels();

}
