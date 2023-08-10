class ParticleSystem
{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  
  void emitTrailParticle(float x, float y, float z, color c)
  {
    particles.add(new ParticleTrail(x, y, z, c));
  }
  
  void update()
  {
    for (int i = 0; i < particles.size(); i++) { particles.get(i).update(); }
  }
  
  void draw()
  {
    noStroke();
    for (int i = 0; i < particles.size(); i++) { particles.get(i).draw(); }
    stroke(0);
  }
}
