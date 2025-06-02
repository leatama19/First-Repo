import processing.sound.*;

SinOsc osc;
float oscFreq = 0.5;

void setup() {
  size(400, 400);
  
  osc = new SinOsc(this);
  osc.freq(400);
  osc.amp(0.5);
  osc.play();
}

void draw() {
  background(0);
  loadPixels();

  float freq = map(mouseX, 0, width, 150, 400);
  osc.freq(freq);
 
  oscFreq = map(mouseX, 0, width, 0.05, 0.5);

  float time = millis() / 1000.0;
  float oscValue = sin(TWO_PI * oscFreq * time);
  float mappedValue = (oscValue + 1) / 2.0;  // 0..1


  float centerX = width / 2;
  float centerY = height / 2;

 
  float maxRadius = lerp(width / 4, width / 2, mappedValue);

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float d = dist(x, y, centerX, centerY);
      float D = d / maxRadius;
      D = constrain(D, 0, 1);

      int red = 255;
      int green = (int)(255 - 105 * D);
      int blue = (int)(180 * D);

      green = (int)(green * mappedValue);
      blue = (int)(blue * (1 - mappedValue));

      color c = color(red, green, blue);
      pixels[x + y * width] = c;
    }
  }

  updatePixels();
}
