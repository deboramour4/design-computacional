class MandalaCreator {

  int slices;
  color lineColor = color(255);
  color transparentColor = color(255,0,0,0.0);
  float lineWidth = 1;
  boolean isFilled = false;

  MandalaCreator (int numberOfSlices) {
    
    // number based on the current ambient sound
    slices = numberOfSlices;
  }

  void createMandala(float scale) {
    
    // i = number based on the current ambient sound
    for(int i = 0; i < 10; i++) {
      // random number of elements
      int element = int(random(0, 3));
      
      float positionX = random(30, width/2);
      float positionY = random(30, height/2);
      
      switch (element) {
        case 0:
          drawCircle(new Point(positionX, positionY), 50.0);
          break;
        case 1:
          drawArc(new Point(positionX, positionY), 90.0, 60.0, radians(0), radians(85), OPEN);
          break;
        case 2:
          drawSquare(new Point(positionX, positionY), 20.0);
          break;
        case 3:
          drawRect(new Point(positionX, positionY), 25.0, 70.0);
          break;
        case 4:
          drawLine(new Point(positionX, positionY), new Point(random(30, width/2), random(30, height/2)));
          break;
      }
    }
    

    // random color in mandala
  
    //translate(width/2, height/2);
    //scale(scale);
       
  }

  private void drawLine(Point start, Point end) {
    stroke(lineColor);
    strokeWeight(lineWidth); 

    for (int i = 0; i < slices; i++) {
      float rotation = (2*PI) * float(i)/slices;

      Point newStart = start.rotatePoint(rotation);
      Point newEnd = end.rotatePoint(rotation);
      line(newStart.x, newStart.y, newEnd.x, newEnd.y);
    }
  }

  private void drawCircle(Point start, float radius) {
    stroke(lineColor);
    strokeWeight(lineWidth);
    fill((isFilled) ? lineColor : transparentColor);

    for (int i = 0; i < slices; i++) {
      float rotation = (2*PI) * float(i)/slices;

      Point newStart = start.rotatePoint(rotation);
      circle(newStart.x, newStart.y, radius);
    }
  }

  private void drawRect(Point start, float rectWidth, float rectHeight) {
    stroke(lineColor);
    strokeWeight(lineWidth);
    fill((isFilled) ? lineColor : transparentColor);

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

  private void drawSquare(Point start, float rectSize) {
    stroke(lineColor);
    strokeWeight(lineWidth);
    fill((isFilled) ? lineColor : transparentColor);

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

  private void drawArc(Point start, float arcWidth, float arcHeight, float angleStart, float angleStop, int mode) {
    stroke(lineColor);
    strokeWeight(lineWidth);
    fill((isFilled) ? lineColor :transparentColor);

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

  private void drawOutlines() {
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
  
  //void draw() {
  //  stroke(150);
  //  strokeWeight(1); 
  //  drawOutlines();
  //}
  
}
