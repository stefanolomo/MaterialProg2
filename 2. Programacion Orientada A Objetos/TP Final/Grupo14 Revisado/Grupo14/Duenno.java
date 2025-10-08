public class Duenno{
    private String nombre,apellido,metodoPago;
    private int dni;
    
    public Duenno (String nombre,String apellido,String metodoPago,
    int dni) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.metodoPago = metodoPago;
        this.dni = dni;
    }
    
    public String imprimirDatos() {
        return "Nombre: " + this.nombre + "\n" + "Apellido: " + this.apellido + "\n" +"DNI: " + this.dni + "\n" +"Metodo de pago: " + this.metodoPago + "\n";
    };
    
    public String getNombre () {return this.nombre;};
    
    public String getApellido () {return this.apellido;};
    
    public int getDni () {return this.dni;};
    
    public String getMetodoPago () {return this.metodoPago;};
}