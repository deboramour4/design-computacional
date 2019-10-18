import processing.sound.*;
FFT fft;
AudioIn in;

int scale = 5;
int bands = 16;
float r_width;

// Create a smoothing vector
float[] sum = new float[bands];

// Create a smoothing factor
float smooth_factor = 0.2;

void setup() {
  size(640, 360);
  background(255);
  colorMode(HSB);

  in = new AudioIn(this);

  // Calculate the width of the rects depending on how many bands we have
  r_width = width/float(bands);

  fft = new FFT(this, bands);
  fft.input(in);
}      

void draw() {
  background(234);
  noStroke();

  fft.analyze();
  for (int i = 0; i < bands; i++) {
    fill(i*16, 200, 240);
    // Smooth the FFT data by smoothing factor
    sum[i] += (fft.spectrum[i] - sum[i]) * smooth_factor;

    // Draw the rects with a scale factor
    rect( i*r_width, height, r_width, -sum[i]*height*scale );
  }
}
