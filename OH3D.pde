/*
OH3D v0.0.1 by Alexander Wilson (nandbolt)

Final project for CS 324E (Elements of Graphics)
*/

import java.awt.*;
import processing.sound.*;

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
  
  // Load assets
  loader = new AssetLoader();
  loader.sndBlast = new SoundFile(this, "shoot-blast.wav");
  loader.sndSpear = new SoundFile(this, "shoot-spear.wav");
  loader.sndPlayerHurt = new SoundFile(this, "player-hurt.wav");
  loader.sndEnemyHurt = new SoundFile(this, "enemy-hurt.wav");
  loader.sndJump = new SoundFile(this, "jump.wav");
  loader.sndBlip = new SoundFile(this, "blip.wav");
  
  // Init objects
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
