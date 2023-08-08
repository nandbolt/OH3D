class Input
{
  // Keys
  int[] keys = new int[9];
  
  void keyPressed()
  {
    if (key == 'a' || key == 'A') { keys[0] = 1; }
    else if (key == 'd' || key == 'D') { keys[1] = 1; }
    else if (key == 'w' || key == 'W') { keys[2] = 1; }
    else if (key == 's' || key == 'S') { keys[3] = 1; }
    else if (key == ' ') { keys[4] = 1; }
  }
  
  void keyReleased()
  {
    if (key == 'a' || key == 'A') { keys[0] = 0; }
    else if (key == 'd' || key == 'D') { keys[1] = 0; }
    else if (key == 'w' || key == 'W') { keys[2] = 0; }
    else if (key == 's' || key == 'S') { keys[3] = 0; }
    else if (key == ' ') { keys[4] = 0; }
  }
  
  // Move inputs
  int getMoveLeft() { return keys[0]; }
  int getMoveRight() { return keys[1]; }
  int getMoveForward() { return keys[2]; }
  int getMoveBackward() { return keys[3]; }
  int getActionJump() { return keys[4]; }
}
