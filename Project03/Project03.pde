import processing.sound.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

// OpenCV
OpenCV opencv;
Capture video;
int scl = 1;
PVector maxLoc; 
float realX; 
float realY;

// Max brightness
int diametro_area = 10;
int slices = 5;

// Draw mandala
//ArrayList<PVector> coordinates = new ArrayList();
ArrayList<ArrayList<PVector>> coordinates = new ArrayList<ArrayList<PVector>>();
color mandalaColor = color(255, 255, 255);
boolean isCurve = true;
boolean shouldDrawMandala = false;

//Timer
boolean isCounting = true;
int countdown = 7;

//Eraser
PShape eraserImg; 
PShape photoImg; 
PShape curveImg; 
PShape rectImg;

// Detect faces
ArrayList<Face> faceList;
Rectangle[] faces; // Detected faces rectangles(every frame)
int faceCount = 0; // Number of faces detected over all time. Used to set IDs.

// Game
int numberOfPlayers = 0;
boolean isChoosingColor = false;
int numberOfColorsChosen = 0;
color[] colorsChosen = {color(0, 0, 0, 1.0), color(0, 0, 0, 1.0), color(0, 0, 0, 1.0), color(0, 0, 0, 1.0)};

void setup() {
  size(320, 240);
  //size(640, 480);
  //size(320, 240);

  // Choose camera
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

  video = new Capture(this, width/scl, height/scl, cameras[4]); // 31
  opencv = new OpenCV(this, width/scl, height/scl);

  // Detect faces
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  faceList = new ArrayList<Face>();

  video.start();

  coordinates.add(new ArrayList<PVector>());
  coordinates.add(new ArrayList<PVector>());
  coordinates.add(new ArrayList<PVector>());
  coordinates.add(new ArrayList<PVector>());

  //Load images
  eraserImg = loadShape("trash.svg");
  photoImg = loadShape("photo.svg");
  curveImg = loadShape("curve-line.svg");
  rectImg = loadShape("rect-line.svg");
}

void draw() {
  translate(width/2, height/2);

  //scale(scl);
  opencv.loadImage(video);

  pushMatrix();
  scale(-1, 1);
  image(video, -width/2, -height/2);
  //fill(0, 0, 0, 100);
  //noStroke();
  //rect(-width/2, -height/2, width, height);
  popMatrix();

  // Counting faces Mode
  if (isCounting) {
    textCustom("Se posicione (ate 4 pessoas)", 0.0, -height/3.0);

    timer(0.0, -height/5.0);

    // Detect faces
    detectFaces();

    for (Face f : faceList) {
      strokeWeight(3);
      f.display();
    }

    numberOfPlayers = faces.length;
  }


  // Choosing colors Mode
  else if (isChoosingColor) {

    textCustom("Escolha uma cor", 0.0, -height/3.0);

    for (int c = 0; c < colorsChosen.length; c++) {
      fill(colorsChosen[c]);
      strokeWeight(3);
      stroke(0);

      if (c < faces.length) {
        float fX = (width-faces[c].x)-width/2 -faces[c].width/2;
        float fY = faces[c].y-height/2;
        ellipse(fX, fY, height/6, height/6);
      }
    }
  }


  // Drawing Mode
  else {
    for (int c = 0; c < numberOfColorsChosen; c++) {

      if (shouldDrawMandala) {
        mandalaMode(colorsChosen[c], c);
      } else {
        normalMode(colorsChosen[c], c);
      }

      eraser(-width/2.0, (height/2.0)-50);

      photo(width/2.0-50, (height/2.0)-50);

      //lineFormat(-width/2.0, -(height/2.0));

      drawColorPoints(colorsChosen[c], c);
    }
  }
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

void drawColorPoints(color c, int index) {
  float threshold = map(mouseX, 0, width, 0, 100);
  //threshold2=threshold;
  float avgX = 0;
  float avgY = 0;
  int count = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color 1
      color currentColor1 = video.pixels[loc];
      float r1 = red(currentColor1);
      float g1 = green(currentColor1);
      float b1 = blue(currentColor1);
      float r2 = red(c);
      float g2 = green(c);
      float b2 = blue(c);
      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < threshold*threshold) {
        avgX += x;
        avgY += y;
        count++;
      }
    }
  }

  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (count > 0) { 
    avgX = avgX / count;
    avgY = avgY / count;
    // Draw a circle at the tracked pixel
    fill(c);
    strokeWeight(3);
    stroke(0);

    float realAvgX = width-avgX - width/2;
    float realavgY = avgY - height/2;

    //realX = width-maxLoc.x - width/2;
    //realY = maxLoc.y - height/2;
    coordinates.get(index).add(new PVector(realAvgX, realavgY));

    ellipse(realAvgX, realavgY, 24, 24);
  }
}

