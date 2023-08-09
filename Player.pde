class Player extends Actor
{
  PVector goalHVel;
  float jumpStrength, moveSpeed, gravStrength;
  float camMinHDist, camMaxHeight;
  int stepsAlive;
  boolean dead;
  
  Player()
  {
    // Parent
    super(0, 0, 0, 1, 1, 1);
    dead = false;
    
    // Dimensions
    hDir.rotate(-PI/4);
    
    // Movement
    goalHVel = new PVector(0, 0);
    moveSpeed = 0.6;
    jumpStrength = 0.3;
    gravStrength = 0.01;
    
    // Camera
    camMinHDist = 20;
    camMaxHeight = 20;
    
    // Model
    body.setFill(color(255));
  }
  
  void restart()
  {
    dead = false;
    stepsAlive = 0;
    
    pos.set(0, 0, 0);
    hVel.set(0, 0);
    yVel = 0;
    hDir.set(0, 1);
    hDir.rotate(-PI/4);
    vDir.set(0.7, -0.7);
    goalHVel.set(0, 0);
  }
  
  void mouseMovedAndDragged()
  {
    if (!dead)
    { 
      // Rotate horizontally
      if (pmouseX == int(width * 0.5)) { hDir.rotate((mouseX - pmouseX) * 0.003); }
      
      // Rotate vertically
      if (pmouseY == int(height * 0.5))
      {
        // Clamp rotation
        float currAngle = vDir.heading();
        float goalDir = (mouseY - pmouseY) * 0.003;
        if ((goalDir > 0 && currAngle + goalDir < -0.2) || (goalDir < 0 && currAngle + goalDir > -1.5)) { vDir.rotate(goalDir); }
      }
    }
    
    // Move mouse back to center
    robot.mouseMove(int(width * 0.5), int(height * 0.5));
  }
  
  void mousePressed()
  {
    if (!dead) { world.projs.add(new Blast(pos.x, pos.y, pos.z, hDir.x, hDir.y)); }
  }
  
  boolean checkOnGround()
  {
    if (pos.y >= 0) { return true; }
    return false;
  }
  
  void aliveUpdate()
  {
    // Alive timer
    stepsAlive++;
    
    // Movement
    goalHVel.set(0, 0);
    if (input.getMoveForward() == 1) { goalHVel.add(hDir); } 
    if (input.getMoveBackward() == 1) { goalHVel.add(-hDir.x, -hDir.y); } 
    if (input.getMoveLeft() == 1)
    {
      hDir.rotate(-PI * 0.5);
      goalHVel.add(hDir);
      hDir.rotate(PI * 0.5);
    }
    if (input.getMoveRight() == 1)
    {
      hDir.rotate(PI * 0.5);
      goalHVel.add(hDir);
      hDir.rotate(-PI * 0.5);
    }
    goalHVel.mult(moveSpeed);
    hVel.lerp(goalHVel, 0.1);
    
    // Ground check
    if (checkOnGround())
    {
      // Jump check
      if (input.getActionJump() == 1)
      {
        // Jump
        yVel = -jumpStrength;
      }
    }
    // Gravity
    else
    {
      yVel += gravStrength;
      if (pos.y + yVel >= 0)
      {
        // Land
        yVel = 0;
        pos.y = 0;
      }
    }
    
    // Position
    pos.add(hVel.x, yVel, hVel.y);
    
    // Camera movement
    world.cam.eye.x = pos.x;
    world.cam.eye.z = pos.z;
    world.cam.eye.y = pos.y;
    world.cam.center.x = pos.x;
    world.cam.center.y = pos.y;
    world.cam.center.z = pos.z;
    
    // Camera rotation
    world.cam.eye.x -= hDir.x * camMinHDist;
    world.cam.eye.y -= vDir.x * camMaxHeight;
    world.cam.eye.z -= hDir.y * camMinHDist;
    
    // Collision
    for (int i = 0; i < world.enemies.size(); i++)
    {
      Enemy e = world.enemies.get(i);
      if (Math.colliding(pos, w, h, d, e.pos, e.w, e.h, e.d))
      {
        dead = true;
        break;
      }
    }
  }
  
  void update()
  {
    if (!dead) { aliveUpdate(); }
    else if (keyPressed && (key == 'r' || key == 'R')) { world.restart(); }
  }
  
  void draw()
  {
    if (!dead) { super.draw(); }
  }
  
  void drawGui()
  {
    float x, y;
    String time = String.format("%.1f", stepsAlive / 60.0);
    
    // Timer
    x = 64;
    y = 32;
    fill(0, 255, 0);
    shearY(PI / 16);
    textSize(32);
    textAlign(LEFT, TOP);
    text(time, x, y);
    
    // Dead
    if (dead)
    {
      y += 36 * 2;
      text("Press R to restart.", x, y);
    }
    
    if (debugMode)
    {
      y += 36 * 2;
      text("Pos: (" + int(pos.x) + ", " + int(pos.y) + ", " + int(pos.z) + ")", x, y);
      y += 36;
      text("HSpeed: " + hVel.mag(), x, y);
      y += 36;
      text("Framerate: " + int(frameRate), x, y);
      y += 36;
      text("Enemies: " + world.enemies.size(), x, y);
    }
    
    shearY(-PI / 16);
  }
}
