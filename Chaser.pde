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
    if (!world.player.dead)
    {
      // Rotate
      PVector r = new PVector(world.player.pos.x - pos.x, world.player.pos.z - pos.z);
      r.setMag(moveSpeed);
      hVel.lerp(r, 0.02);
      hDir.rotate(Math.angleDifference(hDir.heading(), hVel.heading()));
      
      // Position
      pos.add(hVel.x, 0, hVel.y);
    }
  }
}
