PImage bgImg;
PImage soilImg;
PImage soldierImg;
PImage cabbageImg;
PImage groundhogImg;
PImage lifeImg;
PImage titleImg;
PImage gameoverImg;
PImage startHoveredImg;
PImage startNormalImg;
PImage restartHoveredImg;
PImage restartNormalImg;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState = GAME_START;

final int STOP = 0;
final int DOWNWARD = 1;
final int LEFTWARD = 2;
final int RIGHTWARD = 3;
int movement = STOP;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

float lifeAmount = 2;
int cabbageX;
int cabbageY;
int lifeX = 10;
float soldierX;
float soldierY;
float groundhogX;
float groundhogY;
float groundhogSpeed = 5;
float groundhogWidth = 80;
float groundhogHeight = 80;

void setup() {
  
  size(640, 480);
  
  bgImg = loadImage("img/bg.jpg");
  soilImg = loadImage("img/soil.png");
  soldierImg = loadImage("img/soldier.png");
  cabbageImg = loadImage("img/cabbage.png");
  
  groundhogImg = loadImage("img/groundhogIdle.png");
  
  lifeImg = loadImage("img/life.png");
  titleImg = loadImage("img/title.jpg");
  gameoverImg = loadImage("img/gameover.jpg");
  
  startHoveredImg = loadImage("img/startHovered.png");
  startNormalImg = loadImage("img/startNormal.png");
  restartHoveredImg = loadImage("img/restartHovered.png");
  restartNormalImg = loadImage("img/restartNormal.png");
  
  soldierX = 0;
  soldierY = floor(random(2,6))*80;
  cabbageX = floor(random(0,8))*80;
  cabbageY = floor(random(2,6))*80;
  groundhogX = 320;
  groundhogY = 80;
  lifeX = 10;
  
}

void draw() {
  
  switch(gameState){
    case GAME_START:
      image(titleImg,0,0);
      image(startNormalImg,248,360);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHoveredImg,248,360);
        if(mousePressed)gameState = GAME_RUN;
      }
    break;
    
    case GAME_RUN:
      image(bgImg,0,0);
      image(soilImg,0,160);
      image(cabbageImg,cabbageX,cabbageY);
      
      //grass
      noStroke();
      colorMode(RGB);
      fill(124,204,25);//green
      rect(0,145,640,15);
      
      //sun
      stroke(255,255,0);//yellow
      strokeWeight(5);
      fill(253,184,19);//orange
      ellipse(590,50,120,120);
      
      //soldier
      image(soldierImg,soldierX-80,soldierY);
      soldierX += 3;
      soldierX %= 720;
      
      //lives
      image (lifeImg, lifeX-70, 10);    
      image (lifeImg, lifeX, 10);
      image (lifeImg, lifeX+70, 10);
      
      //cabbage
      if(cabbageX == groundhogX && cabbageY == groundhogY){
        cabbageY = -cabbageY;
        lifeX = lifeX + 70;
      }
      
      //groundhog
      image(groundhogImg,groundhogX,groundhogY);
      
      switch(movement){
        case STOP:
          groundhogImg = loadImage("img/groundhogIdle.png");
          groundhogY += 0;
        break;
        
        case DOWNWARD:
          groundhogY += groundhogSpeed;
          groundhogImg = loadImage("img/groundhogDown.png");
          if(groundhogY % 80 == 0){
            movement = STOP;
          }
        break;
        
        case LEFTWARD:
          groundhogX -= groundhogSpeed;
          groundhogImg = loadImage("img/groundhogLeft.png");
          if(groundhogX % 80 == 0){
            movement = STOP;
          }
        break;
        
        case RIGHTWARD:
          groundhogX += groundhogSpeed;
          groundhogImg = loadImage("img/groundhogRight.png");
          if(groundhogX % 80 == 0){
            movement = STOP;
          }
        break;
        }
      
      //groundhog and soldier
      if(groundhogX < soldierX -80 +80 && groundhogX +80 > soldierX -80
      && groundhogY < soldierY +80 && groundhogY +80 > soldierY){
        movement = STOP;
        groundhogX = 320;
        groundhogY = 80;
        lifeX = lifeX - 70;
      }
      
      if(lifeX == -130){
        gameState = GAME_LOSE;
      }
      
    break;
    
    
    case GAME_LOSE:
      
      image(gameoverImg,0,0);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHoveredImg,248,360);
        if(mousePressed){
          gameState = GAME_RUN;
          soldierX = 0;
          soldierY = floor(random(2,6))*80;
          cabbageX = floor(random(0,8))*80;
          cabbageY = floor(random(2,6))*80;
          groundhogX = 320;
          groundhogY = 80;
          lifeX = 10;
        }
      }else{
        image(restartNormalImg,248,360);
      }
      
  } 
    
}


void keyPressed(){
  if(groundhogX % 80 == 0 && groundhogY % 80 == 0){
    switch(keyCode){
    case DOWN:
      if(groundhogY + groundhogHeight < height){
        movement = DOWNWARD;
      }
    break;
    case RIGHT:
      if(groundhogX + groundhogWidth < width){
        movement = RIGHTWARD;
      }
    break;
    case LEFT:
      if(groundhogX > 0){
        movement = LEFTWARD;
      }
    break;
    }
  }
}

void keyReleased(){
  
}
