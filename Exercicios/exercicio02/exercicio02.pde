import processing.sound.*;
AudioIn in;

Amplitude amp;
float sum;
float sFactor= 2.5;
float rmsScaled;

int diametro;

PImage photo;

color[] allColors = new color[10000000];

int x, y;

void setup() {
  size(714, 1000);
  photo = loadImage("image.jpg");

  // Create the Input stream
  in = new AudioIn(this, 0);
  in.play();
  amp = new Amplitude(this);
  amp.input(in);

  noStroke();
  
  for (int i = 0; i < width; i++) {
     for (int j = 0; j < height; j++) {
     
       if (i % 10 == 0  && j % 10 == 0) {
         color c = photo.pixels[i+j*width];
         allColors[i+j*width] = c;
       }
     }
   } 
   
   print(allColors);
   diametro = 10;
}

void draw() {
  sum = (amp.analyze() )* sFactor;
  rmsScaled = sum * (height/20) * 1000; // * mouseY;

  diametro = int(rmsScaled);
  

  background(0);

  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {

      if (i % 20 == 0  && j % 20 == 0) {
        
        color c = photo.pixels[i+j*width];
        fill(c);
          
        /*if ( mouseX > i-10 && mouseX < i+10 && mouseY > j-10 && mouseY < j+10) {
          circle(i, j, diametro*5);   
          
          circle(i+20, j-20, diametro*3); 
          circle(i+20, j, diametro*3); 
          circle(i+20, j+20, diametro*3); 
          circle(i-20, j-20, diametro*3); 
          circle(i-20, j, diametro*3); 
          circle(i-20, j+20, diametro*3); 
          circle(i, j-20, diametro*3);
          circle(i, j+20, diametro*3); 
          
        } else {*/
          circle(i, j, diametro*1.5);    
        //}
        
      }
    }
  }  
  
}

/*void keyPressed() {
 if (keyCode == UP) {
   diametro = diametro+2;
 }
 
 if (keyCode == DOWN && diametro > 2) { 
   diametro = diametro-2;
 }
}*/
