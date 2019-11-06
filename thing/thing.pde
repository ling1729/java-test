import java.util.Random; //<>// //<>//
import java.util.ArrayList;
Thing floor;
Player player;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<Bullet> bullets=new ArrayList<Bullet>();
ArrayList<ArrayList<Star>> starChunks = new ArrayList<ArrayList<Star>>();
float globalx=0;
float globaly=0;
int sizew=500;
int sizeh=500;
int chunky;
int chunkx;
float minStarSize=1;
float maxStarSize=10;
public void setup() {
		size(500, 500); //set equal to sizew and sizeh
		floor=new Thing(20, 300, 400, 20);
		player=new Player((float)sizew/2, (float)sizeh/2, PI);
		generateAst((float)globalx-100, (float)globalx, (float)globalx+sizew, (float)globalx+sizew+100, (float)globaly-100, (float)globaly, (float) globaly+sizeh, (float) globaly+sizeh+100, 1, 3, 10);
		for (int i=-1; i<2; i++) {
			for (int j=-1; j<2; j++) {
				genChunk(i, j);
			}
		}
		chunkx=getChunkx();
		chunky=getChunky();
		bullets.add(new Bullet(250,250,5,player.rota));
	}
public void genChunk(int i, int j) { //i is y and j is x
	generateStar((float)500*(i), (float)500*(i)+500, (float)500*(j), (float)500*(j)+500, minStarSize, maxStarSize, 50);
	starChunks.add((ArrayList<Star>)stars.clone());
	stars.clear();
}

public void clearChunk() {
	int loadlimit=2;
	int x=getChunkx(); 
	int y=getChunky();
	for (int i=0; i<starChunks.size(); i++) {
		if (starChunks.get(i).get(0).getX()<(x-loadlimit+1)*500||
			starChunks.get(i).get(0).getX()>(x+loadlimit)*500||
			starChunks.get(i).get(0).getY()<(y-loadlimit+1)*500||
			starChunks.get(i).get(0).getY()>(y+loadlimit)*500)
			starChunks.remove(i);
		i++;
	}
}
public void clearAst() {
	int x=getChunkx(); 
	int y=getChunky();
	for (int i=0; i<asteroids.size(); i++) {
		if (asteroids.get(i).x<(x-4)*500||asteroids.get(i).x>(x+4)*500||asteroids.get(i).y<(y-4)*500||asteroids.get(i).y>(y+4)*500)
			asteroids.remove(i);
		i++;
	}
}
public float randnum(float a, float b, float c, float d) {
	if (Math.random()>0.5) {
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
public void drawbackground() {
	for (int i=0; i<starChunks.size(); i++) {
		for (int j=0; j<starChunks.get(i).size(); j++) {
			starChunks.get(i).get(j).show();
		}
	}
}
public void draw() {
	background(0);
	drawbackground();
	floor.show();
	player.show();
	player.update();
	for (int i=0; i<asteroids.size(); i++) {
		asteroids.get(i).show();
		asteroids.get(i).update();
	}
	if (chunkx>getChunkx()) {
		genChunk(getChunkx()-1, getChunky()-1);
		genChunk(getChunkx()-1, getChunky());
		genChunk(getChunkx()-1, getChunky()+1);
		chunkx=getChunkx();
	}
	if (chunkx<getChunkx()) {
		genChunk(getChunkx()+1, getChunky()-1);
		genChunk(getChunkx()+1, getChunky());
		genChunk(getChunkx()+1, getChunky()+1);
		chunkx=getChunkx();
	}

	if (chunky>getChunky()) {
		genChunk(getChunkx()-1, getChunky()-1);
		genChunk(getChunkx(), getChunky()-1);
		genChunk(getChunkx()+1, getChunky()-1);
		chunky=getChunky();
	}
	if (chunky<getChunky()) {
		genChunk(getChunkx()-1, getChunky()+1);
		genChunk(getChunkx(), getChunky()+1);
		genChunk(getChunkx()+1, getChunky()+1);
		chunky=getChunky();
	}
	clearChunk();
	clearAst();
	count++;
	if (count==8) {
		count=0;
		generateAst((float)globalx-100, (float)globalx, (float)globalx+sizew, (float)globalx+sizew+100, (float)globaly-100, (float)globaly, (float) globaly+sizeh, (float) globaly+sizeh+100, (float)1, (float)3, 1);
	}
	count2++;
	if (keyPressed) {
		if (key==(char)32) {
			if(count2>10){
				bullets.add(new Bullet(globalx+250,globaly+250,5,player.rota));
				count2=0;
			}
		}
	}
	for(int i=0;i<bullets.size();i++){
		bullets.get(i).update();
		bullets.get(i).show();
	}
	count2++;
}
int count2=0;
void generateAst(float x1, float x2, float    x3, float x4, float y1, float y2, float y3, float y4, float sp1, float sp2, int num) {
	//System.out.println(arlength);
	for (int i=0; i<num; i++) {
		asteroids.add(new Asteroid(randnum(x1, x2, x3, x4), randnum(y1, y2, y3, y4), (float)Math.random()*(2*PI), randnum(sp1, sp2, sp2, sp2), (float)40));
	}
}
void generateStar(float x1, float x2, float y1, float y2, float size1, float size2, int num) {
	for (int i=0; i<num; i++) {
		stars.add(new Star(randnum(x1, x2, x1, x2), randnum(y1, y2, y1, y2), randnum(size1, size2, size1, size2)));
	}
		//System.out.println(arlength);
}
public int getChunkx() {
	return (int)Math.floor(globalx/(500));
}
public int getChunky() {
	return (int)Math.floor(globaly/(500));
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
		x = ax;
		y = ay;
		direction = adir;
		speed = aspeed;
		size = asize;
	}
	public void update() {
		x += cos(direction)*speed;
		y += sin(direction)*speed;
	}
	public float getX(){
		return x;
	}
	public float getY(){
		return y;
	}
	public void show() {
		fill(color(171, 111, 0));
		ellipse(x-globalx, y-globaly, size, size);
	}
}
class Star {
	float distance = 0.1;
	float sizeEffect = 0.5;
	float x, y, size;
	float startx = globalx;
	float starty = globaly;
	public float getX(){
		return x;
	}
	public float getY(){
		return y;
	}
	Star(float ax, float ay, float asize) {
		x=ax;
		y=ay;
		size=asize;
	}
	public void show() {
		fill(255);
		ellipse(x-globalx-(distance+sizeEffect*size/maxStarSize)*(globalx-startx), y-globaly-(distance+sizeEffect*size/maxStarSize)*(globaly-starty), size, size);
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
	float friction=0.05;
	float speed=0.75f;
	float accel=0.15f;

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
			xVel += Math.abs(xAccel)<0.75?xAccel:0;
			yVel += Math.abs(yAccel)<0.75?yAccel:0;
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

class Bullet {
	float x, y, r, rota;
	float speed=20;
	Bullet(float ax, float ay, float ar, float adir) {
		this.x=ax;
		this.y=ay;
		this.r=ar;
		this.rota=adir;
	}
	public void show() {
		fill(255,0,0);
		ellipse(x-globalx, y-globaly, r, r);
	}
	public void update() {
		x+=cos(rota)*speed;
		y+=sin(rota)*speed;
	}
}
