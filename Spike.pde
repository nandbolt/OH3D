class Spike
{
  // Dimensions
  PVector hPos;
  float w, h, d;
  
  Spike(int i, int j)
  {
    //w = 10;
    //h = 0.5;
    //d = 10;
    //hPos = new PVector(i * w + w * 0.5, j * d + d * 0.5);
    
    w = 4;
    h = 0.5;
    d = 4;
    hPos = new PVector(i * w, j * d);
  }
  
  void draw()
  {
    pushMatrix();
    //fill(255, 0, 0);
    noStroke();
    translate(hPos.x, 0, hPos.y);
    box(w, h, d);
    stroke(0);
    //fill(255);
    popMatrix();
  }
}
