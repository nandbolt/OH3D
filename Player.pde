class Player
{
  PShape hand;
  PImage tex;
  PVector pos, hVel, hDir, vDir;
  float yVel, jumpStrength, moveSpeed;
  float w, h, d;
  float camMinDist;
  float gravStrength;
  
  Player()
  {
    // Dimensions
    w = 1;
    h = 1;
    d = 1;
    
    // Movement
    pos = new PVector(0, 0, 0);
    hVel = new PVector(0, 0);
    yVel = 0;
    moveSpeed = 0.6;
    jumpStrength = 0.3;
    
    // Camera
    hDir = new PVector(0, 1);
    vDir = new PVector(0.7, -0.7);
    camMinDist = 20;
    
    // World
    gravStrength = 0.01;
    
    // Model
    hand = loadShape("hand.obj");
    hand.setFill(color(255));
    //tex = loadImage("grid.png");
    //hand.setTexture(tex);
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
  
  boolean checkOnGround()
  {
    if (pos.y >= 0) { return true; }
    return false;
  }
  
  void update()
  {
    // Movement
    hVel.x = 0;
    hVel.y = 0;
    if (input.getMoveForward() == 1)
    {
      hVel.x -= hDir.x;
      hVel.y -= hDir.y;
    }
    if (input.getMoveBackward() == 1)
    {
      hVel.x += hDir.x;
      hVel.y += hDir.y;
    }
    if (input.getMoveLeft() == 1)
    {
      hDir.rotate(PI * 0.5);
      hVel.x += hDir.x;
      hVel.y += hDir.y;
      hDir.rotate(-PI * 0.5);
    }
    if (input.getMoveRight() == 1)
    {
      hDir.rotate(-PI * 0.5);
      hVel.x += hDir.x;
      hVel.y += hDir.y;
      hDir.rotate(PI * 0.5);
    }
    hVel.mult(moveSpeed);
    //hVel.normalize();
    
    // Ground check
    if (checkOnGround())
    {
      // Jump check
      if (input.getActionJump() == 1)
      {
        // Jump
        yVel = -jumpStrength;
        println(yVel);
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
    shape(hand);
    popMatrix();
    
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
  
  void drawGui()
  {
    fill(255);
    textSize(32);
    textAlign(LEFT, TOP);
    text("Pos: (" + int(pos.x) + ", " + int(pos.y) + ", " + int(pos.z) + ")", 0, 0);
  }
}
