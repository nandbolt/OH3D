class Player extends Actor
{
  PVector vDir, goalHVel, goalRotVel;
  float jumpStrength, gravStrength;
  float camDist;
  int stepsAlive, enemiesKilled, maxDistance;
  boolean dead;
  PShape proj;
  
  // Weapon
  int weaponTimer, fireRate, projCount, projSep;
  
  Player()
  {
    // Parent
    super(0, 0, 0, 2, 0.5, 2);
    dead = false;
    
    // Dimensions
    hDir.rotate(-PI/4);
    vDir = PVector.fromAngle(-PI / 3);
    
    // Movement
    goalHVel = new PVector(0, 0);
    goalRotVel = new PVector(0, 0);
    moveSpeed = 0.4;
    jumpStrength = 0.3;
    gravStrength = 0.01;
    
    // Camera
    camDist = 20;
    
    // Model
    body = loader.playerCore;
    proj = loader.playerBlast;
    
    // Weapon
    weaponTimer = 0;
    fireRate = 10;
    projCount = 1;
    projSep = 3;
    
    // Scores
    stepsAlive = 0;
    enemiesKilled = 0;
    maxDistance = 0;
  }
  
  void restart()
  {
    dead = false;
    
    pos.set(0, 0, 0);
    hVel.set(0, 0);
    yVel = 0;
    hDir.set(0, 1);
    hDir.rotate(-PI/4);
    vDir = PVector.fromAngle(-PI / 3);
    goalHVel.set(0, 0);
    
    // Scores
    stepsAlive = 0;
    enemiesKilled = 0;
    maxDistance = 0;
    
    // Weapon
    weaponTimer = 0;
    fireRate = 10;
    projCount = 1;
    projSep = 3;
  }
  
  void mouseMovedAndDragged()
  {
    if (!dead)
    { 
      // Rotate horizontally
      //if (pmouseX == int(width * 0.5)) { hDir.rotate((mouseX - pmouseX) * 0.003); }
      if (pmouseX == int(width * 0.5)) { goalRotVel.x += (mouseX - pmouseX) * input.mouseHSense; }
      
      // Rotate vertically
      if (pmouseY == int(height * 0.5))
      {
        // Clamp rotation
        float currAngle = vDir.heading();
        float goalDir = (mouseY - pmouseY) * input.mouseVSense;
        if ((goalDir > 0 && currAngle + goalDir < -0.2) || (goalDir < 0 && currAngle + goalDir > -1.5)) { goalRotVel.y = goalDir; }
      }
    }
    
    // Move mouse back to center
    robot.mouseMove(int(width * 0.5), int(height * 0.5));
  }
  
  void fire()
  {
    PVector r = PVector.fromAngle(hDir.heading() - PI / 2);
    PVector rInc = new PVector(-r.x, -r.y);
    rInc.mult(projSep);
    r.mult((projCount - 1) * projSep * 0.5);
    for (int i = 0; i < projCount; i++)
    {
      world.projs.add(new Blast(pos.x + hDir.x * 3 + r.x, pos.y, pos.z + hDir.y * 3 + r.y, hDir.x, hDir.y));
      r.add(rInc);
    }
    weaponTimer = fireRate;
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
    
    // Weapon
    if (input.getPrimaryFire() == 1 && weaponTimer <= 0) { fire(); }
    else { weaponTimer = constrain(weaponTimer - 1, 0, fireRate); }
    
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
    
    // Rotation
    float xRotVel = lerp(0, goalRotVel.x, 0.4);
    float yRotVel = lerp(0, goalRotVel.y, 0.4);
    hDir.rotate(xRotVel);
    vDir.rotate(yRotVel);
    goalRotVel.x -= xRotVel;
    goalRotVel.y -= yRotVel;
    
    // Position
    pos.add(hVel.x, yVel, hVel.y);
    
    // Displacement score
    float dist = pos.mag();
    if (dist > maxDistance) { maxDistance = int(dist); }
    
    // Camera movement
    world.cam.center.x = pos.x;
    world.cam.center.z = pos.z;
    world.cam.center.y = pos.y;
    
    // Camera rotation
    world.cam.rEye.x = -hDir.x * sin(vDir.heading() + PI);
    world.cam.rEye.y = -vDir.x;
    world.cam.rEye.z = -hDir.y * sin(vDir.heading() + PI);
    world.cam.rEye.setMag(camDist);
    
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
    if (!dead)
    {
      super.draw();
      
      // Projectiles BEGIN
      pushMatrix();
      
      // Body
      translate(pos.x + hDir.x * 3, pos.y - 0.5, pos.z + hDir.y * 3);
      rotateX(-PI * 0.5);
      rotateZ(-hDir.heading() - PI * 0.5);
      rotateY(-PI * 0.5);
      scale((fireRate - weaponTimer) / (float) fireRate);
      translate(0, 0, projSep * 0.5 * (projCount - 1));
      for (int i = 0; i < projCount; i++)
      {
        shape(proj);
        translate(0, 0, -projSep);
      }
      
      // Projectiles END
      popMatrix();
      
      if (debugMode)
      {
        // Debug BEGIN
        pushMatrix();
        
        // Swarm sphere (BOIDS)
        translate(pos.x, pos.y - h * 0.5, pos.z);
        noFill();
        stroke(255);
        //sphere(128);
        
        // Debug END
        stroke(0);
        fill(255);
        popMatrix();
      }
    }
  }
  
  void drawGui()
  {
    float x, y;
    String time = String.format("%.1f", stepsAlive / 60.0);
    
    // HUD
    x = 64;
    y = 32;
    fill(0, 255, 0);
    shearY(PI / 16);
    textSize(32);
    textAlign(LEFT, TOP);
    text("Time alive: " + time, x, y);
    y += 36;
    text("Enemies killed: " + enemiesKilled, x, y);
    y += 36;
    text("Max distance: " + maxDistance, x, y);
    
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
      y += 36;
      text("Spawn pattern: " + world.espawner.displayPattern, x, y);
      y += 36;
      text("Total enemies this wave: " + world.espawner.totalEnemies, x, y);
    }
    
    shearY(-PI / 16);
  }
}
