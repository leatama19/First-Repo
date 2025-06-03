PImage img;

void setup() {
  size(750, 600);
  img = loadImage("bleach.jpg");
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    
    //swap color channels (RGB > BGR)
    img.pixels[i] = color(b, g, r);
  }
  img.updatePixels();
    
  image(img, 0, 0);  
}

void keyPressed() {
  if(keyCode == ENTER) {
    saveFrame("colorswapsample.png");
    
  }
}
