import processing.sound.*;

AudioIn in;
Amplitude amp;

float sum;
float sFactor = 50;
float[] history = new float[500];

// Mandala
MandalaCreator creator = new MandalaCreator(10);

void setup() {
  size(500, 500);

  // create the input stream
  //in = new AudioIn(this, 0);
  //in.play();
  //amp = new Amplitude(this);
  //amp.input(in);

  frameRate(5);
}

void draw() {
  // set background color
  background(255);
  stroke(0);
  strokeWeight(1);

  // draw elements
  creator.drawLine(new Point(width/2, height/2), new Point(100.0, 100.0));


  // draw mandala outlines
  creator.drawOutlines();
}

class MandalaCreator {
  
  int slices;
  
  color lineColor = color(0, 255, 0);
  float lineWidth = 1;
  
  MandalaCreator (int numberOfSlices) {
    slices = numberOfSlices;
  }

  void drawLine(Point start, Point end) {
    for (int i = 0; i < slices; i++) {
      float rotation = (2*PI) * float(i)/slices;

      Point newStart = start.rotatePoint(rotation);
      Point newEnd = end.rotatePoint(rotation);
      line(newStart.x, newStart.y, newEnd.x, newEnd.y);
    }
  }
  
  void drawCircle(Point start, float radius) {
    for (int i = 0; i < slices; i++) {
      float rotation = (2*PI) * float(i)/slices;

      Point newStart = start.rotatePoint(rotation);
      circle(newStart.x, newStart.y, radius);
    }
  }
  
  void drawRect(Point start, float rectWidth, float rectHeight) {
    for (int i = 0; i < slices; i++) {
      float rotation = (2*PI) * float(i)/slices;

      Point newStart = start.rotatePoint(rotation);
      rect(newStart.x, newStart.y, rectWidth, rectHeight);
    }
  }
  
  void drawSquare(Point start, float rectSize) {
    for (int i = 0; i < slices; i++) {
      float rotation = (2*PI) * float(i)/slices;

      Point newStart = start.rotatePoint(rotation);
      square(newStart.x, newStart.y, rectSize);
    }
  }
  
  void drawArc(Point start, float arcWidth, float arcHeight, float angleStart, float angleStop, int mode) {
    for (int i = 0; i < slices; i++) {
      float rotation = (2*PI) * float(i)/slices;

      Point newStart = start.rotatePoint(rotation);
      arc(newStart.x, newStart.y, arcWidth, arcHeight, angleStart, angleStop, mode);
    }
  }

  void drawOutlines() {
    float radius = width*3;
    float linesWidth = 0.5;
    color linesColor = color(200, 200, 200);

    stroke(linesColor);
    strokeWeight(linesWidth);

    for (int i = 0; i < slices; i++) {
      // calculate new x and y
      float angle = (2*PI) * float(i)/slices;
      Point newPoint = new Point((width/2) + radius * cos(angle), (height/2) + radius * sin(angle));

      // draw the line
      line(width/2, height/2, newPoint.x, newPoint.y);
    }
  }
}

class Point {
  float x;
  float y;

  Point (float newX, float newY) {  
    x = newX; 
    y = newY;
  }

  Point rotatePoint(float rotation) {
    Point point = this;

    float radius = sqrt(pow(point.x - (width/2), 2) + pow(point.y - (height/2), 2));

    float x1 = (width/2) + radius * cos(0);
    float y1 = (height/2) + radius * sin(0);

    float a = point.x - x1;
    float b = point.y - y1;

    float distBetweenPosAndP1 = sqrt( pow(a, 2) + pow(b, 2));
    float angleBetweenPosAndP1 = solveAngle(radius, radius, distBetweenPosAndP1);

    float testX = round((width/2) + radius) * cos(-angleBetweenPosAndP1);
    float testY = round((height/2) + radius) * sin(-angleBetweenPosAndP1);

    int angleDirection = 0;
    if (point.y >= height/2) {
      angleDirection = (testX == point.x && testY == point.y) ? -1 : 1;
    } else {
      angleDirection = (testX == point.x && testY == point.y) ? 1 : -1;
    }

    float angle = rotation + (angleBetweenPosAndP1 * angleDirection);

    Point newPoint = new Point((width/2)+radius*(cos(angle)), (height/2)+radius*(sin(angle)));

    return(newPoint);
  }
  
  private float solveAngle(float a, float b, float c) {
    float temp = (a * a + b * b - c * c) / (2 * a * b);
    if ( and(temp >= -1, 0.9999999 >= temp) ) {
      return acos(temp);
    } else if (1 >= temp) {
      return sqrt((c * c - (a - b) * (a - b)) / (a * b));
    } else {
      return 0.0;
    }
  }

  private boolean and(Boolean x, Boolean y) {
    return x ? y : false;
  }
}
