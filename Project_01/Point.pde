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
