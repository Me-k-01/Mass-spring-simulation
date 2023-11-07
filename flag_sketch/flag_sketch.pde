 
ArrayList<Mass> masses; // Listes des vertex du maillage
ArrayList<Triangle> faces; 
PVector flagSize = new PVector(10, 10);

void setup() { 
    masses = new ArrayList<Mass>(); 

    // TODO : chargement des points du maillage dans les masses, et des ressorts.
    for (int i = 0; i < flagSize.x; i++) {
        for (int j = 0; j < flagSize.y; j++) {
            masses.add(new Mass(new PVector(i, j)));
        }
    } 

    
    // Triangle haut gauche -> [(x, y), (x+1, y), (x+1, y-1)]
    // Triangle bas droit -> [(x+1, y), (x+1, y-1), (x, y-1)]

}


void draw() {
    // TODO : update des masses et des ressorts
    // TODO : affichage de l'objet 
}
