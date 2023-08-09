static class Math
{
  // Credit to bennedich on stackoverflow:
  // https://stackoverflow.com/questions/1878907/how-can-i-find-the-smallest-difference-between-two-angles-around-a-point
  static float angleDifference(float a1, float a2)
  {
    int diff = int(degrees(a2 - a1));
    diff = (diff + 180) % 360 - 180;
    return radians(diff);
  }
  
  static boolean colliding(PVector pos1, float w1, float h1, float d1, PVector pos2, float w2, float h2, float d2)
  {
    // Adjust y positions since they aren't centered
    //pos1.y -=
    
    if ((abs(pos2.x - pos1.x) <= (w1 + w2) / 2.0) &&
        (abs(pos2.y - h2 * 0.5 - pos1.y + h1 * 0.5) <= (h1 + h2) / 2.0) &&
        (abs(pos2.z - pos1.z) <= (d1 + d2) / 2.0))
    {
      return true;
    }
    return false;
  }
}
