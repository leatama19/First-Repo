PImage img;
PGraphics pg;

void setup() {
  size(517, 606);
  img = loadImage("bleach.jpg");
  pg = createGraphics(img.width, img.height, JAVA2D);

 
  pg.beginDraw();
  pg.image(img, 0, 0);
  pg.endDraw();
}

void draw() {
 
  PImage tempImg = createImage(img.width, img.height, RGB);
  tempImg.copy(img, 0, 0, img.width, img.height, 0, 0, img.width, img.height);
  tempImg.loadPixels(); 

 
  for (int i = 0; i < tempImg.pixels.length; i++) {
    color c = tempImg.pixels[i];
    float h = hue(c);
    float s = saturation(c);
    float b = brightness(c);

    float hueShift = map(mouseX, 0, width, 0, 360);
    float newHue = (h + hueShift) % 360;
    if (newHue < 0) {
      newHue += 360;
    }

    tempImg.pixels[i] = color(newHue, s, b);
  }
  tempImg.updatePixels();

 
  pg.beginDraw();
  pg.image(tempImg, 0, 0); 
  pg.endDraw();

  
  image(pg, 0, 0);
}
