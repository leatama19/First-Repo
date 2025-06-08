PImage bgImage;

ArrayList<FallingObject> foodList; //Food object list
ArrayList<FallingObject> rubbishList; //Rubbish objects list

Fish player;
int score = 0; //players score
boolean gameOver = false;
String gameState = "start"; 
int wave = 1;
int pauseStartTime = 0; //pause time between each wave

void setup() {
  size(600, 400);
  bgImage = loadImage("water.jpg"); //Background image loaded
  player = new Fish();
  foodList = new ArrayList<FallingObject>(); //initialize both lists
  rubbishList = new ArrayList<FallingObject>();
}

void draw() {
  if (gameState.equals("start")) {
    startScreen();
  } else if (gameState.equals("play")) {
    playGame();
  } else if (gameState.equals("wavePause")) {
    showWavePause();
  }
}

void startScreen() {
  background(0, 100, 200); // blue background
  fill(255);
  textAlign(CENTER);
  textSize(48);
  text("Fish Game", width / 2, height / 2 - 60);

  // Draws the start button
  fill(255, 200, 0);
  rect(width/2 - 60, height/2, 120, 40, 10);
  fill(0);
  textSize(20);
  text("START", width / 2, height/2 + 27);
}

void mousePressed() { //This starts the game when button is clicked
  if (gameState.equals("start")) {
    if (mouseX > width/2 - 60 && mouseX < width/2 + 60 &&
        mouseY > height/2 && mouseY < height/2 + 40) {
      gameState = "play";
    }
  }
}

void playGame() {
  image(bgImage, 0, 0, width, height);

  if (!gameOver) {
    float difficultyMultiplier = 1.0;

    if (score >= 40 && wave < 3) {
      wave = 3;
      pauseStartTime = millis();
      gameState = "wavePause";
      return;
    } else if (score >= 20 && wave < 2) {
      wave = 2;
      pauseStartTime = millis();
      gameState = "wavePause";
      return;
    }
    if (wave == 2) difficultyMultiplier = 1.5; //Adjusts the difficulty by wave
    if (wave == 3) difficultyMultiplier = 2.0;

    int foodRate = int(60 / difficultyMultiplier);
    int rubbishRate = int(120 / difficultyMultiplier);

    if (frameCount % foodRate == 0) {
      foodList.add(new FallingObject(random(width), 0, color(255, 200, 0), "food", difficultyMultiplier));
    }

    if (frameCount % rubbishRate == 0) {
      rubbishList.add(new FallingObject(random(width), 0, color(80), "rubbish", difficultyMultiplier));
    }

    for (int i = foodList.size() - 1; i >= 0; i--) {
      FallingObject f = foodList.get(i);
      f.applyForces();
      f.update();
      f.display();

      if (f.pos.y > height) {
        foodList.remove(i);
      } else if (player.collidesWith(f)) {
        score++;
        foodList.remove(i);
      }
    }

    for (int i = rubbishList.size() - 1; i >= 0; i--) {
      FallingObject r = rubbishList.get(i);
      r.applyForces();
      r.update();
      r.display();

      if (r.pos.y > height) {
        rubbishList.remove(i);
      } else if (player.collidesWith(r)) {
        gameOver = true;
      }
    }

    player.update();
    player.display();
    //displays score
    fill(255);
    textSize(20);
    text("Score: " + score, 40, 30); //Score is placed onn the top left of the screen
  } else { //game over text
    fill(255, 50, 50);
    textSize(40);
    textAlign(CENTER);
    text("Game Over!", width/2, height/2);
    textSize(24);
    text("Final Score: " + score, width/2, height/2 + 40);
  }
}

void showWavePause() {
  image(bgImage, 0, 0, width, height);
  fill(0, 100);
  rect(0, 0, width, height);
  fill(255); //shows wave number
  textAlign(CENTER); 
  textSize(48);
  text("Wave " + wave, width/2, height/2);
  //3 seconds pause before game resumes
  if (millis() - pauseStartTime > 3000) {
    gameState = "play";
  }
}

class Fish {
  PVector pos;
  float size = 50;

  Fish() {
    pos = new PVector(width/2, height - 80);
  }

  void update() {
    pos.x = mouseX;
   pos.y = mouseY;
   pos.x = constrain(pos.x, size/2, width - size/2);
    pos.y = constrain(pos.y, size/2, height - size/2);
  }

  void display() {
    noStroke();
    fill(255, 150, 50);
    ellipse(pos.x, pos.y, size * 1.5, size);
    triangle(pos.x - size/2, pos.y, pos.x - size, pos.y - size/3, pos.x - size, pos.y + size/3);
    fill(0);
    ellipse(pos.x + size/4, pos.y - size/8, size/5, size/5);
  }

  boolean collidesWith(FallingObject obj) {
    return dist(pos.x, pos.y, obj.pos.x, obj.pos.y) < (size/2 + obj.size/2);
  }
}

class FallingObject {
  PVector pos, vel, acc;
  color c;
  float size = 30;
  String type;
  float multiplier;

  FallingObject(float x, float y, color c, String type, float multiplier) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    this.c = c;
    this.type = type;
    this.multiplier = multiplier;
  }

  void applyForces() {
    acc.y = 0.2 * multiplier;  //downwards gravity force
    acc.x = random(-0.05, 0.05); 
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }

  void display() {
    fill(c);
    if (type.equals("food")) {
      ellipse(pos.x, pos.y, size, size); //food appears as a circle
     
    } else if (type.equals("rubbish")) {
      rect(pos.x, pos.y, size, size); // rubbish appears as a square
    }
  }
}
