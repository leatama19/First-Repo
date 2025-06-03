import processing.video.*;

Capture cam;
int savedFrames = 0;
int maxFrames = 10;

void setup() {
  size(640, 480);
  pixelDensity(1);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    cam = new Capture(this, 640, 480, cameras[0], 30);
    cam.start();
  }
}

void draw() {
  if (cam.available()) {
    cam.read();
  }

  cam.loadPixels();
  loadPixels();

  float[][] gray = new float[cam.width][cam.height];

  // Convert to grayscale
  for (int y = 0; y < cam.height; y++) {
    for (int x = 0; x < cam.width; x++) {
      color c = cam.pixels[y * cam.width + x];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      float avg = (r + g + b) / 3.0;
      gray[x][y] = avg;
    }
  }
   //Floyd-Steinberg Dithering
  for (int y = 0; y < cam.height; y++) {
    for (int x = 0; x < cam.width; x++) {
      float oldPixel = gray[x][y];
      float newPixel = oldPixel < 128 ? 0 : 255;
      float error = oldPixel - newPixel;

      gray[x][y] = newPixel; 

      // Diffuse error
      if (x + 1 < cam.width)      gray[x + 1][y]     += error * 7 / 16.0;
      if (x - 1 >= 0 && y + 1 < cam.height) gray[x - 1][y + 1] += error * 3 / 16.0;
      if (y + 1 < cam.height)     gray[x][y + 1]     += error * 5 / 16.0;
      if (x + 1 < cam.width && y + 1 < cam.height) gray[x + 1][y + 1] += error * 1 / 16.0;
    }
  }

  for (int y = 0; y < cam.height; y++) {
    for (int x = 0; x < cam.width; x++) {
      int loc = x + y * cam.width;
      float val = gray[x][y];
      val = constrain(val, 0, 255);
      pixels[loc] = color(val);
    }
  }

  updatePixels();
}

void keyPressed() {
  if (keyCode == ENTER && savedFrames < maxFrames) {
    saveFrame("frame-####.png");
    savedFrames++;
    println("Saved frame " + savedFrames + " of " + maxFrames);
  }
}
