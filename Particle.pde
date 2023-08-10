class Particle
{
  PVector pos, vel;
  float size, ltime, time, timeRatio;
  color col;
  
  Particle(float x, float y, float z, float lt, float s, color c)
  {
    pos = new PVector(x, y, z);
    vel = new PVector(0, 0, 0);
    ltime = lt;
    time = ltime;
    size = s;
    col = c;
  }
  
  void update()
  {
    if (time > 0)
    {
      // Move
      pos.add(vel);
      
      // Decrement timer
      time--;
      timeRatio = time / ltime;
    }
    else
    {
      // Remove from particles
      for (int i = 0; i < psystem.particles.size(); i++)
      {
        if (psystem.particles.get(i) == this) { psystem.particles.remove(i); }
      }
    }
  }
  
  void draw()
  {
    fill(col);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(lerp(0, size, timeRatio));
    popMatrix();
    fill(255);
  }
}
