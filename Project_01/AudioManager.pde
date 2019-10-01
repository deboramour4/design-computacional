class AudioManager {
  AudioIn in;
  Amplitude amp;
  FFT fft;
  
  float sum;
  float sFactor;

  AudioManager(float factor) {
    sFactor = factor;
  }
  
  int amplitude() {
    float sum = (amp.analyze() )* sFactor;
    //float rmsScaled = sum * (height/20) * mouseY;
    return int(sum);
  }
  
  void startListening(AudioIn in, Amplitude amp, FFT fft) {
    this.in = in;
    this.amp = amp;
    this.fft = fft;
    
    in.play();
    amp.input(in);
    fft.input(in);
  }
  
  
  float average(float list[]) { 
      float sum = 0; 
      for (int i = 0; i < list.length; i++) {
          sum += list[i]*10000; 
      }
      return sum / list.length; 
  }
}
