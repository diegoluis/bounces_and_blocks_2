Maxim maxim;

//call the classes
Ball ball;
Square pad;
Obstacle obstacle1;
Obstacle obstacle2;
Obstacle obstacle3;
Obstacle obstacle4;
Obstacle obstacle5;

//call the class for the lifes
Points point1;
Points point2;
Points point3;
//put the lifes inside an array
Points[] lifeCounter = {
  point1, point2, point3
};

//for the color of the background
int bgR;
int bgG;
int bgB;

//transparency of the obstacles
int transp=150;

//initializing audios
AudioPlayer boxexplode;
AudioPlayer edge;
AudioPlayer fall;
AudioPlayer fanfarre;
AudioPlayer hitbox;

//for the score of the game
int score= 0;

//lifes
int lifes=3;

//for the game over
PImage gameOver;
PImage playBtn;
PImage playPressed;
float btnX; //postion of the buttons
float btnY=600;
//game over starter
boolean over= false;

void setup() {
  //load the sound fx
  maxim= new Maxim(this);
  boxexplode= maxim.loadFile("ping.wav");
  boxexplode.setLooping(false);
  boxexplode.volume(.6);

  edge= maxim.loadFile("edge.wav");
  edge.setLooping(false);
  edge.volume(.7);

  fall= maxim.loadFile("fall.wav");
  fall.setLooping(false);
  fall.volume(.7);

  fanfarre= maxim.loadFile("fanfarre.wav");
  fanfarre.setLooping(false);
  fanfarre.volume(1);

  hitbox= maxim.loadFile("hitbox.wav");
  hitbox.setLooping(false);
  hitbox.volume(0.5);

  size(600, 800);
  //call the function to start the game
  startGame();

  //load the images
  gameOver= loadImage("gameOver.png");
  playBtn= loadImage("playBtn.png");
  playPressed= loadImage("playPressed.png");
  //position of the button
  btnX= width/2;
}

void draw() {
  rectMode(CENTER);
  background(bgR, bgG, bgB);
  //call the functions for the ball
  ball.update();
  ball.checkEdges();
  ball.display();
  //the ball interact with the obstacles
  ball.hitPad(pad);
  ball.hitObst(obstacle1);
  ball.hitObst(obstacle2);
  ball.hitObst(obstacle3);
  ball.hitObst(obstacle4);
  ball.hitObst(obstacle5);
  //display the pad
  pad.display();
  //display obsstacles
  obstacle1.display();
  obstacle2.display();
  obstacle3.display();
  obstacle4.display();
  obstacle5.display();
  //update obstacles
  obstacle1.update();
  obstacle2.update();
  obstacle3.update();
  obstacle4.update();
  obstacle5.update();
  //check the edges
  //update obstacles
  obstacle1.checkEdges();
  obstacle2.checkEdges();
  obstacle3.checkEdges();
  obstacle4.checkEdges();
  obstacle5.checkEdges();

  //create the life counter calling the objects from the life's array
  for ( int i= 0; i<lifes; i++) {
    lifeCounter[i]= new Points(25+(25*i), 25);
  }

  //display the score
  fill(0);
  text("Score: " + score, width-80, 25);
  
  //If all the three lifes are lost the "Game Over" graphics appear
  if (over) {
    background(255);
    imageMode(CENTER);
    image(gameOver, width/2, height/2);
    image(playBtn, btnX, btnY);
    //if the mouse is over the area of the button
    if (mouseX>=btnX-226/2 & mouseX<=btnX+226/2 & mouseY<=btnY+77/2 & mouseY>=btnY-77/2) {
      image(playPressed, btnX, btnY);
    }
  }
}

void mouseDragged() {
  //move the squares
  pad.update();
  /*
  obstacle1.update();
  obstacle2.update();
  obstacle3.update();
  obstacle4.update();
  obstacle5.update();
  */
}

void mousePressed() {
  //click to start the game
  ball.startBall();
}

void mouseReleased() {
  //click to restart the game when game is over
  if (mouseX>=btnX & mouseX<=btnX+226/2 & over) {
    image(playPressed, btnX, btnY);
    over=false;
    lifes=3;
    startGame();
  }
}

