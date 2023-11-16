import peasy.*;


PeasyCam cam;
Drapeau d;
PVector gravite, vent;
float dt = 0.03f;

float rigiditePrincipale=1;
float rigiditeSecond=0.1;
float rigiditeDiag=0.1;

void genereVent(float n) {
  vent.x = random(0,5);
  vent.y = 0.0;
  vent.z = random( - 5,5);
  
  vent.mult(n);
}

void dessinerDirectionVent(PVector position, float size){
  
  PVector vn = new PVector(0,0,0);
  vent.normalize(vn);
  
  PVector pointVers = PVector.add(position, vn);

  fill(60,200,114);
 
  beginShape(TRIANGLES);
  
  vertex(position.x, position.y -size/2, position.z);
  
  vertex(position.x, position.y+size /2, position.z);
  
  vertex(pointVers.x +size , pointVers.y, pointVers.z);
  
  endShape();
  
  
 beginShape(TRIANGLES);
  
  vertex(position.x, position.y, position.z -size/2);
  
  vertex(position.x, position.y, position.z +size /2);
  
  vertex(pointVers.x +size , pointVers.y, pointVers.z);
  
  endShape();
        
}


void setup() { 
    
  size(1240,720,P3D);
  frameRate(30);
  
  cam = new PeasyCam(this,500);
  
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  cam.setSuppressRollRotationMode(); 
  
  d = new Drapeau(new PVector(0,0,0), 20 , 5 , 10 ,0.01, 100, 5.5);
  vent = new PVector(0,0,0); 
  gravite = new PVector(0,9.8,0); 
  
}


void draw() {
  background(200);
  
  genereVent(10);
  dessinerDirectionVent(new PVector(-100,-100,0), 50 );
  
  d.dessiner();
  d.mettreAJour(dt);
    
}
