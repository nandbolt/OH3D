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
    vertDir = new PVector(0.7, -0.7);
  }
  
  void mouseMovedAndDragged()
  {
    // Rotate horizontally
    if (pmouseX == int(width * 0.5)) { horizonDir.rotate((mouseX - pmouseX) * 0.003); }
    
    // Rotate vertically
    if (pmouseY == int(height * 0.5))
    {
      // Clamp rotation
      float currAngle = vertDir.heading();
      float goalDir = (mouseY - pmouseY) * 0.003;
      println(vertDir);
      if ((goalDir > 0 && currAngle + goalDir < -0.2) || (goalDir < 0 && currAngle + goalDir > -1.3)) { vertDir.rotate(goalDir); }
    }
    
    // Move mouse back to center
    r.mouseMove(int(width * 0.5), int(height * 0.5));
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
    cam.eye.x = pos.x;
    cam.eye.z = pos.z;
    cam.eye.y = pos.y;
    cam.center.x = pos.x;
    cam.center.z = pos.z;
    
    // Camera rotation
    cam.eye.x += horizonDir.x * 20;
    cam.eye.y -= vertDir.x * 20;
    cam.eye.z += horizonDir.y * 20;
  }
  
  void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y - 1, pos.z);
    box(1, 1, 1);
    popMatrix();
  }
}