void normalMode(color c, int index) {
  stroke(c);
  noFill();
  beginShape();

  for (int j = 0; j < coordinates.get(index).size(); j++) {
    if (isCurve) {
      curveVertex(coordinates.get(index).get(j).x, coordinates.get(index).get(j).y);
    } else {
      vertex(coordinates.get(index).get(j).x, coordinates.get(index).get(j).y);
    }
  }
  endShape();
}

void mandalaMode(color c, int index) {
  for (int i = 0; i < slices; i++) {
    pushMatrix();
    rotate((2*PI) * float(i)/slices); 

    stroke(c);
    fill(0, 0, 0, 50);
    beginShape();
    for (int j = 0; j < coordinates.get(index).size(); j++) {
      if (isCurve) {
        curveVertex(coordinates.get(index).get(j).x, coordinates.get(index).get(j).y);
      } else {
        vertex(coordinates.get(index).get(j).x, coordinates.get(index).get(j).y);
      }
    }
    endShape();

    popMatrix();
  }
}

void timer(Float x, Float y) {
  fill(0, 142, 193);
  textSize(60);
  textAlign(CENTER);

  int sec = int(frameCount/10%countdown) + 1;
  if (sec == countdown-1 && isCounting == true) {
    textCustom("Draw!", x, y);
  } else if (sec == countdown && isCounting == true) {
    isCounting = false;
    isChoosingColor = true;
    clearColorsChosen();
  } else if (isCounting) {
    int countdownv = countdown-2-sec;
    textCustom(""+countdownv, x, y);
  }
}

void textCustom(String text, Float x, Float y) {
  fill(0, 142, 193);
  textSize(width/15);
  textAlign(CENTER);
  text(text, x, y);
}

void eraser(Float x, Float y) {
  int size = 50;
  fill(200, 200, 20);
  noStroke();
  rect(x, y, size, size);
  shape(eraserImg, x+10, y+10, 30, 30);

  for (int i = 0; i < 4; i++) {
    int cSize = coordinates.get(i).size();

    if (cSize > 0) {
      float cX = coordinates.get(i).get(cSize-1).x;
      float cY = coordinates.get(i).get(cSize-1).y;

      if (cX >= x && cX <= x+size && cY >= y && cY <= y+size) {
        coordinates.get(i).clear();
      }
    }
  }
}

void photo(Float x, Float y) {
  int size = 50;
  fill(200, 200, 20);
  noStroke();
  rect(x, y, size, size);
  shape(photoImg, x+10, y+10, 30, 30);
  
  for (int i = 0; i < 4; i++) {
    int cSize = coordinates.get(i).size();

    if (cSize > 0) {
      float cX = coordinates.get(i).get(cSize-1).x;
      float cY = coordinates.get(i).get(cSize-1).y;

      if (cX >= x && cX <= x+size && cY >= y && cY <= y+size) {
        save("photo.jpg");
      }
    }
  }
}

//void lineFormat(Float x, Float y) {
//  int size = 50;
//  int dist = 10;

//  boolean[] formats = { true, false };
//  PShape[] imgs = { curveImg, rectImg };

//  for (int i = 0; i < formats.length; i++) {
//    fill(255);
//    noStroke();
//    rect(x, y + ((dist+size)*i), size, size);
//    shape(imgs[i], x+10, y+(i*(size+dist))+10, 30, 30);

//    if (realX >= x && realX <= x+size && realY >= y+(i*(size+dist)) && realY <= (y+(i*(size+dist)))+size) {
//      isCurve = formats[i];
//    }
//  }
//}

