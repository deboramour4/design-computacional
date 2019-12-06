/**
 * Which Face Is Which
 * Daniel Shiffman
 * http://shiffman.net/2011/04/26/opencv-matching-faces-over-time/
 *
 * Modified by Jordi Tost (call the constructor specifying an ID)
 * @updated: 01/10/2014
 */

class Face {
  
  Rectangle r;
  int id;
  boolean available; // Is available to be matched?  
  boolean delete;
  int timer = 50; // Time to live if disappeared?
  
  
  // Make me
  Face(int newID, int x, int y, int w, int h) {
    r = new Rectangle(x, y, w, h);
    available = true;
    delete = false;
    id = newID;
  }

  // Show rectangle with id number
  void display() {
    fill(255,255,255,timer);
    stroke(0,0,0);
    rect((width-r.x)-width/2 -r.width,r.y-height/2,r.width, r.height);
    fill(255,timer*2);
    textSize(20);
    //textAlign(LEFT);
    text(""+id,(width-r.x)+10-width/2 -r.width,r.y+30-height/2);
  }

  // Give me a new location / size
  void update(Rectangle newR) {
    r = (Rectangle) newR.clone();
  }

  // Count me down, I am gone
  void countDown() {
    timer--;
  }

  // I am deed, delete me
  boolean dead() {
    if (timer < 0) return true;
    return false;
  }
}
