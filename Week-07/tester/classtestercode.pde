import processing.sound.*;

SoundFile sample1;
SoundFile sample2;
SoundFile sample3;

float bpm = 120;

float myFrameRate = bpm / 60;

void setup() {
  size(640, 360);
  background(255);

  sample1 = new SoundFile(this, "sampleclick.wav");
  sample2 = new SoundFile(this, "samplekick.wav");
  frameRate(myFrameRate);
}

void draw() {
  background(random(255), random(255), random(255));
  
  sample1.play();
  

}
