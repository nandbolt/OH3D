class World
{
  // Ground
  PShape ground;
  PImage groundTex;
  float chunkSize;
  
  // Objects
  Camera cam;
  Player player;
  ArrayList<Projectile> projs = new ArrayList<Projectile>();
  
  // Enemies
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  int stepsBetweenEnemies;
  int enemyTimer;
  PVector spawnRelativePos;
  
  World()
  {
    chunkSize = 2000;
    
    // Objects
    cam = new Camera();
    player = new Player();
    
    // Ground
    groundTex = loadImage("grid.png");
    textureMode(NORMAL);
    ground = createShape();
    ground.beginShape(QUADS);
    ground.texture(groundTex);
    ground.vertex(-chunkSize * 0.5, 0, -chunkSize * 0.5, 0, 0);
    ground.vertex(chunkSize * 0.5, 0, -chunkSize * 0.5, 0, chunkSize * 0.1);
    ground.vertex(chunkSize * 0.5, 0, chunkSize * 0.5, chunkSize * 0.1, chunkSize * 0.1);
    ground.vertex(-chunkSize * 0.5, 0, chunkSize * 0.5, chunkSize * 0.1, 0);
    ground.vertex(-chunkSize * 0.5, 0, -chunkSize * 0.5, 0, 0);
    ground.endShape();
    
    // Enemies
    spawnRelativePos = new PVector(400, 0);;
    stepsBetweenEnemies = 60;
    enemyTimer = stepsBetweenEnemies;
  }
  
  void restart()
  {
    // Empty array lists
    for (int i = enemies.size() - 1; i >= 0; i--) { enemies.remove(i); }
    for (int i = projs.size() - 1; i >= 0; i--) { projs.remove(i); }
    
    // Player
    player.restart();
  }
  
  void spawnEnemy(float x, float z)
  {
    enemies.add(new Chaser(x, 0, z));
  }
  
  void update()
  { 
    // Timers
    if (!player.dead)
    {
      // Enemy
      if (enemyTimer <= 0)
      {
        spawnRelativePos.rotate(random(2 * PI));
        spawnEnemy(player.pos.x + spawnRelativePos.x, player.pos.z + spawnRelativePos.y);
        enemyTimer = stepsBetweenEnemies;
      }
      else { enemyTimer--; }
    }
    
    // Objects
    player.update();
    for (int i = 0; i < projs.size(); i++) { projs.get(i).update(); }
    for (int i = 0; i < enemies.size(); i++) { enemies.get(i).update(); }
  }
  
  
  void draw()
  {
    // Background
    background(0);
    cam.draw();
    
    // Ground
    pushMatrix();
    textureWrap(REPEAT);
    translate(int(cam.center.x / chunkSize) * chunkSize - chunkSize, 0, int(cam.center.z / chunkSize) * chunkSize - chunkSize);
    for (int j = 0; j < 3; j++)
    {
      for (int i = 0; i < 3; i++)
      {
        shape(ground);
        translate(chunkSize, 0, 0);
      }
      translate(-chunkSize * 3, 0, chunkSize);
    }
    popMatrix();
    
    // Objects
    player.draw();
    for (int i = 0; i < projs.size(); i++) { projs.get(i).draw(); }
    for (int i = 0; i < enemies.size(); i++) { enemies.get(i).draw(); }
    
    // DRAW GUI
    hint(DISABLE_DEPTH_TEST);
    camera();
    noLights();
    player.drawGui();
    hint(ENABLE_DEPTH_TEST);
  }
}
