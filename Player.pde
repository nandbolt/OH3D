class Player
{
  PVector pos, vel;
  PVector horizonDir, vertDir;
  float delta = 0;
  
  Player()
  {
    pos = new PVector(0, 0, 0);
    vel = new PVector(0, 0, 0);
    horizonDir = new PVector(0, 1);
    vertDir = new PVector(1, 0);
  }
  
  void update()
  {
    // Movement
    vel.x = 0;
    vel.z = 0;
    if (input.getMoveForward() == 1)
    {
      vel.x += -horizonDir.x;
      vel.z += -horizonDir.y;
    }
    if (input.getMoveBackward() == 1)
    {
      vel.x += horizonDir.x;
      vel.z += horizonDir.y;
    }
    if (input.getMoveLeft() == 1)
    {
      horizonDir.rotate(PI * 0.5);
      vel.x += horizonDir.x;
      vel.z += horizonDir.y;
      horizonDir.rotate(-PI * 0.5);
    }
    if (input.getMoveRight() == 1)
    {
      horizonDir.rotate(-PI * 0.5);
      vel.x += horizonDir.x;
      vel.z += horizonDir.y;
      horizonDir.rotate(PI * 0.5);
    }
    vel.normalize();
    
    // Position
    pos.add(vel);
    
    // Camera movement
    cam.eye.x = pos.x + 20 * horizonDir.x;
    cam.eye.z = pos.z + 20 * horizonDir.y;
    cam.center.x = pos.x;
    cam.center.z = pos.z;
    
    // Camera rotation
    //cam.eye.x += horizonDir.x * 100;
    //cam.eye.z += horizonDir.y * 200;
  }
  
  void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y - 1, pos.z);
    box(1, 1, 1);
    popMatrix();
  }
}
