class Enemy extends Actor
{
  // BOID
  float detectDist, swarmDist;
  PVector sep, align, coh;
  float sepStrength, alignStrength, cohStrength;
  
  Enemy(float x, float y, float z, float w, float h, float d)
  {
    super(x, y, z, w, h, d);
    body.setFill(color(255, 0, 0));
    
    // Movement
    hVel.set(world.player.pos.x - x, world.player.pos.z - z);
    hVel.normalize();
    
    // BOID
    swarmDist = 128;
    detectDist = 16;
    sep = new PVector(0, 0);
    align = new PVector(0, 0);
    coh = new PVector(0, 0);
    sepStrength = 0.02;
    alignStrength = 3;
    cohStrength = 0.2;
  }
  
  void draw()
  {
    super.draw();
    
    if (debugMode)
    {
      // Debug BEGIN
      pushMatrix();
      
      // Detection sphere (BOIDS)
      translate(pos.x, pos.y - h * 0.5, pos.z);
      noFill();
      stroke(255);
      //sphere(detectDist);
      
      // BOID Vectors
      stroke(255, 255, 0);
      line(0, 0, 0, sep.x, 0, sep.y);
      stroke(0, 255, 255);
      line(0, 0, 0, align.x, 0, align.y);
      stroke(255, 0, 255);
      line(0, 0, 0, coh.x, 0, coh.y);
      
      // Debug END
      stroke(0);
      fill(255);
      popMatrix();
    }
  }
}
