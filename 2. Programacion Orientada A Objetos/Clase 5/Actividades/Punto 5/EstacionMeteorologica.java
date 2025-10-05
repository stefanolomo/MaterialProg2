public class EstacionMeteorologica {
    // |          Variables de estado          |
    
    private int latitud, longitud;
    private String nombre;
    
    // |          Constructores          |
    
    public EstacionMeteorologica (int latitud, int longitud, String nombre) {
        this.latitud = latitud;
        this.longitud = longitud;
        this.nombre = nombre;
    }
    
    public EstacionMeteorologica () {}
    
    // |          Getters y Setters          |
    
    
    public String getNombre() {
        return this.nombre;
    }
    
    public int getLatitud() {
        return this.latitud;
    }
    
    public int getLongitud() {
        return this.longitud;   
    }
}