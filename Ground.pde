class Ground
{
  PVector pos;
  PShape ground;
  PImage tex;
  float w, h, d;
  
  Ground()
  {
    w = 500;
    h = 50;
    d = 500;
    pos = new PVector(0, h * 0.5, 0);
    tex = loadImage("grid.png");
    textureMode(NORMAL);
    //ground = createShape();
    ground = createShape();
    ground.beginShape(QUADS);
    ground.texture(tex);
    ground.vertex(-w * 0.5, -h * 0.5, -d * 0.5, 0, 0);
    ground.vertex(w * 0.5, -h * 0.5, -d * 0.5, 0, w * 0.1);
    ground.vertex(w * 0.5, -h * 0.5, d * 0.5, w * 0.1, w * 0.1);
    ground.vertex(-w * 0.5, -h * 0.5, d * 0.5, w * 0.1, 0);
    ground.vertex(-w * 0.5, -h * 0.5, -d * 0.5, 0, 0);
    //ground.vertex(0, 0, 0, 0);
    //ground.vertex(w, 0, 0, 0, 0);
    //ground.vertex(w, 0, d, 2);
    //ground.vertex(0, 0, d, 2);
    //ground.vertex(0, 0, 0, 2);
    ground.endShape();
  }
  
  void update() {}
  void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    textureWrap(REPEAT);
    shape(ground);
    popMatrix();
    
    //pushMatrix();
    ////translate(width/2, height/2);
    //textureWrap(REPEAT); 
    //beginShape();
    //texture(tex);
    //vertex(-w * 0.5, -100, 0, 0);
    //vertex(100, -100, 2, 0);
    //vertex(100, 100, 2, 2);
    //vertex(-100, 100, 0, 2);
    //endShape();
    //popMatrix();
  }
}
