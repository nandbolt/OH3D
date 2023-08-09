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
}
