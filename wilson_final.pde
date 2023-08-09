import java.awt.*;

boolean debugMode;

Input input;
Camera cam;
Player p;
World w;
Robot r;

ArrayList<Projectile> projs = new ArrayList<Projectile>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

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
  debugMode = false;
  
  // Init objects
  input = new Input();
  cam = new Camera();
  p = new Player();
  w = new World();
  enemies.add(new Chaser(200, 0, 200));
  enemies.add(new Chaser(200, 0, 100));
  enemies.add(new Chaser(100, 0, 200));
  try
  {
    r = new Robot();
  }
  catch (AWTException e)
  {
    e.printStackTrace();
  }
  
  // Move mouse to center
  r.mouseMove(int(width * 0.5), int(height * 0.5));
}

void draw()
{
  // UPDATE
  p.update();
  for (int i = 0; i < projs.size(); i++) { projs.get(i).update(); }
  for (int i = 0; i < enemies.size(); i++) { enemies.get(i).update(); }
  
  // DRAW
  background(0);
  cam.draw();
  w.draw();
  p.draw();
  for (int i = 0; i < projs.size(); i++) { projs.get(i).draw(); }
  for (int i = 0; i < enemies.size(); i++) { enemies.get(i).draw(); }
  
  // DRAW GUI
  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();
  p.drawGui();
  hint(ENABLE_DEPTH_TEST);
}
