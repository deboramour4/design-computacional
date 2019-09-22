class MandalaCreator {

  int slices;
  color lineColor = color(0, 0, 255);
  float lineWidth = 1;

  MandalaCreator (int numberOfSlices) {
    slices = numberOfSlices;
  }

  void createMandala() {

    // random number of elements

    // random color in mandala

    creator.lineColor = color(0, 0, 0);
    creator.drawLine(new Point(width/2, height/2), new Point(100.0, 100.0));
    creator.lineColor = color(255, 0, 0);
    creator.drawCircle(new Point(350, 120), 50.0);
    creator.lineColor = color(0, 255, 0);
    creator.drawCircle(new Point(440, 150), 50.0);
    creator.lineColor = color(0, 0, 255);
    creator.drawRect(new Point(60, 60), 10.0, 25.0);
    creator.lineColor = color(200, 200, 0);
    creator.drawSquare(new Point(200, 170), 20.0);
    creator.lineColor = color(0, 150, 150);
    creator.drawArc(new Point(150, 70), 60.0, 30.0, radians(0), radians(45), PIE);
  }

  void drawLine(Point start, Point end) {
    stroke(lineColor);
    strokeWeight(lineWidth);

    for (int i = 0; i < slices; i++) {
      float rotation = (2*PI) * float(i)/slices;

      Point newStart = start.rotatePoint(rotation);
      Point newEnd = end.rotatePoint(rotation);
      line(newStart.x, newStart.y, newEnd.x, newEnd.y);
    }
  }

  void drawCircle(Point start, float radius) {
    stroke(lineColor);
    strokeWeight(lineWidth);

    for (int i = 0; i < slices; i++) {
      float rotation = (2*PI) * float(i)/slices;

      Point newStart = start.rotatePoint(rotation);
      circle(newStart.x, newStart.y, radius);
    }
  }

  void drawRect(Point start, float rectWidth, float rectHeight) {
    stroke(lineColor);
    strokeWeight(lineWidth);

    for (int i = 0; i < slices; i++) {
      float rotation = (2*PI) * float(i)/slices;

      Point newStart = start.rotatePoint(rotation); 

      pushMatrix();
      translate(newStart.x, newStart.y);
      rotate((2*PI) * float(i)/slices);  
      rect(0, 0, rectWidth, rectHeight);
      popMatrix();
    }

    rotate(0);
  }

  void drawSquare(Point start, float rectSize) {
    stroke(lineColor);
    strokeWeight(lineWidth);

    for (int i = 0; i < slices; i++) {
      float rotation = (2*PI) * float(i)/slices;

      Point newStart = start.rotatePoint(rotation);

      pushMatrix();
      translate(newStart.x, newStart.y);
      rotate((2*PI) * float(i)/slices);  
      square(0, 0, rectSize);
      popMatrix();
    }
  }

  void drawArc(Point start, float arcWidth, float arcHeight, float angleStart, float angleStop, int mode) {
    stroke(lineColor);
    strokeWeight(lineWidth);

    for (int i = 0; i < slices; i++) {
      float rotation = (2*PI) * float(i)/slices;

      Point newStart = start.rotatePoint(rotation);

      pushMatrix();
      translate(newStart.x, newStart.y);
      rotate((2*PI) * float(i)/slices);
      arc(0, 0, arcWidth, arcHeight, angleStart, angleStop, mode);
      popMatrix();
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
