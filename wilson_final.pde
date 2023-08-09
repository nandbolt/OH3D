import java.awt.*;

boolean debugMode;

Robot robot;
Input input;
World world;

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
  world.player.mouseMovedAndDragged();
}

void mouseDragged()
{
  world.player.mouseMovedAndDragged();
}

void mousePressed()
{
  world.player.mousePressed();
}

void setup()
{
  // Init game
  fullScreen(P3D);
  noCursor();
  debugMode = false;
  
  // IRobot
  try
  {
    robot = new Robot();
  }
  catch (AWTException e)
  {
    e.printStackTrace();
  }
  
  // Init objects
  input = new Input();
  world = new World();
  
  // Move mouse to center
  robot.mouseMove(int(width * 0.5), int(height * 0.5));
}

void draw()
{
  // UPDATE
  world.update();
  
  // DRAW
  world.draw();
}
