class Mass {
    PVector position;
    PVector velocity;
    PVector externalForce; 
    float weight;
    ArrayList<Spring> springs; // les springs directs

    public Mass(PVector position) {
        this.position = position;
        velocity = new PVector(0, 0, 0);
        weight = 0.5;
    }
    
    public void update() {
        // TODO : intégration
        // TODO : influence des ressorts
    }
}