class Object
{
  PVector pos, hVel;
  float yVel;
  
  Object()
  {
    pos = new PVector(0, 0, 0);
    hVel = new PVector(0, 0);
    yVel = 0;
  }
  
  Object(float x, float y, float z)
  {
    this();
    pos.set(x, y, z);
  }
  
  void update(){}
  void draw(){}
}
