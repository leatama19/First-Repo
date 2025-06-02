import processing.sound.*;

SinOsc bass;       
TriOsc tri;      
SawOsc saw;    
LowPass filter;    

void setup() {
  size(400, 400);
  background(0);

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

 
}
