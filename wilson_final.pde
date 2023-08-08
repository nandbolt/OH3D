import java.awt.*;

Input input;
Camera cam;
Player p;
World w;
Robot r;
Chaser c;

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
  p.mouseMovedAndDragged();
}

void mouseDragged()
{
  p.mouseMovedAndDragged();
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
  w = new World();
  c = new Chaser(0, 0, -20);
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
  c.update();
  
  // DRAW
  background(0);
  cam.draw();
  w.draw();
  p.draw();
  c.draw();
  
  // DRAW GUI
  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();
  p.drawGui();
  hint(ENABLE_DEPTH_TEST);
}
