class Blast extends Projectile
{
  Blast(float x, float y, float z, float xHDir, float yHDir)
  {
    // Positioning
    super(x, y, z, 2, 1 ,2, xHDir * 2, yHDir * 2);
  }
}
