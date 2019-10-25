class MandalaCreator {

  int slices;
  float lineWeight = 2;
  color lineColor = color(255);
  color transparentColor = color(255, 0.0, 0.0, 0.0);
  color fillColor;

  // Store elements in each area
  ArrayList<Shape> area1 = new ArrayList();
  ArrayList<Shape> area2 = new ArrayList();
  ArrayList<Shape> area3 = new ArrayList();

  MandalaCreator (int numberOfSlices) {

    // initial number
    slices = numberOfSlices;

    createAreas();
  }

  void createMandala(int amplitude, float scale) {

    // Every 5 seconds create new random areas
    if (frameCount % 300 == 0) {
      createAreas();
    }
    
    // Every 10 seconds updates de number of slices
    if (frameCount % 600 == 0) {
      this.slices = amplitude < 10 ? 10 : amplitude;
    }
    
    // Draw mandala slices outlines 
    drawOutlines();
    
    // Draw specifics areas depending on the current amplitude
    if (amplitude < 10) {
      drawArea(area1, amplitude);
    } else if (amplitude < 25) {
      drawArea(area1, amplitude); 
      drawArea(area2, amplitude);
    } else {
      drawArea(area1, amplitude); 
      drawArea(area2, amplitude); 
      drawArea(area3, amplitude);
    }
   
  }

  void createAreas() {

    // Erase the areas created before
    area1.clear();
    area2.clear();
    area3.clear();

    // Three areas in total
    for (int i = 0; i < 3; i++) {
      switch (i) {
      case 0:
        //determinated positions
        area1.add( new Circle(new Point(int(random(0, 50)), int(random(0, 50))), int(random(5, 40))) );
        area1.add( new Circle(new Point(int(random(10, 100)), int(random(10, 100))), int(random(5, 30))) );
        area1.add( new Square(new Point(int(random(10, 100)), int(random(10, 100))), int(random(5, 30))) );
        break;
      case 1:
        //determinated positions
        area2.add( new Circle(new Point(random(130, 250), random(130, 250)), random(10, 75)) );
        area2.add( new Square(new Point(random(130, 250), random(130, 250)), random(10, 75)) );
        area2.add( new Line(new Point(random(0, 175), random(0, 175)), new Point(random(100, 250), random(100, 250))) ); 
        
        //float random1 = random(130, 250); float random2 = random(130, 250); float random3 = random(50, 150);
        //float random4 = random(50, 150); float random5 = random(85, 270);
        
        area2.add( new Arc(new Point(random(130, 250), random(130, 250)), random(50, 150), random(50, 150), radians(0), radians(random(85, 270)), OPEN) );
        area2.add( new Arc(new Point(random(10, 250), random(10, 250)), random(80, 150), random(80, 150), radians(0), radians(random(85, 270)), OPEN) );
        break;
      case 2:
        //determinated positions
        area3.add( new Circle(new Point(random(275, 375), random(275, 375)), random(25, 100)) );
        area3.add( new Circle(new Point(random(275, 375), random(275, 375)), random(25, 100)) );
        area3.add( new Square(new Point(random(275, 375), random(275, 375)), random(25, 100)) );
        area3.add( new Arc(new Point(random(275, 375), random(275, 375)), random(80, 200), random(80, 200), radians(0), radians(random(85, 270)), OPEN) );
        area3.add( new Arc(new Point(random(275, 375), random(275, 375)), random(100, 250), random(100, 250), radians(0), radians(random(45, 180)), OPEN) );
        break;
      }
    }
  }

  void drawArea(ArrayList<Shape> array, float amplitude) {
        
    lineColor = color(int(frameCount % 360), 190, 255);
    stroke(lineColor);
    strokeWeight(lineWeight);
    fill(transparentColor);
    
    for (int i = 0; i < array.size(); i++) {

      if (array.get(i) instanceof Line) { 
        Line l = (Line) array.get(i);
        l.display(slices);
        l.grow();
      } else if (array.get(i) instanceof Circle) {
        Circle c = (Circle) array.get(i);
        c.display(slices);
        c.pulse(amplitude * 2);
      } else if (array.get(i) instanceof Rect) {
        Rect r = (Rect) array.get(i);
        r.display(slices);
      } else if (array.get(i) instanceof Square) {
        Square s = (Square) array.get(i);
        s.display(slices);
        s.pulse(amplitude * 2);
      } else if (array.get(i) instanceof Arc) {
        Arc a = (Arc) array.get(i);
        a.display(slices);
        a.grow();
      }
    }
  }

  private void drawOutlines() {
    stroke(50);
    strokeWeight(1);
    fill(transparentColor);
    
    Line line = new Line(new Point(0.0, 0.0), new Point(1500, 1500));
    line.display(slices);
  }
}
