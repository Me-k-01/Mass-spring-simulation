import peasy.*;


PeasyCam cam;
Drapeau d;
PVector gravite, vent;


void genereVent(float n) {
    
  vent.x = random(0,5);
  vent.y = 0.0;
  vent.z = random( - 5,5);
  
  vent.mult(n);
}

void setup() { 
    
  size(1240,720,P3D);
  frameRate(30);
  
  cam = new PeasyCam(this,500);
  
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  cam.setSuppressRollRotationMode(); 
  
  d = new Drapeau(new PVector(0,0,0), 20 , 5 , 0.3 ,0.01 ,0, 100, 5.5);
  vent=  new PVector(0,0,0); 
  gravite = new PVector(0,5.8,0); 
  
}


void draw() {
  background(200);
  
  //genereVent(10);
  d.dessiner();
  d.mettreAJour(0.01f);
  
    
}
