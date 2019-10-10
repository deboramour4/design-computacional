import processing.sound.*;
AudioIn in;

Amplitude amp;
float sum;
float sFactor= 0.25;
float rmsScaled;

int diametro;

PImage photo;
int x, y;

void setup() {
  //size(800, 600);

  // Create the Input stream
  in = new AudioIn(this, 0);
  in.play();
  amp = new Amplitude(this);
  amp.input(in);
 
  size(714, 1000);
  photo = loadImage("image.jpg");
  image(photo, 0, 0);
  //background(255,255,255);
  
  frameRate(30);
}

void draw() {
   noFill();
   sum = (amp.analyze() )* sFactor;
   rmsScaled = sum * (height/20) * mouseY; 
   
  fill(255, 50);
  noStroke();
  rect(0, 0, width, height);
  
  for (int i = 0; i < 200; i++) {
    diametro = int(10*rmsScaled);
    
    x = int(random(0, width));
    y = int(random(0, height));
  
  
    int loc = x+y*width;
    color c = photo.pixels[loc];
    fill(c);
    ellipse(x, y, diametro, diametro);
  }
  
}
