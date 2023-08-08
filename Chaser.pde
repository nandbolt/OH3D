class Chaser extends Enemy
{
  float moveSpeed;
  
  Chaser(float x, float y, float z)
  {
    // Parent
    super(x, y, z, 2, 1, 2);
    
    // Movement
    moveSpeed = 1;
    hVel.set(0, moveSpeed);
  }
  
  void update()
  {
    // Rotate
    //hVel.rotate(0.02);
    PVector r = new PVector(p.pos.x - pos.x, p.pos.z - pos.z);
    r.setMag(moveSpeed);
    //hVel.rotate(constrain(PVector.angleBetween(hVel, r), -0.02, 0.02));
    hVel.lerp(r, 0.02);
    
    // Position
    pos.add(hVel.x, 0, hVel.y);
  }
  
  void draw()
  {
    // Model
    pushMatrix();
    translate(pos.x, pos.y - 0.5, pos.z);
    rotateX(-PI * 0.5);
    rotateZ(-hVel.heading() - PI * 0.5);
    rotateY(-PI * 0.5);
    shape(body);
    popMatrix();
    
    // Collision box
    pushMatrix();
    translate(pos.x, pos.y - h * 0.5, pos.z);
    noFill();
    stroke(255);
    box(w, h, d);
    stroke(0, 255, 0);
    line(0, 0, 0, hVel.x * 20, 0, hVel.y * 20);
    stroke(0);
    fill(255);
    popMatrix();
  }
}
