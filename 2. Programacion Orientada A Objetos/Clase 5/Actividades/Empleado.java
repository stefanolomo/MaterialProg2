public abstract class Empleado {
    // |          Variables de estado          |
    
    private String nombre;
    private int dni, sueldoBasico;
    
    // |          Getters y Setters          |
    
    public String getNombre() {return this.nombre;};
    public int getSueldoBasico() {return this.sueldoBasico;}
    public int getDni() {return this.dni;};
    
    public void setNombre(String nombre) {this.nombre = nombre;};
    public void setSueldoBasico(int sueldoBasico) {this.sueldoBasico = sueldoBasico;}
    public void setDni(int dni) {this.dni = dni;};
    
    // |          Constructores          |
    
    public Empleado(String nombre, int dni, int sueldoBasico) {
        this.nombre = nombre;
        this.dni = dni;
        this.sueldoBasico = sueldoBasico;
    }
    
    public Empleado () {}
    
    // |          Metodos          |
    
    public String toString() {
        return ("El empleado: " + this.nombre + " cobra " + this.getSueldoCobrar() + "$.");
    }
     
    public abstract int getSueldoCobrar();
}