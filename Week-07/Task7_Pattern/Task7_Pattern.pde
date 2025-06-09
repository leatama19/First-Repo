import processing.sound.*;

SoundFile click; 
SoundFile kick; 
SoundFile snare; 
SoundFile clap;

float bpm = 120;
float myFrameRate = bpm / 60;  //frames per second 

void setup() {
  size(400, 400);
  frameRate(myFrameRate);

  // Load samples
  click = new SoundFile(this, "sampleclick.wav");
  kick = new SoundFile(this, "samplekick.wav");
  snare = new SoundFile(this, "snare.wav");
  clap = new SoundFile(this, "clap.wav");
}

void draw() {
  background(random(255), random(255), random(255));

  int beat = frameCount % 8;  // 8 beat loop
  
  // visual
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(beat, width / 2, height / 2);

  // base pattern
  if (beat == 0 || beat == 4) {
    kick.play();
  }

  if (beat == 2 || beat == 6) {
    snare.play();
  }

  click.play();

  // random pattern change  
  if ((frameCount / 8) % 2 == 1 && beat == 4) {
    if (random(1) > 0.5) {
      clap.play();
    }
  }
}
