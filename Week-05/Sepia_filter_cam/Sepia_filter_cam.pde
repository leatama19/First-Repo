import processing.video.*;

Capture cam;

void setup() {
  size(640, 480);
  pixelDensity(1); 

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("No cameras available.");
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

  for (int i = 0; i < cam.pixels.length; i++) {
    color c = cam.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);

    //sepia filter
    float sepiaR = (r * 0.393) + (g * 0.769) + (b * 0.189);
    float sepiaG = (r * 0.349) + (g * 0.686) + (b * 0.168);
    float sepiaB = (r * 0.272) + (g * 0.534) + (b * 0.131);

    sepiaR = constrain(sepiaR, 0, 255);
    sepiaG = constrain(sepiaG, 0, 255);
    sepiaB = constrain(sepiaB, 0, 255);

    pixels[i] = color(sepiaR, sepiaG, sepiaB);
  }

  updatePixels();
}

void keyPressed() {
  if (key == ENTER) {
    saveFrame("frame-####.jpg");
  }
}
