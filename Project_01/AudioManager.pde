class AudioManager {
  AudioIn in;
  Amplitude amp;
  
  float sum;
  float sFactor;
  float[] history = new float[500];

  AudioManager(float factor) {
    sFactor = factor;
  }
  
  void startListening(AudioIn in, Amplitude amp) {
    this.in = in;
    this.amp = amp;
    
    in.play();
    amp.input(in);
  }
}
