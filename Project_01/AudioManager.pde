class AudioManager {
  AudioIn in;
  Amplitude amp;
  FFT fft;
  
  float sum;
  float sFactor;
  float[] history = new float[500];

  AudioManager(float factor) {
    sFactor = factor;
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
