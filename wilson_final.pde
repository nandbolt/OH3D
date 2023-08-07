import java.awt.*;

Input input;
Camera cam;
Player p;
Ground g;
Robot r;

void keyPressed()
{
  input.keyPressed();
}

void keyReleased()
{
  input.keyReleased();
}

void mouseMoved()
{
  if (pmouseX == int(width * 0.5)) { p.horizonDir.rotate((mouseX - pmouseX) * 0.003); }
  r.mouseMove(int(width * 0.5), int(height * 0.5));
}

void mouseDragged()
{
  if (pmouseX == int(width * 0.5)) { p.horizonDir.rotate((mouseX - pmouseX) * 0.003); }
  r.mouseMove(int(width * 0.5), int(height * 0.5));
}

void setup()
{
  // Init game
  fullScreen(P3D);
  noCursor();
  
  // Init objects
  input = new Input();
  cam = new Camera();
  p = new Player();
  g = new Ground();
  try {
  r = new Robot();
  }
  catch (AWTException e)
  {
    e.printStackTrace();
  }
}

void draw()
{
  // UPDATE
  p.update();
  
  // DRAW
  background(200);
  cam.draw();
  g.draw();
  p.draw();
}
