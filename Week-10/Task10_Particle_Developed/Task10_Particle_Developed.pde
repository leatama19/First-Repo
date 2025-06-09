ArrayList<HaloParticle> particles;
ArrayList<PopText> pops;
PFont font;

void setup() {
  size(400, 300);
  particles = new ArrayList<HaloParticle>();
  pops = new ArrayList<PopText>();
  strokeWeight(0.5); 
  stroke(150, 20, 60); // dark pink stroke
}

void draw() {
  background(230, 240, 255); // soft blue

  drawHaloHaloBowl(width/2, height - 80);

  for (int i = particles.size() - 1; i >= 0; i--) {
    HaloParticle p = particles.get(i);
    p.applyForces();
    p.update();
    p.display();
    
    if (p.isOffScreen()) {
      particles.remove(i);
    }
  }

  for (int i = pops.size() - 1; i >= 0; i--) {
    PopText pt = pops.get(i);
    pt.update();
    pt.display();
    if (pt.isFinished()) {
      pops.remove(i);
    }
  }
}

void mousePressed() {
  for (int i = 0; i < int(random(10, 15)); i++) {
    particles.add(new HaloParticle(new PVector(width/2, height - 80)));
  }
  pops.add(new PopText(mouseX, mouseY));
}
//draws halo halo bowl
void drawHaloHaloBowl(float x, float y) {
  fill(255, 250, 230);
  ellipse(x, y, 140, 80); //bowl base
  
  fill(255, 200, 220);
  ellipse(x, y - 15, 130, 50); //bowl rim
  
  fill(255, 230, 210);
  ellipse(x, y - 25, 100, 30); //shaved ice
}

class HaloParticle {
  PVector pos, vel, acc; 
  float size;
  color c;
  float alpha;

  HaloParticle(PVector startPos) {
    pos = startPos.copy();
    vel = new PVector(random(-1, 1), random(-4, -2));
    acc = new PVector(0, 0);
    size = random(8, 15);
    alpha = 255;

    color[] colors = {
      color(165, 42, 42),  // ube (purple-ish brown)
      color(255, 182, 193), // pink jelly
      color(255, 223, 0),  // leche flan yellow
      color(135, 206, 250), // blue jelly
      color(255, 255, 255),  // white nata de coco
      color(255, 105, 180),   // bright pink
      color(138, 43, 226)  // dark purple
    };
    c = colors[int(random(colors.length))];
  }

  void applyForces() {
    acc.add(new PVector(random(-0.1, 0.1), 0));
    acc.add(new PVector(0, 0.05));
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    
    alpha -= 2;
    alpha = constrain(alpha, 0, 255);
  }

  void display() {
    fill(red(c), green(c), blue(c), alpha);
    ellipse(pos.x, pos.y, size, size);
  }

  boolean isOffScreen() {
    return pos.y > height + 20 || alpha <= 0;
  }
}

class PopText {
  float x, y;
  float alpha;
  float size;

  PopText(float x, float y) {
    this.x = x;
    this.y = y;
    this.alpha = 255;
    this.size = 16;
  }

  void update() {
    alpha -= 5;
    y -= 0.5;
    size += 0.1;
  }

  void display() {
    fill(255, 105, 180, alpha); // pink
    textAlign(CENTER);
    textSize(size);
    text("pop", x, y);
  }

  boolean isFinished() {
    return alpha <= 0;
  }
}
