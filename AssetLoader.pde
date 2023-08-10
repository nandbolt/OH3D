class AssetLoader
{
  // Ground
  PImage groundTex;
  
  // Player
  PShape playerCore, playerBlast;
  PImage playerCoreTex;
  
  // Chaser
  PShape chaserBody;
  PImage chaserTex;
  
  AssetLoader()
  {
    // World
    groundTex = loadImage("grid.png");
    
    // Player
    playerCoreTex = loadImage("cross-white.png");
    playerCore = loadShape("hand.obj");
    playerCore.setTexture(playerCoreTex);
    playerBlast = loadShape("hand.obj");
    playerBlast.setFill(color(255));
    
    // Chaser
    chaserTex = loadImage("cross-red.png");
    chaserBody = loadShape("hand.obj");
    //chaserBody.setTexture(chaserTex);
    chaserBody.setFill(color(255, 0, 0));
  }
}
