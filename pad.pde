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

