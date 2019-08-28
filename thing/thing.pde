import java.util.Random; //<>//
Thing floor;
Player player;
//Asteroid test1;
Asteroid[] asteroids=new Asteroid[500];
float globalx=0;
float globaly=0;
int sizew=500;
int sizeh=500;
public void setup() {
  size(500, 500); //set equal to sizew and sizeh
  floor=new Thing(20, 300, 400, 20);
  player=new Player((float)sizew/2, (float)sizeh/2, PI);
  //test1=new Asteroid(30,30,0.785398,0.5,20);
    generateAst((float)globalx-100,(float)globalx,(float)globalx+sizew,(float)globalx+sizew+100, (float)globaly-100, (float)globaly, (float) globaly+sizeh, (float) globaly+sizeh+100, (float)1, (float)3, 10);
    //redo coordinate system
}
public float randnum(float a, float b, float c, float d){
  if(Math.random()>0.5){
    return (float)Math.random()*(b-a)+a;
  } else {
      return (float)Math.random()*(d-c)+c;
  }
}
public long getmill() {
        long nowMillis = System.currentTimeMillis();
        return nowMillis;
    }
int count=0;
public void drawbackground(){
  //add parallax stars
}
public void draw() {
  background(199, 199, 199);
  floor.show();
  player.show();
  player.update();
  //test1.show();
  //test1.update();
  for(int i=0;i<asteroids.length;i++){
    if(asteroids[i]!=null){
      asteroids[i].show();
      asteroids[i].update();
    }
    }
  count++;
  if(count==5){
    count=0; 
    generateAst((float)globalx-100,(float)globalx,(float)globalx+sizew,(float)globalx+sizew+100, (float)globaly-100, (float)globaly, (float) globaly+sizeh, (float) globaly+sizeh+100, (float)1, (float)3, 1);
    //cleanAst();
}
}
void cleanAst(){
  for(int j=0;j<asteroids.length;j++){
    if(asteroids[j]!=null&& (Math.abs((float)asteroids[j].x-(float)globalx)>1000||Math.abs((float)asteroids[j].y-(float)globaly)>5000)){
      asteroids[j]=null;
    }
  }
}
void generateAst(float x1, float x2, float  x3, float x4, float y1, float y2, float y3, float y4, float sp1, float sp2, int num) {
  int arlength=0;
  for(int i=0;i<asteroids.length;i++){
    if(asteroids[i]!=null){
      arlength++;
    }
  }
  //System.out.println(arlength);
  for (int i=arlength; i<num+arlength; i++) {
    asteroids[i]=new Asteroid(randnum(x1,x2,x3,x4), randnum(y1,y2,y3,y4), (float)Math.random()*(2*PI), randnum(sp1,sp2, sp2, sp2),(float)40);
  }
}
public void test() {
}

public float getAngle(float x1, float y1, float x2, float y2) {
  float angle = (float) Math.atan2(y2 - y1, x2 - x1);
  return angle;
}
class Asteroid {
  float x, y;
  float direction, speed;
  float size;
  Asteroid(float ax, float ay, float adir, float aspeed, float asize) {
    x=ax;
    y=ay;
    direction=adir;
    speed=aspeed;
    size=asize;
  }
  void update() {
    x+=cos(direction)*speed;
    y+=sin(direction)*speed;
  }
  void show() {
    fill(color(171, 111, 0));
    ellipse(x-globalx, y-globaly, size, size);
  }
}
class Player {
  float x=(float)sizew/2;
  float y=(float)sizeh/2;
  float rota;
  int rgbc=color(64, 108, 255);
  float size=20;
  float xVel=0;
  float yVel=0;
  float xAccel=0, yAccel=0;
  float friction=0.075f;
  float speed=1.5f;
  float accel=0.3f;
  Player(float ax, float ay, float rotat) {
    rota=rotat;
  }
  public void show() {
    float leng=size/sqrt(3);
    fill(rgbc);
    triangle(x+leng*cos(rota)*1.5f, y+leng*sin(rota)*1.5f, x+leng*cos(rota+2*PI/3), y+leng*sin(rota+2*PI/3), x+leng*cos(rota+4*PI/3), y+leng*sin(rota+4*PI/3));
  }
  public void update() {
    rota=getAngle(sizew/2, sizeh/2, mouseX, mouseY);
    if (mousePressed == true) {
      xAccel = cos(rota)*accel;
      yAccel = sin(rota)*accel;
      xVel += xAccel;
      yVel += yAccel;
    }
    globalx+=xVel*speed;
    globaly+=yVel*speed;
    if (xVel>0) {
      xVel-=friction;
    } else if (abs(xVel)<=friction) {
      xVel=0;
    } else if (xVel<0) {
      xVel+=friction;
    }
    if (yVel>0) {
      yVel-=friction;
    } else if (abs(yVel)<=friction) {
      yVel=0;
    } else if (yVel<0) {
      yVel+=friction;
    }
  }
}
class Thing {
  float x, y, w, h;
  Thing(float ax, float ay, float aw, float ah) {
    x=ax;
    y=ay;
    w=aw;
    h=ah;
  }
  public void show() {
    fill(255);
    rect(x-globalx, y-globaly, w, h);
  }
}
