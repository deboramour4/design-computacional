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
ArrayList<PVector> coordinates = new ArrayList();
color mandalaColor = color(255, 255, 255);
boolean isCurve = true;
boolean shouldDrawMandala = false;

//Timer
boolean isCounting = true;
int countdown = 22;

//Eraser
PShape eraserImg; 
PShape photoImg; 
PShape curveImg; 
PShape rectImg;

// Detect faces
ArrayList<Face> faceList;
Rectangle[] faces; // Detected faces rectangles(every frame)
int faceCount = 0; // Number of faces detected over all time. Used to set IDs.

void setup() {
  size(320, 240);

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

  video = new Capture(this, width/scl, height/scl, cameras[5]); // 31
  opencv = new OpenCV(this, width/scl, height/scl);

  // Detect faces
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  faceList = new ArrayList<Face>();

  video.start();

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

  if (isCounting) {
    // Detect faces
    detectFaces();

    for (Face f : faceList) {
      strokeWeight(2);
      f.display();
    }

    print(faceList.size()+" active faces");
  } else {
    maxLoc = opencv.max();
    realX = width-maxLoc.x - width/2;
    realY = maxLoc.y - height/2;
    coordinates.add(new PVector(realX, realY));

    if (shouldDrawMandala) {
      mandalaMode();
    } else {
      normalMode();
    }

    stroke(0, 255, 0);
    strokeWeight(3);
    noFill();
    ellipse(realX, realY, 10, 10);
  }

  timer(0.0, -height/2+75.0);

  eraser(-width/2.0, (height/2.0)-50);

  photo(width/2.0-50, (height/2.0)-50);

  colors(width/2.0-50, -(height/2.0));

  lineFormat(-width/2.0, -(height/2.0));
}

void normalMode() {
  stroke(mandalaColor);
  noFill();
  beginShape();
  for (int j = 0; j < coordinates.size(); j++) {
    if (isCurve) {
      curveVertex(coordinates.get(j).x, coordinates.get(j).y);
    } else {
      vertex(coordinates.get(j).x, coordinates.get(j).y);
    }
  }
  endShape();
}

void mandalaMode() {
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

void timer(Float x, Float y) {
  fill(0, 142, 193);
  textSize(60);
  textAlign(CENTER);

  int sec = int(frameCount/10%countdown) + 1;
  if (sec == countdown-1 && isCounting == true) {
    text("Draw!", x, y);
  } else if (sec == countdown && isCounting == true) {
    isCounting = false;
  } else if (isCounting) {
    text(countdown-2-sec, x, y);
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
  //if (keyPressed) {

  if (key == CODED) {
    if (keyCode == UP) {
      slices++;
    } else if (keyCode == DOWN) {
      if (slices > 3) {
        slices--;
      }
    }
  } else {
    if (key == 'm') {
      shouldDrawMandala = shouldDrawMandala ? false : true;
    }
  }
  //}
}

void captureEvent(Capture c) {
  c.read();
}
