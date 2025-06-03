PImage sample;

void setup() {
  size(750, 600);
  sample = loadImage("bleach.jpg");
  sample.loadPixels();
}

void draw() {
  background(0);
  image(sample, 0, 0);

  int[] hRed = new int[256];
  int[] hGreen = new int[256];
  int[] hBlue = new int[256];

  // Calculate histograms for each color channel
  for (int i = 0; i < sample.pixels.length; i++) {
    color c = sample.pixels[i];
    hRed[(int)red(c)]++;
    hGreen[(int)green(c)]++;
    hBlue[(int)blue(c)]++;
  }

  
  int maxHist = max(max(max(hRed), max(hGreen)), max(hBlue));


  float xOffset = (width - 256) / 2;

  // Base heights for the three histograms, stacked bottom-up
  float baseRed = height;
  float baseGreen = height - height / 3;
  float baseBlue = height - 2 * height / 3;

  //red histogram
  stroke(255, 0, 0);
  for (int i = 0; i < 256; i++) {
    float startHeight = map(hRed[i], 0, maxHist, baseRed, baseRed - height / 3);
    line(xOffset + i, startHeight, xOffset + i, baseRed);
  }

  //green histogram
  stroke(0, 255, 0);
  for (int i = 0; i < 256; i++) {
    float startHeight = map(hGreen[i], 0, maxHist, baseGreen, baseGreen - height / 3);
    line(xOffset + i, startHeight, xOffset + i, baseGreen);
  }

  //blue histogram
  stroke(0, 0, 255);
  for (int i = 0; i < 256; i++) {
    float startHeight = map(hBlue[i], 0, maxHist, baseBlue, baseBlue - height / 3);
    line(xOffset + i, startHeight, xOffset + i, baseBlue);
  }
}
