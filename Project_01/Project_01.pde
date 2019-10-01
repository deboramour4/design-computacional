import processing.sound.*;

//Audio manager
AudioManager audioManager = new AudioManager(100);

// Mandala
MandalaCreator creator = new MandalaCreator(12);

void setup() {
  // initial setups
  size(displayWidth, displayHeight);

  // create the input stream 
  audioManager.startListening(new AudioIn(this, 0), new Amplitude(this), new FFT(this, 64));
  
  // color mode
  colorMode(HSB);
}

void draw() {  
  // set background color
  background(0);
  
  translate(width/2, height/2);
  rectMode(CENTER);
  
  // draw elements
  int amplitudeRelative = audioManager.amplitude() * mouseY/100;
  creator.createMandala(amplitudeRelative, 1.0);
  
  println(amplitudeRelative);
  
}
