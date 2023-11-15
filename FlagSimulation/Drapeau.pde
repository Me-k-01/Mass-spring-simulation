class Drapeau{

    public ArrayList<Particule> particules = new ArrayList<Particule>();
    public int longueur;
    public int largeur;
    public float espacement = 100.f;
    public PVector position;
    
    public ArrayList<Ressort> ressorts = new ArrayList<Ressort>();
    public ArrayList<Triangle> triangles = new ArrayList<Triangle>();
    

    public Drapeau(PVector p, int nbParticules, int l, float masses , float amortissementAirMasses , float rigide, float longRep,float amortissementAirTri  ){

        // generation des particules
        //============================================
        position =p;//position du coin superieur gauche
        longueur =l;
        largeur = nbParticules / longueur;

        float x,y=0;
        PVector posParticule;
        for(int i =0 ; i<nbParticules ; i++){
          
            x = (i%longueur)*espacement;
            y = int(i/longueur)*espacement;
            posParticule = new PVector(x,y,0).add(position);
            
            particules.add(new Particule(posParticule,new PVector(0,0,0), masses , amortissementAirMasses ));
            
            

        }
        //contraintes
        particules.get(0).statique = true;
        if(nbParticules >2)
          particules.get((largeur-1) * longueur).statique = true;
        //============================================
        // generation des ressorts
        //============================================
        boolean lar,lon;
        for(int i =0 ; i<nbParticules ; i++){
            lar=false;
            lon=false;
            
            if( (i % longueur) < longueur-1 ){
                ressorts.add(new Ressort( particules.get(i), particules.get(i+1), rigide, longRep  ));
                //ressorts.add(new Ressort( particules.get(i+1), particules.get(i), rigide, longRep  ));
                lon = true;
            }
            if( int(i/longueur) < largeur-1 ){
                ressorts.add(new Ressort( particules.get(i), particules.get(i+longueur), rigide, longRep  ));
                lar=true;
            }
            if(lar && lon)
                ressorts.add(new Ressort( particules.get(i), particules.get(i+longueur+1), rigide, longRep*sqrt(2)  ));
            
        }
        //============================================
        // generation des triangle
        //============================================
        
       
        if(nbParticules > 2 && largeur > 1 && longueur >1){
            int ind;
            if(nbParticules == 3)
                triangles.add(new Triangle(particules.get(0), particules.get(1), particules.get(2), amortissementAirTri));
            else{
                for(int i =0 ; i<largeur ; i++){
                    for(int j=0 ; j<longueur-1 ; j++){
                        ind = j + (i *longueur);
                        if(i%2==0)
                            triangles.add(new Triangle(particules.get(ind), particules.get(ind+1), particules.get(ind+longueur+1), amortissementAirTri));
                        else
                            triangles.add(new Triangle(particules.get(ind), particules.get(ind-longueur), particules.get(ind+1), amortissementAirTri));
                    }
                }
            }
            
        }
          
        
        
       
    }
    
    public void forces(){

        // 3 boucles sur chaque tableau
        //particules
        PVector v, vn, f;
        Particule partI;
        for(int i =0 ; i<particules.size();i++){
            partI = particules.get(i);
            vn = new PVector(0,0,0);
            v = PVector.sub(partI.velocite, vent);
            v.normalize(vn);
            
            f = PVector.mult(vn, -partI.amortissementAir * v.dot(v) );
            PVector.add( PVector.mult(gravite,partI.masse),f, partI.forceExterne );
           
        }
        //ressorts
        Ressort resI;
        PVector p1P2;
        float dist;
        for(int i =0 ; i<ressorts.size();i++){
            
            resI = ressorts.get(i);
            p1P2 = PVector.sub(resI.particule2.position, resI.particule1.position);

            dist = p1P2.mag();

            f = PVector.mult(p1P2, (dist - resI.longueurRepos)* -resI.rigidite  );
            //print(dist+"\n");
            resI.particule1.forceExterne.add(f);
            resI.particule2.forceExterne.sub(f);
        }
        //triangles
        Triangle triI;
        PVector surf;
        for(int i =0 ; i<triangles.size();i++){
            
            triI = triangles.get(i);
            triI.calculerNormale();

            surf= PVector.mult( PVector.add(triI.particule1.velocite, 
                                            PVector.add(triI.particule2.velocite,triI.particule3.velocite) 
                                            )
                               , (1.f/3.f));
            v = PVector.sub(vent,surf);

            f = PVector.mult( 
                            PVector.mult(  triI.normale,
                                           ( v.dot(triI.normale)* triI.amortissementAir))
                            , (1.f/3.f)
                            );
            triI.particule1.forceExterne.add(f);
            triI.particule2.forceExterne.add(f);
            triI.particule3.forceExterne.add(f);

        }
      

        
      
    }
    
    
    
    public void mettreAJour(float t){
      
        forces();
        for(int i =0 ; i<particules.size();i++){
            particules.get(i).integration(t);
            
        }
       
      
    }
    
    
    public void dessiner(){
       /*
        for(int i =0 ; i<particules.size();i++){
            particules.get(i).dessiner(10);
        }
        */
        
        for(int i =0 ; i<ressorts.size();i++){
            ressorts.get(i).dessiner();
        }
        

        //triangles.get(0).dessiner();
    }


}
