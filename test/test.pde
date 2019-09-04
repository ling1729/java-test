import java.util.Random;
import java.util.ArrayList;
//Asteroid test1;
ArrayList<Star> stars=new ArrayList<Star>();
ArrayList<ArrayList<Star>> starChunks = new ArrayList<ArrayList<Star>>();
float globalx=0;
float globaly=0;
int sizew=500;
int sizeh=500;
Star star2;
public void setup() {
  size(500, 500); //set equal to sizew and sizeh
  generateStar((float)globalx-100, (float)globalx+600, (float)globaly-100, (float)globaly+600, (float)2, (float)10, 100);
  //System.out.println(stars);
  starChunks.add(stars);
  stars.clear();
  //System.out.println(starChunks);
  //generateStar((float)globalx-100, (float)globalx+600, (float)globaly-100, (float)globaly+600, (float)2, (float)10, 100);
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
  for(int i=0;i<stars.size();i++){
    for(int j=0;j<starChunks.size();j++){
      starChunks.get(j).get(i).show();
    }
   }
  
}
public void draw() {
  background(230);
  drawbackground();
  
  //test1.show();
  //test1.update();
  //generateStar((float)globalx-100, (float)globalx+600, (float)globaly-100, (float)globaly+600, (float)1, (float)5, 1);
}
/*
void cleanAst(){
  for(int j=0;j<asteroids.size();j++){
    if((Math.abs((float)asteroids[j].x-(float)globalx)>1000||Math.abs((float)asteroids[j].y-(float)globaly)>5000)){
      asteroids[j]=null;
    }
  } //fix to arraylength
}*/
import java.io.*;
 public static Object deepClone(Object object) {
   try {
     ByteArrayOutputStream baos = new ByteArrayOutputStream();
     ObjectOutputStream oos = new ObjectOutputStream(baos);
     oos.writeObject(object);
     ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
     ObjectInputStream ois = new ObjectInputStream(bais);
     return ois.readObject();
   }
   catch (Exception e) {
     e.printStackTrace();
     return null;
   }
 }
/**
 * These classes implement Serializable so we can write them out and 
 * read them back in as a stream of bytes.
 */
void generateStar(float x1, float x2, float y1, float y2, float size1, float size2, int num) {
    for (int i=0; i<num; i++) {
      //Star cloneStar=new Star(randnum(x1,x2,x1,x2), randnum(y1,y2,y1,y2), randnum(size1,size2,size1,size2));
      //stars.add(cloneStar);
      Star test=new Star(randnum(x1,x2,x1,x2), randnum(y1,y2,y1,y2), randnum(size1,size2,size1,size2));
      System.out.println((Star)deepClone(test));
      //stars.add((Star)deepClone(test));

  }
  //System.out.println(arlength);
}

class Star {
  float x,y,size;
  Star(float ax, float ay, float asize){
    x=ax;
    y=ay;
    size=asize;
  }
  public void show(){
    fill(255);
    circle(x-globalx, y-globaly, size);
  }
  public Star(Star another){
    this.x=another.x;
    this.y=another.y;
    this.size=another.size;
  }
}
