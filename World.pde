class World
{
  PShape ground;
  PImage groundTex;
  float chunkSize;
  
  World()
  {
    chunkSize = 2000;
    
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
  }
  
  void update() {}
  void draw()
  {
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
  }
}
