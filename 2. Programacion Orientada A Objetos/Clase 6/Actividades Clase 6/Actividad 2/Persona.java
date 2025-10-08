public class Persona {
    private int dni;
    private String nombre, apellido;
    
    public Persona (int dni, String nombre, String apellido) {    
        this.dni = dni;
        this.apellido = apellido;
        this.nombre = nombre;
    }
    
    public String getNombre () {return this.nombre;};
    public String getApellido () {return this.apellido;};
    public int getDni () {return this.dni;};
}