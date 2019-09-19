import processing.sound.*;

AudioIn in;
Amplitude amp;

float sum;
float sFactor = 50;
float[] history = new float[500];//float[1000000];

void setup() {
  size(500, 500);

  // Create the Input stream
  in = new AudioIn(this, 0);
  in.play();
  amp = new Amplitude(this);
  amp.input(in);

  frameRate(5);
}

void draw() {
  background(0);

  sum = (amp.analyze()) * sFactor;
  history = append(history, sum);



  for (int i = 0; i < history.length; i++) {
    float y = map(history[i], 0, 1, 0, height/2);
    point(i, y); 

    println(i+" "+y);
  }

  point(250, 250);

  fill(255);
  stroke(255);
  strokeWeight(5);
  //noStroke(5);
  //circle(width/2,height/2, sum);
}
