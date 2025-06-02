void setup() {
  size(400,400); //sets the canvas size
}


void draw() {

  loadPixels(); 

  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      float normalizedD = map(x + y, 0, width + height, 0, 1);

      //set color 
      int red = 250;
      int green = int(150 * normalizedD);
      int blue = int(180 * normalizedD);
      
      //create the color
      color c = color(red, green, blue);
      
      pixels[x + y * width] = c; //correctly index to 1D pixels
     }
  }
  updatePixels();

}
