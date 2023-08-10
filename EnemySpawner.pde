enum SpawnPattern
{
  NONE,
  RANDOM,
  SOLID_CIRCLE,
  SPIRAL,
}

class EnemySpawner
{
  int stepsBetweenEnemies, stepsBetweenWaves;
  int totalEnemies, enemiesSpawned;
  int timer;
  PVector spawnRelativePos;
  SpawnPattern currPattern, displayPattern;
  float angleInc;
  
  EnemySpawner()
  {
    // Enemies
    spawnRelativePos = new PVector(300, 0);
    stepsBetweenEnemies = 60;
    stepsBetweenWaves = 60;
    timer = stepsBetweenEnemies;
    currPattern = SpawnPattern.NONE;
    displayPattern = currPattern;
    totalEnemies = 2;
    enemiesSpawned = 0;
    angleInc = 0;
  }
  
  void restart()
  {
    currPattern = SpawnPattern.NONE;
    displayPattern = currPattern;
    stepsBetweenEnemies = 60;
    timer = stepsBetweenEnemies;
    totalEnemies = 2;
  }
  
  void spawnEnemy()
  {
    Enemy e = new Chaser(world.player.pos.x + spawnRelativePos.x, 0, world.player.pos.z + spawnRelativePos.y);
    world.enemies.add(e);
    enemiesSpawned++;
  }
  
  void exitPattern(int stepsTillNext)
  {
    stepsBetweenWaves = stepsTillNext;
    currPattern = SpawnPattern.NONE;
    timer = stepsBetweenWaves;
  }
  
  void update()
  {
    // Timers
    if (!world.player.dead)
    {
      switch (currPattern)
      {
        // Enemies spawn randomly around the player, one-by-one until all are spawned.
        case RANDOM:
          // Enemy
          if (timer <= 0)
          {
            spawnRelativePos.rotate(random(2 * PI));
            spawnEnemy();
            timer = stepsBetweenEnemies;
            if (enemiesSpawned >= totalEnemies) { exitPattern(180); }
          }
          else { timer--; }
          break;
        // Enemies spawn all at once in a circle, evenly distributed
        case SOLID_CIRCLE:
          for (int i = 0; i < totalEnemies; i++)
          {
            spawnEnemy();
            spawnRelativePos.rotate(angleInc);
          }
          exitPattern(360);
          break;
        // Enemies spawn randomly around the player, one-by-one until all are spawned.
        case SPIRAL:
          // Enemy
          if (timer <= 0)
          {
            spawnRelativePos.rotate(angleInc);
            spawnEnemy();
            timer = stepsBetweenEnemies;
            if (enemiesSpawned >= totalEnemies) { exitPattern(180); }
          }
          else { timer--; }
          break;
        default:
          // Wave
          if (timer <= 0)
          {
            int sp = int(random(3));
            totalEnemies++;
            switch (sp)
            {
              case 0:
                currPattern = SpawnPattern.RANDOM;
                displayPattern = currPattern;
                stepsBetweenEnemies = 20;
                break;
              case 1:
                currPattern = SpawnPattern.SOLID_CIRCLE;
                displayPattern = currPattern;
                angleInc = 2 * PI / (float) totalEnemies;
                break;
              case 2:
                currPattern = SpawnPattern.SPIRAL;
                displayPattern = currPattern;
                stepsBetweenEnemies = 10;
                angleInc = 2 * PI / (float) totalEnemies;
                break;
            }
            enemiesSpawned = 0;
          }
          else { timer--; }
      }
    }
  }
}
