import processing.sound.*; 

SinOsc bass;       // sine wave oscillator for the bass
TriOsc tri;        // triangle wave oscillator
SawOsc saw;        // saw wave oscillator
LowPass filter;    // low-pass filter

void setup() {
  size(400, 400);
  noStroke();

  bass = new SinOsc(this);
  bass.freq(500);
  bass.amp(0.2);
  bass.play();

  tri = new TriOsc(this);
  tri.freq(400);
  tri.amp(0.2);
  tri.play();

  saw = new SawOsc(this);
  saw.freq(600);
  saw.amp(0.1);
  saw.play();

  filter = new LowPass(this);
  filter.process(saw);
  filter.freq(700);
}

void draw() {
  background(0);

  float ampControl = map(mouseX, 0, width, 0, 0.5);
  bass.amp(ampControl);
  tri.amp(ampControl);
  saw.amp(ampControl);

  float filterFreq = map(mouseY, 0, height, 2000, 200);
  filter.freq(filterFreq);

  // draw circle for each oscillator
  fill(255, 100, 100);
  ellipse(width * 0.2, height / 2, ampControl * 400, ampControl * 400);

  fill(100, 255, 100);
  ellipse(width * 0.5, height / 2, ampControl * 400, ampControl * 400);

  fill(100, 100, 255);
  ellipse(width * 0.8, height / 2, ampControl * 400, ampControl * 400);

  // displays bottom text 
  fill(255);
  textAlign(CENTER);
  textSize(14);
  text("Left to decrease", width / 2, height * 0.85);
  text("Right to increase", width / 2, height * 0.9);
}
