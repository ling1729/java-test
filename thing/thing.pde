import java.util.Random; //<>//
Thing floor;
Player player;
//Asteroid test1;
Asteroid[] asteroids=new Asteroid[10];
float globalx=0;
float globaly=0;
public void setup() {
  size(500, 500);
  floor=new Thing(20, 300, 400, 20);
  player=new Player(250, 250, PI);
  //test1=new Asteroid(30,30,0.785398,0.5,20);
  for(int i=0;i<10;i++){
    generateAst((float)globalx-100,(float)globalx+100,(float)globaly-100,(float)globaly+100,(float)0, (float)1, 10);
    //redo coordinate system
  }
}
public void draw() {
  background(199, 199, 199);
  floor.show();
  player.show();
  player.update();
  //test1.show();
  //test1.update();
  for(int i=0;i<asteroids.length;i++){
    asteroids[i].show();
    asteroids[i].update();
    
  }
}
void generateAst(float x1, float x2, float y1, float y2, float sp1, float sp2, int num) {
  for (int i=0; i<num; i++) {
    asteroids[i]=new Asteroid((float)Math.random()*(x2-x1)+x1, (float)Math.random()*(y2-y1)+y1, (float)Math.random()*(2*PI), (float)Math.random()*(sp2-sp1)+sp1,(float)40);
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
  float x=250;
  float y=250;
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
    rota=getAngle(250, 250, mouseX, mouseY);
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
