public abstract class Ejemplar {
    private int codigo, cantPag, annioPublicacion;
    private Persona responsable;
    private String resumen;

    public Persona getResponsable () {return this.responsable;};

    public String getResumen () {return this.resumen;};

    public int getCodigo () {return this.codigo;};

    public int getCantPag () {return this.cantPag;};

    public int getAnnioPublicacion () {return this.annioPublicacion;};
    
    public void setAnnioPublicacion (int annioPublicacion) {this.annioPublicacion = annioPublicacion;};
    
    public abstract void publicar();

    public abstract String getDatos();

    public Ejemplar (int codigo, int cantPag, String resumen, Persona responsable) {
        this.responsable = responsable;
        this.resumen = resumen;
        this.codigo = codigo;
        this.cantPag = cantPag;
        this.annioPublicacion = 0;
    }
}