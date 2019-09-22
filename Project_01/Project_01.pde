import processing.sound.*;

//Audio manager
AudioManager audioManager = new AudioManager(50);

// Mandala
MandalaCreator creator = new MandalaCreator(10);

void setup() {
  // initial setups
  size(512, 512);
  frameRate(5);

  // create the input stream 
  audioManager.startListening(new AudioIn(this, 0), new Amplitude(this), new FFT(this, 64));

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