//this is the function to start the game
void startGame() {
  background(bgR, bgG, bgB);
  //create a new ball
  ball = new Ball(width/2, height-120, 0, 0, 0, 0, 10);
  //create the pad
  pad= new Square(width/2, height-100, 100, 20, color(100, 100, 115));
  //create obstacles
  obstacle1= new Obstacle(int(random(width)), int(random(height)/1.5), 90, 90, color(70, 100, 180,transp),random(1), random(1));
  obstacle2= new Obstacle(int(random(width)), int(random(height)/1.5), 60, 60, color(220, 100, 70,transp), random(1), random(1));
  obstacle3= new Obstacle(int(random(width)), int(random(height)/1.5), int(random(50, 100)), int(random(50, 100)), color(100, 180, 120,transp), random(1), random(1));
  obstacle4= new Obstacle(int(random(width)), int(random(height)/1.5), int(random(40, 100)), int(random(40, 100)), color(180, 150, 200,transp),random(1), random(1));
  obstacle5= new Obstacle(int(random(width)), int(random(height)/1.5), int(random(60, 100)), int(random(60, 100)), color(100, 220, 180,transp),random(1), random(1));
  //set the initial color of the bg
  bgR=255;
  bgG=255;
  bgB=255;
  //play the sound
  fanfarre.cue(0);
  fanfarre.play();
}

//create the ball as an object
class Ball {
  //vectors for location speed and acceleration
  PVector location;
  PVector velocity;
  PVector acceleration;
  //max speed
  float topspeed;

  //the constructor for making objects with custom parameters
  Ball(float locX, float locY, float velX, float velY, float accX, float accY, float velmax) {
    location = new PVector(locX, locY);
    velocity = new PVector(velX, velY);
    acceleration = new PVector(accX, accY);
    topspeed=velmax;
  }

  //function for the movement of the ball
  void update() {
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  //function to display the object
  void display() {
    noStroke();
    fill(0);
    ellipse(location.x, location.y, 15, 15);
  }

  //what to do when reaches the edges: change direction
  void checkEdges() {
    //left side
    if (location.x>width) {
      velocity.x*=-1;
      acceleration.x*=-1;
      //the colors of the background change
      bgR= int(random(255));
      bgB= int(random(255));
      bgB= int(random(255));
      //play the sound
      edge.cue(0);
      edge.play();
    }
   //right side 
    else if (location.x<0) {
      velocity.x*=-1;
      acceleration.x*=-1;
      //the colors of the background change
      bgR= int(random(255));
      bgB= int(random(255));
      bgB= int(random(255));
      edge.cue(0);
      edge.play();
    }
    //bottom
    //when the ball pass the bottom player loose one life, the game restarts
    if (location.y>height) {
      lifes-=1;
      //check if the user still has lifes left otherwhise Game Over
      if (lifes>0) {
        fall.cue(0);
        fall.play();
        startGame();
      }
      else {
        score= 0;
        over=true;
      }
    }
   //top. the user gains one point 
    else if (location.y<0) {
      velocity.y *= -1;
      acceleration.y *= -1;
      //the colors of the background change
      bgR= int(random(255));
      bgB= int(random(255));
      bgB= int(random(255));
      edge.cue(0);
      edge.play();
      score += 1;
    }
  }

  //when the ball hit the pad
  void hitPad(Square object) {
    //the pad changes color introduces variation to the direction of the ball
    if ((location.y>=object.location.y-object.hgt/2 & location.y<=object.location.y+object.hgt/2) & (location.x>= object.location.x-object.wdt/2 & location.x<= object.location.x+object.wdt/2 )) {
     if (location.y<=object.location.y+object.hgt/2) {
      location.y=object.location.y-object.hgt/2;
      //change direction
      acceleration.y *= -1;
      velocity.y = (velocity.y*random(1000))*-1;
      //change the color of the obstacles
      object.c= color(random(255), random(255), random(255), transp);
      //play sound
      hitbox.cue(0);
      hitbox.play();
    }else if (location.y>=object.location.y-object.hgt/2) {
      location.y=object.location.y+object.hgt/2;
      //change direction
      acceleration.y *= -1;
      velocity.y = (velocity.y*random(1000))*-1;
      //change the color of the obstacles
      object.c= color(random(255), random(255), random(255), transp);
      hitbox.cue(0);
      hitbox.play();
      }
    }
  }

  //when the ball hit the obstacles

  void hitObst(Obstacle object) {

    if ((location.y>=object.location.y-object.hgt/2 & location.y<=object.location.y+object.hgt/2) & (location.x>= object.location.x-object.wdt/2 & location.x<= object.location.x+object.wdt/2 )) {
      //change direction
      if (location.y<=object.location.y+object.hgt/2) {
      location.y=object.location.y+object.hgt/2;
      //change direction
      acceleration.y *= -1;
      velocity.y = (velocity.y*random(1000))*-1;
      //change the color of the obstacles
      object.c= color(random(255), random(255), random(255), transp);
      //x
      velocity.x= (velocity.x*random(10))*-1;
      acceleration.x*=-1;
      //play sound
      boxexplode.cue(0);
      boxexplode.play();
    }else if (location.y>=object.location.y-object.hgt/2) {
      location.y=object.location.y+object.hgt/2;
      //change direction
      acceleration.y *= -1;
      velocity.y = (velocity.y*random(1000))*-1;
      //change the color of the obstacles
      object.c= color(random(255), random(255), random(255), transp);
      //play sound
      boxexplode.cue(0);
      boxexplode.play();
    }
      velocity.x= (velocity.x*random(1000))*-1;
      acceleration.x*=-1;

      
    }
    
    
    
 
  }  

  void startBall() {
    //when a click is made the ball starts moving only if is not moving before
    if (velocity.x==0 & velocity.y==0) {
      acceleration = new PVector(random(0.05), random(-0.2));
    }
  }
}

//create the graphics for te counter of the lifes
class Points {
  //the constructor
  Points(int posX, int posY) {
    fill(0);
    ellipse(posX, posY, 20, 20);
  }
}

//this is a subclass of Squares made so we can move freely the obstacles in the screen
class Obstacle extends Square {
  PVector velocity;
  PVector acceleration;
  //max speed
  float topspeed;
  //constructor of the square
  Obstacle(int tempposX, int tempposY, int tempwdt, int temphgt, color tempC, float velX, float velY) {
    //to make the constructor it's necessary to call the super constructor of the square
    super(tempposX, tempposY, tempwdt, temphgt, tempC);
    velocity = new PVector(velX, velY);
    acceleration = new PVector(random(1), random(1));
    topspeed=.75;
  }

