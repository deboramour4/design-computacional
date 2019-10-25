import processing.sound.*;
import gab.opencv.*;
import processing.video.*;

// OpenCV
OpenCV opencv;
Capture video;
int scl = 1;
PVector maxLoc; 
float realX; 
float realY;

// Max brightness
int diametro_area = 10;
int slices = 10;

// Draw mandala
ArrayList<PVector> coordinates = new ArrayList();
color mandalaColor = color(255, 255, 255);
boolean isCurve = true;

//Timer
boolean isCounting = true;
int countdown = 12;

//Eraser
PShape eraserImg; 
PShape photoImg; 
PShape curveImg; 
PShape rectImg;

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

  //Load images
  eraserImg = loadShape("trash.svg");
  photoImg = loadShape("photo.svg");
  curveImg = loadShape("curve-line.svg");
  rectImg = loadShape("rect-line.svg");
}

void draw() {

  translate(width/2, height/2);

  scale(scl);
  opencv.loadImage(video);

  pushMatrix();
  scale(-1, 1);
  image(video, -width/2, -height/2);
  fill(0, 0, 0, 150);
  noStroke();
  rect(-width/2, -height/2, width, height);
  popMatrix();

  maxLoc = opencv.max();
  realX = width-maxLoc.x - width/2;
  realY = maxLoc.y - height/2;

  if (!isCounting) {
    coordinates.add(new PVector(width-maxLoc.x - width/2, maxLoc.y - height/2));

    for (int i = 0; i < slices; i++) {
      pushMatrix();
      rotate((2*PI) * float(i)/slices); 

      stroke(mandalaColor);
      fill(0, 0, 0, 50);
      beginShape();
      for (int j = 0; j < coordinates.size(); j++) {
        if (isCurve) {
          curveVertex(coordinates.get(j).x, coordinates.get(j).y);
        } else {
          vertex(coordinates.get(j).x, coordinates.get(j).y);
        }
      }
      endShape();

      popMatrix();
    }
  }

  timer(0.0, 0.0);

  eraser(-width/2.0, (height/2.0)-50);

  photo(width/2.0-50, (height/2.0)-50);

  colors(width/2.0-50, -(height/2.0));

  lineFormat(-width/2.0, -(height/2.0));
  
  stroke(0, 255, 0);
  strokeWeight(3);
  noFill();
  ellipse(realX, realY, 10, 10);
}

void timer(Float x, Float y) {
  fill(0, 142, 193);
  textSize(100);
  textAlign(CENTER);

  int sec = int(frameCount/10%countdown) + 1;
  if (sec == countdown-1 && isCounting == true) {
    text("Draw!", x, y);
  } else if (sec == countdown && isCounting == true) {
    isCounting = false;
  } else if (isCounting) {
    text(10-sec, x, y);
  }
}

void eraser(Float x, Float y) {
  int size = 50;
  fill(200, 200, 20);
  noStroke();
  rect(x, y, size, size);
  shape(eraserImg, x+10, y+10, 30, 30);

  if (realX >= x && realX <= x+size && realY >= y && realY <= y+size) {
    coordinates.clear();
  }
}

void photo(Float x, Float y) {
  int size = 50;
  fill(200, 200, 20);
  noStroke();
  rect(x, y, size, size);
  shape(photoImg, x+10, y+10, 30, 30);

  if (realX >= x && realX <= x+size && realY >= y && realY <= y+size) {
    save("photo.jpg");
  }
}

void colors(Float x, Float y) {
  int size = 50;
  int dist = 10;

  color[] allColors = { color(255, 255, 255), color(255, 40, 40), color(40, 255, 40), color(40, 40, 255) };

  for (int i = 0; i < allColors.length; i++) {
    fill(allColors[i]);
    noStroke();
    rect(x, y + ((dist+size)*i), size, size);

    if (realX >= x && realX <= x+size && realY >= y+(i*(size+dist)) && realY <= (y+(i*(size+dist)))+size) {
      mandalaColor = allColors[i];
    }
  }
}

void lineFormat(Float x, Float y) {
  int size = 50;
  int dist = 10;

  boolean[] formats = { true, false };
  PShape[] imgs = { curveImg, rectImg };

  for (int i = 0; i < formats.length; i++) {
    fill(255);
    noStroke();
    rect(x, y + ((dist+size)*i), size, size);
    shape(imgs[i], x+10, y+(i*(size+dist))+10, 30, 30);

    if (realX >= x && realX <= x+size && realY >= y+(i*(size+dist)) && realY <= (y+(i*(size+dist)))+size) {
      isCurve = formats[i];
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}
