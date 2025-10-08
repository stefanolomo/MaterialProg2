public abstract class Atencion{
    //Estado
    private int num;
    private String animal,fecha;
    private boolean tieneCalendario;
    private Duenno duenno;
    private double precio;

    //Constructores

    public Atencion(int unNum, String unAnimal, String unaFecha, 
    boolean tieneCalendario,Duenno unDuenno, double unPrecio){
        this.num = unNum;
        this.animal = unAnimal;
        this.fecha = unaFecha;
        this.tieneCalendario = tieneCalendario;
        this.duenno = unDuenno;
        this.precio = unPrecio;
    }

    // Getters y Setters

    public void setNum (int num) {this.num = num;};

    public void setPrecio (double precio) {this.precio = precio;};

    public void setAnimal (String animal) {this.animal = animal;};

    public void setFecha (String fecha) {this.fecha = fecha;};

    public void setCalendario (boolean tieneCalendario) {this.tieneCalendario = tieneCalendario;};

    public void setDuenno (Duenno duenno) {this.duenno = duenno;};

    public boolean getTieneCalendario () {return this.tieneCalendario;};

    public double getPrecio () {return this.precio;};

    public String getFecha() {return this.fecha;};

    //Metodos
    public double calcularPrecioComun(){
        double precio=this.calcularPrecioAtencion();
        if (!tieneCalendario){
            precio = precio*1.1;
        }
        if (duenno.getMetodoPago().equals("Efectivo")){
            precio = precio*0.88;
        }
        if (duenno.getMetodoPago().equals("Credito")){
            precio = precio*1.05;
        }
        return precio;
    }

    public String imprimirAtencion(){
        String atencionImpresa = "";

        // private int num;
        // private String animal,fecha;
        // private boolean tieneCalendario;
        // private Duenno duenno;
        // private double precio;        

        atencionImpresa = atencionImpresa + "Numero de atencion: " + this.num + "\n";
        
        atencionImpresa = atencionImpresa + "Fecha: " + this.fecha + "\n";
        
        atencionImpresa = atencionImpresa + "Tipo de animal: " + this.animal + "\n";
        
        String tiene = "No";
        if (getTieneCalendario()) {tiene = "Si";}
        
        atencionImpresa = atencionImpresa + "Tiene el calendario completo: " + tiene + "\n";
        
        atencionImpresa = atencionImpresa + "Precio final de la atencion: " + this.calcularPrecioComun() + "\n";
        
        atencionImpresa = atencionImpresa + "[Datos del dueño]" + "\n";
        
        atencionImpresa = atencionImpresa + duenno.imprimirDatos() + "\n";

        return (atencionImpresa);
    }

    public abstract double calcularPrecioAtencion ();

    public abstract String imprimirEspecifico();    
}