public class Tratamiento extends Atencion {
    private String descripcion;
    private int sintomatologia;

    public Tratamiento (int unNum, String unAnimal, String unaFecha, 
    boolean tieneCalendario,Duenno unDuenno, double unPrecio, String descripcion, int sintomatologia) {
        super(unNum, unAnimal, unaFecha, tieneCalendario,unDuenno, unPrecio);
        this.descripcion  = descripcion;
        this.sintomatologia = sintomatologia;
    }

    public double calcularPrecioAtencion(){
        double precio=super.getPrecio();
        if (sintomatologia>6){
            precio = precio * 1.075;
        }
        else if (sintomatologia>3){
            precio = precio * 1.05;
        }
        return precio;
    }
    
    public String imprimirEspecifico() {
        return(super.imprimirAtencion()+" Descripcion: " + this.descripcion + " \n Cantidad de sintomas: " + this.sintomatologia + "\n");
    };
}