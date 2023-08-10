class Camera
{
  PVector eye, center, up, rEye;
  
  Camera()
  {
    center = new PVector(0, 0, 0);
    rEye = new PVector(0, 0, 20);
    eye = new PVector(center.x + rEye.x, center.y + rEye.y, center.z + rEye.z);
    up = new PVector(0, 1, 0);
  }
  
  void update()
  {
    eye.set(center.x + rEye.x, center.y + rEye.y, center.z + rEye.z);
  }
  
  void draw()
  {
    perspective(PI/3.0, 16.0 / 9.0, 1, 200);
    camera(eye.x, eye.y, eye.z, center.x, center.y, center.z, up.x, up.y, up.z);
  }
}
