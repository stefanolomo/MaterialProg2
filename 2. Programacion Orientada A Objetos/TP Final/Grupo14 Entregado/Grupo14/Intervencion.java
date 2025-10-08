public class Intervencion extends Atencion {
    private int duracion;
    private boolean programada;
    private String[] medicamentos;

    public Intervencion (int unNum, String unAnimal, String unaFecha, 
    boolean tieneCalendario,Duenno unDuenno, double unPrecio, int duracion, boolean programada, String[] medicamentos) {
        super(unNum, unAnimal, unaFecha, tieneCalendario,unDuenno, unPrecio);
        this.duracion = duracion;
        this.programada = programada;
        this.medicamentos = medicamentos;
    }

    public double calcularPrecioAtencion(){
        double precio=0,precioBase = super.getPrecio();
        String fecha = super.getFecha();
        if (programada == false) {
            precio = precioBase *1.15;
            if (fecha.equals("02/04/2025") || fecha.equals("17/06/2025") || fecha.equals("20/06/2025") || fecha.equals("09/07/2025")) {
                precio = precio + 10000;
            };
        }
        int cantMed = this.contarMed();
        if (cantMed>5){
            precio = precio + 20000;
        }
        return precio;
    }

    public int contarMed(){
        int i=0;
        while (i<10 && medicamentos[i] != null) {
            i++;
        }        
        return i;
    }
    
    public String leerMedicamentosEnString() {
        String medicamentosLeidos = "";
        
        int i=0;
        while (i<10 && medicamentos[i] != null) {
            medicamentosLeidos = "\n" + medicamentosLeidos + medicamentos[i];
            
            i++;
        }
        
        return medicamentosLeidos;
    };
    
    public String imprimirEspecifico(){
        String tiene = "No";
        if (programada) {tiene = "Si";}
        
        return(super.imprimirAtencion()+" Duracion: " + this.duracion + " Fue programada: " + tiene + " Medicamentos usados: " + leerMedicamentosEnString());
    }
}