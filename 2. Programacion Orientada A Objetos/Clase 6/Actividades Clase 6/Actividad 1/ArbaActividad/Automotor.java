public class Automotor extends Vehiculo{
    private String patente;
    private double importeAdicional;
    private String descripcion;

    public Automotor(){

    }

    public Automotor(int año,double importe, Propietario propietario, String patente,
    double importeAdicional, String descripcion){
        super(año,importe,propietario);
        this.patente = patente;
        this.importeAdicional = importeAdicional;
        this.descripcion = descripcion;
    }

    public double getImporteAdicional(){
        return importeAdicional;
    }

    public String getPatente(){
        return patente;
    }

    public String getDescripcion(){
        return descripcion;
    }

    public void setImporteAdicional(double importe){
        this.importeAdicional = importe;
    }

    public void setPatente(String patente){
        this.patente = patente;
    }

    public void setDescripcion(String descripcion){
        this.descripcion = descripcion;
    }

    public double calcularImpuesto(){
        double impuesto = super.getImporte() + importeAdicional;
        return impuesto;
    }
}
