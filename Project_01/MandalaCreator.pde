class MandalaCreator {

  int slices;

  // Store elements in each area
  ArrayList<Shape> area1 = new ArrayList();
  ArrayList<Shape> area2 = new ArrayList();
  ArrayList<Shape> area3 = new ArrayList();

  MandalaCreator (int numberOfSlices) {

    // number based on the current ambient sound
    slices = numberOfSlices;
  
    createAreas();
    
  }

  void createMandala(int amplitude, float scale) {

    //this.slices = amplitude < 3 ? int(random(1, 5)) : amplitude;

    //amplitude = amplitude < 3 ? int(random(1, 5)) : amplitude;
    drawOutlines();
    
    drawArea(area1); 

    Circle c = (Circle) area1.get(0);
    c.pulse(amplitude * 10);

    // i = number based on the current ambient sound
    //for(int i = 0; i < amplitude; i++) {
    //  // random number of elements
    //  int element = int(random(0, 3));

    //  float positionX = random(30, width/2);
    //  float positionY = random(30, height/2);

    // random color in mandala

    //translate(width/2, height/2);
    //scale(scale);
  }

  void createAreas() {

    // three areas in total
    for (int i = 0; i < 3; i++) {
      switch (i) {
      case 0:
        //determinated positions
        Point position = new Point( int(random(10, 100)), int(random(10, 100)) );
        int size = int(random(10, 100));
        
        //area1.add( new Line(new Point(40, 20), new Point(150, 150)) );
        //area1.add( new Square(position, size));
        //area1.add( new Square(new Point(100, 100), 100));
        //area1.add( new Square(new Point(10, 10), 10));
        //area1.add( new Rect(new Point(180, 100), 100, 20) );
        area1.add( new Circle(position, size) );
        //area1.add( new Arc(new Point(0, 0), 150.0, 50.0, radians(0), radians(85), OPEN) );
        break;
      case 1:

        break;
      case 3:

        break;
      }
    }
  }

  void drawArea(ArrayList<Shape> array) {
    for (int i = 0; i < array.size(); i++) {

      if (array.get(i) instanceof Line) { 
        Line l = (Line) array.get(i);
        l.display(slices);
      } else if (array.get(i) instanceof Circle) {
        Circle c = (Circle) array.get(i);
        c.display(slices);
      } else if (array.get(i) instanceof Rect) {
        Rect r = (Rect) array.get(i);
        r.display(slices);
      } else if (array.get(i) instanceof Square) {
        Square s = (Square) array.get(i);
        s.display(slices);
      } else if (array.get(i) instanceof Arc) {
        Arc a = (Arc) array.get(i);
        a.display(slices);
      }
    }
  }

  private void drawOutlines() {
    Line line = new Line(new Point(0.0, 0.0), new Point(1500, 1500));
    line.lineWeight = 0.5;
    line.lineColor = color(50);
    line.display(slices);
  }
}
