class Actor extends Object
{
  PShape body;
  PVector hDir;
  float w, h, d, moveSpeed;
  
  Actor(float x, float y, float z, float w, float h, float d)
  {
    // Positioning
    super(x, y, z);
    hDir = new PVector(0, 1);
    
    // Dimensions
    this.w = w;
    this.h = h;
    this.d = d;
    
    // Model
    body = loader.chaserBody;
    
    // Movement
    moveSpeed = 1;
  }
  
  void draw()
  {
    // Player BEGIN
    pushMatrix();
    
    // Body
    translate(pos.x, pos.y - 0.5, pos.z);
    rotateX(-PI * 0.5);
    rotateZ(-hDir.heading() - PI * 0.5);
    rotateY(-PI * 0.5);
    shape(body);
    
    // Player END
    popMatrix();
    
    if (debugMode)
    {
      // Debug BEGIN
      pushMatrix();
      
      // Collision box
      translate(pos.x, pos.y - h * 0.5, pos.z);
      noFill();
      stroke(255);
      box(w, h, d);
      
      // Look direction
      line(0, 0, 0, hDir.x * 3, 0, hDir.y * 3);
      
      // Debug END
      stroke(0);
      fill(255);
      popMatrix();
    }
  }
}
