class Ressort{
  
    public float rigidite;
    public float longueurRepos;
/*
    public int idParticule1;
    public int idParticule2;

    Ressort(int id1, int id2, float k, float l0){
        rigidite=k;
        longueurRepos=l0;
        idParticule1=id1;
        idParticule2=id2;

    }
*/

    public Particule particule1;
    public Particule particule2;

    Ressort(Particule p1, Particule p2, float k, float l0){
        rigidite=k;
        longueurRepos=l0;
        particule1=p1;
        particule2=p2;

    }


   public void dessiner(){
        
        particule1.dessiner(10);
        particule2.dessiner(10);
        stroke(0);
        line(particule1.position.x ,particule1.position.y,particule1.position.z,
             particule2.position.x ,particule2.position.y,particule2.position.z);

    }
}