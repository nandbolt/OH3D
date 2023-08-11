class World
{
  // Ground
  PShape ground;
  int chunkSize;
  
  // Objects
  Camera cam;
  Player player;
  ArrayList<Projectile> projs = new ArrayList<Projectile>();
  ArrayList<Spike> spikes = new ArrayList<Spike>();
  
  // Enemies
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  EnemySpawner espawner;
  
  // High Scores
  JSONArray saveData;
  int highestStepsAlive;
  int highestEnemiesKilled;
  int highestMaxDistance;
  
  // Main menu
  boolean mainMenu;
  
  World()
  {
    chunkSize = 300;
    
    // Objects
    cam = new Camera();
    player = new Player();
    espawner = new EnemySpawner();
    
    // Ground
    textureMode(NORMAL);
    ground = createShape();
    ground.beginShape(QUADS);
    ground.texture(loader.groundTex);
    ground.vertex(-chunkSize * 0.5, 0, -chunkSize * 0.5, 0, 0);
    ground.vertex(chunkSize * 0.5, 0, -chunkSize * 0.5, 0, chunkSize * 0.1);
    ground.vertex(chunkSize * 0.5, 0, chunkSize * 0.5, chunkSize * 0.1, chunkSize * 0.1);
    ground.vertex(-chunkSize * 0.5, 0, chunkSize * 0.5, chunkSize * 0.1, 0);
    ground.vertex(-chunkSize * 0.5, 0, -chunkSize * 0.5, 0, 0);
    ground.endShape();
    
    // High Scores
    saveData = loadJSONArray("save-data.txt");
    highestStepsAlive = saveData.getJSONObject(0).getInt("value");
    highestEnemiesKilled = saveData.getJSONObject(1).getInt("value");
    highestMaxDistance = saveData.getJSONObject(2).getInt("value");
    
    // Main menu
    mainMenu = true;
  }
  
  void restart()
  {
    // Main menu
    mainMenu = false;
    
    // Empty array lists
    for (int i = enemies.size() - 1; i >= 0; i--) { enemies.remove(i); }
    for (int i = projs.size() - 1; i >= 0; i--) { projs.remove(i); }
    
    // Player
    player.restart();
    espawner.restart();
  }
  
  boolean touchingSpikes(float x, float z)
  {
    if (int(x) % chunkSize == 250 && int(z) % chunkSize == 250) { return true; }
    return false;
  }
  
  void update()
  { 
    // Objects
    psystem.update();
    player.update();
    espawner.update();
    cam.update();
    for (int i = 0; i < projs.size(); i++) { projs.get(i).update(); }
    for (int i = 0; i < enemies.size(); i++) { enemies.get(i).update(); }
  }
  
  void draw()
  {
    // Background
    background(0);
    cam.draw();
    
    // Particles
    psystem.draw();
    
    // Origin
    if (!mainMenu)
    {
      pushMatrix();
      fill(255);
      noStroke();
      box(2, 0.5, 2);
      stroke(0);
      popMatrix();
    }
    
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
    for (int i = 0; i < spikes.size(); i++) { spikes.get(i).draw(); }
    
    // DRAW GUI
    hint(DISABLE_DEPTH_TEST);
    perspective();
    camera();
    noLights();
    if (!mainMenu) { player.drawGui(); }
    else
    {
      // Main menu
      pushMatrix();
      fill(0, 255, 0);
      
      // Title
      translate(width / 2, 350);
      shearY(PI / 8);
      translate(-115, 0);
      textSize(96);
      textAlign(LEFT, TOP);
      text("OH3D", 0, 0);
      
      // Button prompt
      translate(0, 256);
      textSize(32);
      shearY(-PI / 4.2);
      translate(-175, -20);
      text("Press R to play", 0, 0);
      
      // High scores
      shearY(0.23);
      fill(255, 255, 0);
      textSize(24);
      translate(-420, -315);
      text("Longest Time Alive:   " + String.format("%.1f", world.highestStepsAlive / 60.0), 0, 0);
      translate(20, 35);
      text("Most Enemies Killed:   " + highestEnemiesKilled, 0, 0);
      translate(20, 35);
      text("Furthest Max Distance:   " + highestMaxDistance, 0, 0);
      fill(255);
      popMatrix();
    }
    hint(ENABLE_DEPTH_TEST);
  }
}
