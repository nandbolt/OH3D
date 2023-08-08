class Player extends Actor
{
  PVector goalHVel;
  float jumpStrength, moveSpeed, gravStrength;
  float camMinDist;
  
  Player()
  {
    // Parent
    super(0, 0, 0, 1, 1, 1);
    
    // Movement
    goalHVel = new PVector(0, 0);
    moveSpeed = 0.6;
    jumpStrength = 0.3;
    gravStrength = 0.01;
    
    // Camera
    camMinDist = 20;
    
    // Model
    body.setFill(color(255));
  }
  
  void mouseMovedAndDragged()
  {
    // Rotate horizontally
    if (pmouseX == int(width * 0.5)) { hDir.rotate((mouseX - pmouseX) * 0.003); }
    
    // Rotate vertically
    if (pmouseY == int(height * 0.5))
    {
      // Clamp rotation
      float currAngle = vDir.heading();
      float goalDir = (mouseY - pmouseY) * 0.003;
      if ((goalDir > 0 && currAngle + goalDir < -0.2) || (goalDir < 0 && currAngle + goalDir > -1.3)) { vDir.rotate(goalDir); }
    }
    
    // Move mouse back to center
    r.mouseMove(int(width * 0.5), int(height * 0.5));
  }
  
  void mousePressed()
  {
    projs.add(new Blast(pos.x, pos.y, pos.z, -hDir.x, -hDir.y));
  }
  
  boolean checkOnGround()
  {
    if (pos.y >= 0) { return true; }
    return false;
  }
  
  void update()
  {
    // Movement
    goalHVel.set(0, 0);
    if (input.getMoveForward() == 1) { goalHVel.add(-hDir.x, -hDir.y); } 
    if (input.getMoveBackward() == 1) { goalHVel.add(hDir); } 
    if (input.getMoveLeft() == 1)
    {
      hDir.rotate(PI * 0.5);
      goalHVel.add(hDir);
      hDir.rotate(-PI * 0.5);
    }
    if (input.getMoveRight() == 1)
    {
      hDir.rotate(-PI * 0.5);
      goalHVel.add(hDir);
      hDir.rotate(PI * 0.5);
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
    cam.eye.x = pos.x;
    cam.eye.z = pos.z;
    cam.eye.y = pos.y;
    cam.center.x = pos.x;
    cam.center.y = pos.y;
    cam.center.z = pos.z;
    
    // Camera rotation
    cam.eye.x += hDir.x * camMinDist;
    cam.eye.y -= vDir.x * camMinDist;
    cam.eye.z += hDir.y * camMinDist;
  }
  
  void draw()
  {
    // Model
    pushMatrix();
    translate(pos.x, pos.y - 0.5, pos.z);
    rotateX(-PI * 0.5);
    rotateZ(-hDir.heading() + PI * 0.5);
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
    line(0, 0, 0, hDir.x * 10, 0, hDir.y * 10);
    stroke(0);
    fill(255);
    popMatrix();
  }
  
  void drawGui()
  {
    fill(255);
    textSize(32);
    textAlign(LEFT, TOP);
    text("Pos: (" + int(pos.x) + ", " + int(pos.y) + ", " + int(pos.z) + ")", 0, 0);
    text("HSpeed: " + hVel.mag(), 0, 36);
    text("Framerate: " + frameRate, 0, 36 * 2);
  }
}
