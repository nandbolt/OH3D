class Input
{
  // Keys
  int[] keys = new int[9];
  
  void keyPressed()
  {
    if (key == 'a') { keys[0] = 1; }
    else if (key == 'd') { keys[1] = 1; }
    else if (key == 'w') { keys[2] = 1; }
    else if (key == 's') { keys[3] = 1; }
  }
  
  void keyReleased()
  {
    if (key == 'a') { keys[0] = 0; }
    else if (key == 'd') { keys[1] = 0; }
    else if (key == 'w') { keys[2] = 0; }
    else if (key == 's') { keys[3] = 0; }
  }
  
  // Move inputs
  int getMoveLeft() { return keys[0]; }
  int getMoveRight() { return keys[1]; }
  int getMoveForward() { return keys[2]; }
  int getMoveBackward() { return keys[3]; }
}
