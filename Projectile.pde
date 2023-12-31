class Projectile extends Object
{
  PShape body;
  float w, h, d;
  float gravStrength;
  float lifeTimer, stepsAlive;
  boolean dead, pierce;
  color pc;
  
  Projectile(float x, float y, float z, float w, float h, float d, float xHVel, float yHVel)
  {
    // Positioning
    super(x, y, z);
    
    // Dimensions
    this.w = w;
    this.h = h;
    this.d = d;
    
    // Movement
    hVel.set(xHVel, yHVel);
    gravStrength = 0.04;
    
    // Model
    body = loader.playerBlast;
    //body.setFill(color(255));
    
    // Life
    lifeTimer = 0;
    stepsAlive = 120;
    dead = false;
    pierce = false;
    pc = color(255);
  }
  
  boolean checkOnGround()
  {
    if (pos.y >= 0) { return true; }
    return false;
  }
  
  void update()
  {
    // Ground check
    if (!checkOnGround())
    {
      yVel += gravStrength;
      if (pos.y + yVel >= 0)
      {
        // Land
        yVel = 0;
        pos.y = 0;
      }
    }
    else
    {
      // Emit trail particles
      psystem.emitTrailParticle(pos.x, pos.y, pos.z, pc);
    }
    
    // Position
    pos.add(hVel.x, yVel, hVel.y);
    
    // Collision
    for (int i = 0; i < world.enemies.size(); i++)
    {
      Enemy e = world.enemies.get(i);
      if (Math.colliding(pos, w, h, d, e.pos, e.w, e.h, e.d))
      {
        // Kill enemy
        world.enemies.remove(i);
        world.player.enemiesKilled++;
        
        // Enemy hurt sound
        loader.sndEnemyHurt.play();
        
        if (!pierce)
        {
          // Destroy projectile
          dead = true;
          break;
        }
      }
    }
    
    // Lifetimer
    if (lifeTimer < stepsAlive) { lifeTimer++; }
    else { dead = true; }
    
    // Remove from projectiles if dead
    if (dead)
    {
      for (int i = 0; i < world.projs.size(); i++)
      {
        if (world.projs.get(i) == this)
        {
          world.projs.remove(i);
          break;
        }
      }
    }
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