  //update the object
  void update() {
    //if the mouse is over the obstacle moves in X and Y
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }

  //what to do when reaches the edges: change direction
  void checkEdges() {
    //left side
    if (location.x>width) {
      velocity.x= (velocity.x*random(10))*-1;
      acceleration.x*=-1;
    }
    //right side 
    else if (location.x<0) {
      velocity.x= (velocity.x*random(10))*-1;
      acceleration.x*=-1;
    }
    //bottom
    //when the ball pass the bottom player loose one life, the game restarts
    if (location.y>height) {
      velocity.y = (velocity.y*random(1, 2))*-1;
      acceleration.y*=-1;
    }
    //top. the user gains one point 
    else if (location.y<0) {
      velocity.y = (velocity.y*random(1, 2))*-1;
      acceleration.y *= -1;
    }
  }
}

//create an object for the pad
class Square {
  //variables for position
  PVector location;
  int posX;
  int posY;
  //variables for size
  int wdt;
  int hgt;
  int finalWidth;
  int finalHeight;
  //color
  color c;
  //constructor of the square
  Square(int tempposX, int tempposY, int tempwdt, int temphgt, color tempC) {
    //create vector for positioning the object
    location = new PVector(tempposX, tempposY);
    posX= tempposX;
    posY= tempposY;
    wdt= tempwdt;
    hgt= temphgt;
    c= tempC;
  }
  //display the object according to the parameters given in setup
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(c);
    rect(location.x, location.y, wdt, hgt);
  }
  //update the object
  void update() {
    //if the mouse is over the pad moves in X
    if ((mouseX>=location.x-wdt/2 & mouseX<=location.x+wdt/2)&(mouseY>=(location.y-hgt/2)-50 & mouseY<=(location.y+hgt/2)+50)) {
      location.x= mouseX;
      finalWidth= mouseX+wdt;
      finalHeight= posY;
    }
  }
}


