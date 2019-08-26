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
