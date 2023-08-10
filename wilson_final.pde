/*
Checklist
- Combo level
- Shader background
- Death animation
- 3D particles
*/


import java.awt.*;

boolean debugMode;

Robot robot;
Input input;
AssetLoader loader;
ParticleSystem psystem;
World world;

void keyPressed() { input.keyPressed(); }
void keyReleased() { input.keyReleased(); }
void mouseMoved() { world.player.mouseMovedAndDragged(); }
void mouseDragged() { world.player.mouseMovedAndDragged(); }
void mousePressed() { input.mousePressed(); }
void mouseReleased() { input.mouseReleased(); }

void setup()
{
  // Init game
  fullScreen(P3D);
  noCursor();
  sphereDetail(6);
  //frameRate(2);
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
  loader = new AssetLoader();
  input = new Input();
  psystem = new ParticleSystem();
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
