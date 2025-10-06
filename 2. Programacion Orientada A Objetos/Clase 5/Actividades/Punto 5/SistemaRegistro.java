public abstract class SistemaRegistro {
    // |          Variables de estado          |
    
    private EstacionMeteorologica estacion;
    private int inicio, registrar;
    
    // |          Constructores          |
    
    public SistemaRegistro () {}
    
    public SistemaRegistro (EstacionMeteorologica estacion, int inicio, int registrar) {
        this.estacion = estacion;
        this.inicio = inicio;
        this.registrar = registrar;
    }
    
    // |          Getters y Setters          |
    
    public int getInicio () {return this.inicio;};
    
    public int getRegistrar () {return this.registrar;};
    
    public abstract void setTemperatura(int mes, int anio, double temperatura);

    public abstract double getTemperatura(int mes, int anio);

    public abstract String getReporte();
}