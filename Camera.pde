class Camera
{
  PVector eye, center, up;
  
  Camera()
  {
    eye = new PVector(0, -5, 10);
    center = new PVector(0, 0, 0);
    up = new PVector(0, 1, 0);
    perspective(PI/3.0, 16.0 / 9.0, 1, 940);
  }
  
  void draw()
  {
    camera(eye.x, eye.y, eye.z, center.x, center.y, center.z, up.x, up.y, up.z);
  }
}
