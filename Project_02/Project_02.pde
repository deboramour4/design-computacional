import processing.sound.*;
import gab.opencv.*;
import processing.video.*;

OpenCV opencv;
Capture video;
int scl = 1;

int diametro_area = 10;
int slices = 10;

ArrayList<PVector> coordinates = new ArrayList();

void setup() {
  size(800, 600);
  
   String[] cameras = Capture.list();
    if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i, cameras[i]);
    }
  } 
  
  video = new Capture(this, width/scl, height/scl, cameras[3]); // 31
  opencv = new OpenCV(this, width/scl, height/scl);
  
  video.start();

}

void draw() {
  
  //translate(width/2, height/2);
  //rectMode(CENTER);
  
  scale(scl);
  opencv.loadImage(video);
  
  pushMatrix();
  scale(-1,1);
  image(video, -width, 0);
  popMatrix();
  
  PVector loc = opencv.max();
  stroke(255);
  strokeWeight(3);
  noFill();
  ellipse(width-loc.x, loc.y, 10, 10);
  coordinates.add(loc);
  
  for (int i = 0; i < slices; i++) {
    pushMatrix();
    rotate((2*PI) * float(i)/slices);  
      
    beginShape();
    for (int j = 0; j < coordinates.size(); j++) {
      curveVertex(width-coordinates.get(j).x,coordinates.get(j).y);
    }
    endShape();
    
    popMatrix();
   }
}

void captureEvent(Capture c) {
  c.read();
}
