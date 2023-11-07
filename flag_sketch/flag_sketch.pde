
HashMap<Key, Spring> springs; // On utilise un hashmap pour avoir directement les ressorts entres les masses
ArrayList<Mass> masses; // Listes des vertex du maillage

void setup() {
    springs = new HashMap<Key, Spring>();// Définis les springs selon les paires d'indices des vertices.
    masses = new ArrayList<Mass>();
    // spings.get(new Key(2, 5)); // pour avoir le spring entre le vertex 2 et 5

    // TODO : chargement des points du maillage dans les masses, et des ressorts.
}


void draw() {
    // TODO : update des masses et des ressorts
    // TODO : affichage de l'objet 
}
