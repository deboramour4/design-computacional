import processing.sound.*;

//Audio manager
AudioManager audioManager = new AudioManager(50);

// Mandala
MandalaCreator creator = new MandalaCreator(5);

void setup() {
  // initial setups
  size(512, 512);
  frameRate(2);

  // create the input stream 
  audioManager.startListening(new AudioIn(this, 0), new Amplitude(this), new FFT(this, 64));

}

void draw() {  
  
  float numberOfSlices = map(mouseY, 0, 500, 6, 50);
  creator.slices = int(numberOfSlices);
  
  // set background color
  background(0);
  
  // draw elements
  creator.createMandala(1.0);

  // draw mandala outlines
  //creator.drawOutlines();
}
