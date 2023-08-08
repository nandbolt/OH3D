class Enemy extends Actor
{
  Enemy(float x, float y, float z, float w, float h, float d)
  {
    super(x, y, z, w, h, d);
    body.setFill(color(255, 0, 0));
  }
}
