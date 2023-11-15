class Triangle{

/*
    public int idParticule1;
    public int idParticule2;
    public int idParticule3;
*/

    public Particule particule1;
    public Particule particule2;
    public Particule particule3;

    public float amortissementAir;
    public PVector normale = new PVector(0,0,0);

    public Triangle(Particule p1, Particule p2, Particule p3, float aa){
        particule1=p1;
        particule2=p2;
        particule3=p3; 
        amortissementAir =aa;

        calculerNormale();


    }

    public void calculerNormale(){

        PVector p1P2 = PVector.sub(particule2.position , particule1.position);
        PVector p1P3 = PVector.sub(particule3.position , particule1.position);

        PVector.cross(p1P2,p1P3,normale);
        normale.normalize();



    }

    public void dessiner(){

        particule1.dessiner(10);
        particule2.dessiner(10);
        particule3.dessiner(10);

        stroke(0);
        line(particule1.position.x ,particule1.position.y,particule1.position.z,
             particule2.position.x ,particule2.position.y,particule2.position.z);

        line(particule1.position.x ,particule1.position.y,particule1.position.z,
            particule3.position.x ,particule3.position.y,particule3.position.z);

        line(particule2.position.x ,particule2.position.y,particule2.position.z,
             particule3.position.x ,particule3.position.y,particule3.position.z);

    }
    
    

}