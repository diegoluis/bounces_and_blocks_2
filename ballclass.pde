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

