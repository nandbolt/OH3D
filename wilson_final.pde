import java.awt.*;

Input input;
Camera cam;
Player p;
World w;
Robot r;
Chaser c;

ArrayList<Projectile> projs = new ArrayList<Projectile>();

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

void mousePressed()
{
  p.mousePressed();
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
  c = new Chaser(0, 0, -500);
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
  for (int i = 0; i < projs.size(); i++) { projs.get(i).update(); }
  
  // DRAW
  background(0);
  cam.draw();
  w.draw();
  p.draw();
  c.draw();
  for (int i = 0; i < projs.size(); i++) { projs.get(i).draw(); }
  
  // DRAW GUI
  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();
  p.drawGui();
  hint(ENABLE_DEPTH_TEST);
}
