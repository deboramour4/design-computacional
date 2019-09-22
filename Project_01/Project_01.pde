import processing.sound.*;

//Audio manager
AudioManager myManager = new AudioManager(50);

// Mandala
MandalaCreator creator = new MandalaCreator(10);

void setup() {
  // initial setups
  size(500, 500);
  frameRate(5);

  // create the input stream
  //myManager.startListening(new AudioIn(this, 0), new Amplitude(this));

}

void draw() { 
  // set background color
  background(255);
  stroke(0);
  strokeWeight(1);
  
  // draw elements
  creator. createMandala();

  // draw mandala outlines
  creator.drawOutlines();
}
