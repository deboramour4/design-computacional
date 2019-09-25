abstract class Shape {
  Point start;
  float lineWeight = 1;
  color lineColor = color(255);
  color transparentColor = color(255, 0, 0, 0.0);
  color fillColor;
  boolean isFilled = false;

  Shape (Point point) {  
    this.start = point;
  }
}

// Representation of a point(x,y)
class Point {
  float x;
  float y;

  Point (float newX, float newY) {  
    x = newX; 
    y = newY;
  }
}

// Represents the circle
class Circle extends Shape {
  float size;
  float originalSize;
  boolean isGrowing = true;
  
  Circle (Point point, float size) {  
    super(point);
    this.size = size;
    this.originalSize = size;
  }

  private void display(int slices) {
    stroke(lineColor);
    strokeWeight(lineWeight);

    fill((isFilled) ? lineColor : transparentColor);

    for (int i = 0; i < slices; i++) {     
      pushMatrix();
      rotate((2*PI) * float(i)/slices);  
      circle(start.x, start.y, size);
      popMatrix();
    }
  }

  private void pulse(float range) {
    //boolean isGrowing = true;
    
    //if (isGrowing) {
    //  this.size += 1;
    //} else {
    //  this.size -= 1;
    //}
    this.size = range;

    //if (this.size > 0 && this.size <= this.originalSize + range) {
    //  isGrowing = false;
    //} else {
    //  isGrowing = true;
    //}
  }
}

// Represents the square
class Square extends Shape {
  float size;

  Square (Point point, float size) {  
    super(point);
    this.size = size;
  }

  private void display(int slices) {
    stroke(lineColor);
    strokeWeight(lineWeight);
    fill((isFilled) ? lineColor : transparentColor);

    for (int i = 0; i < slices; i++) {
      pushMatrix();
      rotate((2*PI) * float(i)/slices);  
      square(start.x, start.y, size);
      popMatrix();
    }
  }
}

// Represents the line
class Line extends Shape {
  Point end;

  Line (Point point, Point point1) {  
    super(point);
    this.end = point1;
  }

  private void display(int slices) {
    stroke(lineColor);
    strokeWeight(lineWeight); 

    for (int i = 0; i < slices; i++) {
      pushMatrix();
      rotate((2*PI) * float(i)/slices);  
      line(start.x, start.y, end.x, end.y);
      popMatrix();
    }
  }
}

// Represents the rect
class Rect extends Shape {
  float width_r;
  float height_r;

  Rect (Point point, float width_r, float height_r) {  
    super(point);
    this.width_r = width_r; 
    this.height_r = height_r;
  }

  private void display(int slices) {
    stroke(lineColor);
    strokeWeight(lineWeight);
    fill((isFilled) ? lineColor : transparentColor);

    for (int i = 0; i < slices; i++) {
      pushMatrix();
      rotate((2*PI) * float(i)/slices);  
      rect(start.x, start.y, width_r, height_r);
      popMatrix();
    }

    rotate(0);
  }
}

// Represents the rect
class Arc extends Shape {
  float width_a;
  float height_a;
  float start_a;
  float stop_a;
  int mode;

  Arc (Point point, float width_a, float height_a, float start_a, float stop_a, int mode) {  
    super(point);
    this.width_a = width_a; 
    this.height_a = height_a;
    this.start_a = start_a; 
    this.stop_a = stop_a; 
    this.mode = mode;
  }

  private void display(int slices) {
    stroke(lineColor);
    strokeWeight(lineWeight);
    fill((isFilled) ? lineColor :transparentColor);

    for (int i = 0; i < slices; i++) {
      pushMatrix();
      rotate((2*PI) * float(i)/slices);
      arc(start.x, start.y, width_a, height_a, start_a, stop_a, mode);
      popMatrix();
    }
  }
}
