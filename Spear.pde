class Spear extends Projectile
{
  Spear(float x, float y, float z, float xHDir, float yHDir)
  {
    // Positioning
    super(x, y, z, 2, 1 ,2, xHDir * 2, yHDir * 2);
    pierce = true;
    pc = color(0, 255, 0);
  }
  
  void draw()
  {
    // Model
    body.setFill(color(0, 255, 0));
    pushMatrix();
    translate(pos.x, pos.y - 0.5, pos.z);
    rotateX(-PI * 0.5);
    rotateZ(-hVel.heading() - PI * 0.5);
    rotateY(-PI * 0.5);
    shape(body);
    fill(0, 255, 0);
    translate(0, -4, 0);
    noStroke();
    box(0.5, 5, 1);
    stroke(0);
    fill(255);
    popMatrix();
    body.setFill(color(255));
    
    if (debugMode)
    {
      // Collision box
      pushMatrix();
      translate(pos.x, pos.y - h * 0.5, pos.z);
      noFill();
      stroke(255);
      box(w, h, d);
      stroke(0);
      fill(255);
      popMatrix();
    }
  }
}
