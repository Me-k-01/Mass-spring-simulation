import peasy.*;


PeasyCam cam;
Drapeau d;
PVector gravite, vent;
float dt = 0.001f;


float rigiditePrincipale=10;
float rigiditeSecond=1;
float rigiditeDiag=1;

boolean pause = false;
boolean renduTriangle = true;



void genereVent(float n) {
  vent.x = random(0,5);
  vent.y = 0.0;
  vent.z = random(-5,5);
  
  vent.mult(n);
}

void setup() { 
    
  size(1240,720,P3D);
  frameRate(30);
  
  cam = new PeasyCam(this,500);
  
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1000);
  cam.setSuppressRollRotationMode(); 
 
  d = new Drapeau(new PVector(0,0,0), 140 , 14 , 5 ,0.01, 50, 5.5);
  vent = new PVector(0,0,0); 
  gravite = new PVector(0,9.8,0); 
  
}

void keyPressed(){

  if (key == 't') {
    renduTriangle = !renduTriangle;
    println("Configuration : rendu en triangle à " + renduTriangle);
  } 
  if(key == 'p'){//pause
    pause = !pause;
    println("Configuration : Pause à " + pause);
  }
  
}

void draw() {
  background(200);
  
  d.dessiner(renduTriangle);
  genereVent(20);
  
  if(pause){
    for(float i = 0; i < 0.1f; i+= dt){
      d.mettreAJour(dt);
    }
  }
    
}
