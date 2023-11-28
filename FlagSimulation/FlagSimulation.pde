import peasy.*;
 

PeasyCam cam;
Drapeau d;
PVector gravite, vent;
float dt = 0.001f;


float rigiditePrincipale;
float rigiditeSecond;
float rigiditeDiag;

boolean pause = false;
boolean renduTriangle = true;

int presetActuel = 1; 
JSONObject config;
JSONArray presets;

void genereVent(float n) {
  vent.x = random(0,5);
  vent.y = 0.0;
  vent.z = random(-5,5);
  
  vent.mult(n);
}

void modifVent() {
  vent.x += random(0, 0.1);
  vent.z += random(-0.1,0.1);
}

void setup() {   
  config = loadJSONObject("preset.json");
  presets = config.getJSONArray("presets"); 
  
   
  size(1240, 720, P3D);
  frameRate(30);
  
  cam = new PeasyCam(this, 500);
  
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1000);
  cam.setSuppressRollRotationMode(); 
  
  sceneSetup();
}

void sceneSetup() {
  config = presets.getJSONObject(presetActuel);   
  
  rigiditePrincipale = config.getFloat("rigidite_principale");
  rigiditeSecond = config.getFloat("rigidite_secondaire");
  rigiditeDiag = config.getFloat("rigidite_diagonale");
 
  JSONArray posD = config.getJSONArray("position");  
  d = new Drapeau(
    new PVector(posD.getFloat(0), posD.getFloat(1), posD.getFloat(2)), 
    config.getInt("nombre_de_particules"), 
    config.getInt("taille_du_drapeau"),
    config.getFloat("masses"),
    config.getFloat("amortissement_air_masses"),
    config.getFloat("longueur_repos"),
    config.getFloat("amortissement_air_tri"),
    config.getJSONArray("masses_statiques")
  );
  vent = new PVector(0,0,0); 
  gravite = new PVector(0,9.8,0);  
  genereVent(config.getFloat("puissance_du_vent"));
}

void keyPressed(){

  if (key == 't') {
    renduTriangle = !renduTriangle;
    println("Configuration : rendu en triangle à " + renduTriangle);
  } 
  if(key == 'p') {//pause
    pause = !pause;
    println("Configuration : Pause à " + pause);
  }
  //////// preset ////////
  if(key == '1' || key == '&') { // drapeau
    println("Configuration : Changement de scene");
    presetActuel = 0;
    sceneSetup();
  }
  if(key == '2' || key == 'é') { // haut fixé
    println("Configuration : Changement de scene");
    presetActuel = 1;
    sceneSetup();
  }
  if(key == '3' || key == '"') { // drap pendu par les coins
    println("Configuration : Changement de scene");
    presetActuel = 2;
    sceneSetup();
  }
}

void draw() {
  background(200);
  
  d.dessiner(renduTriangle);
  modifVent();
  
  if (!pause) {
    for(float i = 0; i < 0.1f; i+= dt){
      d.mettreAJour(dt);
    }
  }
    
}
