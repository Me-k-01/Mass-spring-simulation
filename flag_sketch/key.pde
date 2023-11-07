
public class Key { // Paire permutable pour le dictionnaire des springs
    private final int x;
    private final int y;

    public Key(int x, int y) {
        this.x = x;
        this.y = y;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Key)) return false;
        Key key = (Key) o;
        return x == key.x && y == key.y || x == key.y && x == key.y; // Il n'y a qu'un ressort qui relie les deux sommets
    }

    @Override
    public int hashCode() { 
        return x*y; // 31 * result + y
    }
}
