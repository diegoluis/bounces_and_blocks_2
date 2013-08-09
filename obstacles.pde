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

