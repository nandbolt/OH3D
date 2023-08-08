class Actor extends Object
{
  PShape body;
  PVector hDir, vDir;
  float w, h, d;
  
  Actor(float x, float y, float z, float w, float h, float d)
  {
    // Positioning
    super(x, y, z);
    hDir = new PVector(0, 1);
    vDir = new PVector(0.7, -0.7);
    
    // Dimensions
    this.w = w;
    this.h = h;
    this.d = d;
    
    // Model
    body = loadShape("hand.obj");
  }
}
