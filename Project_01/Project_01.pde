import processing.sound.*;

//Audio manager
AudioManager audioManager = new AudioManager(100);

// Mandala
MandalaCreator creator = new MandalaCreator(10);

void setup() {
  // initial setups
  //fullScreen();
  size(displayWidth, displayHeight);
  frameRate(15);

  // create the input stream 
  audioManager.startListening(new AudioIn(this, 0), new Amplitude(this), new FFT(this, 64));

}

void draw() {  
  // set background color
  background(0);
  
  translate(width/2, height/2);
  rectMode(CENTER);
  
  // draw elements
  creator.createMandala(audioManager.amplitude(), 1.0);

  // draw mandala outlines
  //creator.slices = int(audioManager.amplitude());
  //creator.drawOutlines();
}
