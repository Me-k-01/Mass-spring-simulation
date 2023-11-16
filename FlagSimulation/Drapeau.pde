class Drapeau{
    
    public ArrayList<Particule> particules = new ArrayList<Particule>();
    public int longueur;
    public int largeur;
    
    public PVector position;
    
    public ArrayList<Ressort> ressorts = new ArrayList<Ressort>();
    public ArrayList<Triangle> triangles = new ArrayList<Triangle>();
    
    
    public Drapeau(PVector p, int nbParticules, int l, float masses , float amortissementAirMasses , float rigide, float longRep,float amortissementAirTri ) {
        
        // generation des particules
        //============================================
        position = p;//position du coin superieur gauche
        longueur = l;
        largeur = nbParticules / longueur;
        
        float x,y = 0;
        PVector posParticule;
        for (int i = 0; i < nbParticules; i++) {
            
            x = (i % longueur) * longRep;
            y = int(i / longueur) * longRep;
            posParticule = new PVector(x, y, 0).add(position);
            
            particules.add(new Particule(posParticule, new PVector(0,0,0), masses, amortissementAirMasses));
        }

        // contraintes statiques 
        particules.get(0).statique = true;
        if (nbParticules > 2)
            particules.get((largeur - 1) * longueur).statique = true; 


        //============================================
        // generation des ressorts
        //============================================
        boolean lar,lon;
        for (int i = 0; i < nbParticules; i++) {
            lar = (i % longueur) < longueur - 1;
            lon = int(i / longueur) < largeur - 1;
            
            if (lar) {
                ressorts.add(new Ressort(particules.get(i), particules.get(i + 1), rigide, longRep ));
            }
            if (lar) {
                ressorts.add(new Ressort(particules.get(i), particules.get(i + longueur), rigide, longRep )); 
            }
            if (lar && lon)
                ressorts.add(new Ressort(particules.get(i), particules.get(i + longueur + 1), rigide, longRep * sqrt(2) ));

            // TODO : ajouter plus de ressort au voisin indirecte et reduire leurs rigidité poids
        }


        //============================================
        // generation des triangle
        //============================================
        if (nbParticules > 2 && largeur > 1 && longueur > 1) {
            int ind;
            if (nbParticules == 3)
                triangles.add(new Triangle(particules.get(0), particules.get(1), particules.get(2), amortissementAirTri));
            else {
                for (int i = 0; i < largeur; i++) {
                    for (int j = 0; j < longueur - 1; j++) {
                        ind = j + (i * longueur);
                        if (i % 2 == 0)
                            triangles.add(new Triangle(particules.get(ind), particules.get(ind + 1), particules.get(ind + longueur + 1), amortissementAirTri));
                        else
                            triangles.add(new Triangle(particules.get(ind), particules.get(ind - longueur), particules.get(ind + 1), amortissementAirTri));
                    }
                }
            }
            
        }  
    }
    
    public void forces() {
        
        // 3 boucles sur chaque tableau
        //particules

        for (int i = 0; i < particules.size();i++) {
            particules.get(i).calculerForces();            
        }

        //ressorts
        for (int i = 0; i < ressorts.size();i++) {
            ressorts.get(i).calculerForces();    
        }

        //triangles
        for (int i = 0; i < triangles.size();i++) {
            triangles.get(i).calculerForces();    
        }
    }
    
    
    
    public void mettreAJour(float t) {
        
        forces();
        for (int i = 0; i < particules.size();i++) {
            particules.get(i).integration(t);
        }
    }
    
    
    public void dessiner() {
        /*
        for(int i =0 ; i<particules.size();i++){
        particules.get(i).dessiner(10);
    }
        */
        
        for (int i = 0; i < ressorts.size();i++) {
            ressorts.get(i).dessiner();
        }
        //triangles.get(0).dessiner();
    }
}
