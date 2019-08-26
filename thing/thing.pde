Thing floor;
void setup(){
  size(500,500);
  floor=new Thing(20,200,300,20);
}
void draw(){
  background(199, 199, 199);
  floor.show();
}
void test(){
  
}

class Player{
  int ax,ay, rotate, rgb;
  float accel, rota, size;
  Thing(int x, int y, float rota float accel){
    ax=x;
    ax=x;
    rota=rota;
    accel=accel;
  }
  void show{
    float leng=size/sqrt(3);
    fill(rgb);
    triangle(leng*cos(rotate),leng*cos(rotate),leng*cos(rotate+2*PI/3),leng*sin(rotate+2*PI/3), leng*cos(rotate+4*PI/3), leng*sin(rotate+4*PI/3));
  }
  void update{
  }
}
class Thing{
  int ax,ay,aw,ah,rgb;
  Thing(int x, int y, int w, int h){
    ax=x;
    ay=y;
    aw=w;
    ah=h;
  }
  void show(){
    fill(rgb);
    rect(ax,ay,aw,ah);
  }
}