void detectFaces() {

  // Faces detected in this frame
  faces = opencv.detect();

  // Check if the detected faces already exist are new or some has disappeared. 

  // SCENARIO 1 FaceList is empty
  if (faceList.isEmpty()) {
    // Just make a Face object for every face Rectangle
    for (int i = 0; i < faces.length; i++) {
      println("+++ New face detected with ID: " + faceCount);
      faceList.add(new Face(faceCount, faces[i].x, faces[i].y, faces[i].width, faces[i].height));
      faceCount++;
    }

    // SCENARIO 2 We have fewer Face objects than face Rectangles found from OPENCV
  } else if (faceList.size() <= faces.length) {
    boolean[] used = new boolean[faces.length];
    // Match existing Face objects with a Rectangle
    for (Face f : faceList) {
      // Find faces[index] that is closest to face f
      // set used[index] to true so that it can't be used twice
      float record = 50000;
      int index = -1;
      for (int i = 0; i < faces.length; i++) {
        float d = dist(faces[i].x, faces[i].y, f.r.x, f.r.y);
        if (d < record && !used[i]) {
          record = d;
          index = i;
        }
      }
      // Update Face object location
      used[index] = true;
      f.update(faces[index]);
    }
    // Add any unused faces
    for (int i = 0; i < faces.length; i++) {
      if (!used[i]) {
        println("+++ New face detected with ID: " + faceCount);
        faceList.add(new Face(faceCount, faces[i].x, faces[i].y, faces[i].width, faces[i].height));
        faceCount++;
      }
    }

    // SCENARIO 3 We have more Face objects than face Rectangles found
  } else {
    // All Face objects start out as available
    for (Face f : faceList) {
      f.available = true;
    } 
    // Match Rectangle with a Face object
    for (int i = 0; i < faces.length; i++) {
      // Find face object closest to faces[i] Rectangle
      // set available to false
      float record = 50000;
      int index = -1;
      for (int j = 0; j < faceList.size(); j++) {
        Face f = faceList.get(j);
        float d = dist(faces[i].x, faces[i].y, f.r.x, f.r.y);
        if (d < record && f.available) {
          record = d;
          index = j;
        }
      }
      // Update Face object location
      Face f = faceList.get(index);
      f.available = false;
      f.update(faces[i]);
    } 
    // Start to kill any left over Face objects
    for (Face f : faceList) {
      if (f.available) {
        f.countDown();
        if (f.dead()) {
          f.delete = true;
        }
      }
    }
  }

  // Delete any that should be deleted
  for (int i = faceList.size()-1; i >= 0; i--) {
    Face f = faceList.get(i);
    if (f.delete) {
      faceList.remove(i);
    }
  }
}

void keyPressed() {

  if (key == CODED) {
    if (keyCode == UP) {
      if (shouldDrawMandala)
        slices++;
    } else if (keyCode == DOWN) {
      if (shouldDrawMandala && slices > 3) {
        slices--;
      }
    }
  } else {

    // Toggle Mandala Mode
    if (key == 'm' && !isChoosingColor && !isCounting) {
      shouldDrawMandala = shouldDrawMandala ? false : true;
    }


    // Rastrear rosto
    else if (key == 'r' && !isChoosingColor && !isCounting) {
      for (int i = 0; i < 4; i++) {
        coordinates.get(i).clear();
      }
      isCounting = true;
    }


    // Capturar cor
    else if (key == 'c' && !isCounting) {
      clearColorsChosen();
      isChoosingColor = true;
    }
  }
}

void mouseClicked() {
  if (isChoosingColor && numberOfColorsChosen < numberOfPlayers) {
    colorsChosen[numberOfColorsChosen] = get(mouseX, mouseY);

    numberOfColorsChosen++;
  } else if (numberOfColorsChosen == numberOfPlayers) {
    isChoosingColor = false;
  }
}

void clearColorsChosen() {
  for (int c = 0; c < colorsChosen.length; c++) {
    colorsChosen[c] = color(0, 0, 0, 1.0);
  }
  numberOfColorsChosen = 0;
}

void captureEvent(Capture c) {
  c.read();
}
