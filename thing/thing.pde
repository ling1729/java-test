Thing floor;
Player player;
float globalx=0;
float globaly=0;
void setup(){
  size(500,500);
  floor=new Thing(20,300,400,20);
  player=new Player(250,250,PI);
}
void draw(){
  background(199, 199, 199);
  floor.show();
  player.show();
  player.update();
}
void test(){
  
}
public float getAngle(float x1, float y1, float x2, float y2) {
    float angle = (float) Math.atan2(y2 - y1, x2 - x1);
    return angle;
}
class Player{
  int x=250;
  int y=250;
  float rota;
  int rgbc=color(64, 108, 255);
  float size=20;
  float xVel=1;
  float yVel=1;
  float xAccel=0, yAccel=0;
  float friction=0.5;
  float speed=2;
  float accel=2;
  Player(int ax, int ay, float rotat){
    rota=rotat;
  }
  void show(){
    float leng=size/sqrt(3);
    fill(rgbc);
    triangle(x+leng*cos(rota)*1.5,y+leng*sin(rota)*1.5,x+leng*cos(rota+2*PI/3),y+leng*sin(rota+2*PI/3), x+leng*cos(rota+4*PI/3), y+leng*sin(rota+4*PI/3));
  }
  void update(){
    rota=getAngle(250,250,mouseX, mouseY);
    if (mousePressed == true) {
    xVel=cos(rota)*speed;
    yVel=sin(rota)*speed;
    globalx+=xVel;
    globaly+=yVel;
    xAccel = sin(rota)*accel;
    yAccel = cos(rota)*accel;
    xVel += xAccel;
    yVel += yAccel;
    }
  }
}
class Thing{
  int x,y,w,h;
  int rgbc=255;
  Thing(int ax, int ay, int aw, int ah){
    x=ax;
    y=ay;
    w=aw;
    h=ah;
  }
  void show(){
    fill(rgbc);
    rect(x-globalx,y-globaly,w,h);
  }
}
