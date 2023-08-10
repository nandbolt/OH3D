class Chaser extends Enemy
{
  Chaser(float x, float y, float z)
  {
    // Parent
    super(x, y, z, 2, 1, 2);
    
    // Movement
    hVel.mult(moveSpeed);
  }
  
  void update()
  {
    // Reset BOID vectors
    sep.set(0, 0);
    align.set(0, 0);
    coh.set(0, 0);
    
    // Goal direction
    PVector r = new PVector(world.player.pos.x - pos.x, world.player.pos.z - pos.z);
    
    // BOID
    if (r.mag() < swarmDist)
    {
      float neighbors = 0;
      for (int i = 0; i < world.enemies.size(); i++)
      {
        Enemy e = world.enemies.get(i);
        if (e != this)
        {
          float dist = dist(pos.x, pos.y, pos.z, e.pos.x, e.pos.y, e.pos.z);
          if (dist < detectDist)
          {
            float inverseDist = detectDist - dist;
            neighbors++;
            sep.add((pos.x - e.pos.x) * inverseDist, (pos.z - e.pos.z) * inverseDist);
            align.add(e.hVel);
            coh.add(e.pos.x, e.pos.z);
          }
        }
      }
      if (neighbors > 0)
      {
        sep.mult(sepStrength);
        align.mult(1.0 / neighbors * alignStrength);
        coh.mult(1.0 / neighbors);
        coh.add(-pos.x, -pos.z);
        coh.mult(cohStrength);
        r.add(sep);
        r.add(align);
        r.add(coh);
      }
    }
    
    // Velocity
    r.setMag(moveSpeed);
    hVel.lerp(r, 0.02);
    hDir.rotate(Math.angleDifference(hDir.heading(), hVel.heading()));
    
    // Position
    pos.add(hVel.x, 0, hVel.y);
    
    // Emit trail particles
    psystem.emitTrailParticle(pos.x, pos.y, pos.z, color(255, 0, 0));
  }
}
