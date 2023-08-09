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
    hDir.rotate(Math.angleDifference(hDir.heading(), hVel.heading()));
    
    // Position
    pos.add(hVel.x, 0, hVel.y);
  }
}
