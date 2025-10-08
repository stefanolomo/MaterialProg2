public class SistemaRegistroMonthly extends SistemaRegistro {
    // Variables de estado
    
    private double[][] temperaturas;
    
    // Constructores
    
    public SistemaRegistroMonthly () {}
    
    public SistemaRegistroMonthly (EstacionMeteorologica estacion, int inicio, int registrar) {
        super(estacion, inicio, registrar);
        temperaturas = new double[registrar][12];
    }
    
    // Getters y Setters
    
    public double getPromedioMonthly(int month) {
        double suma = 0;
        
        for (int i = 0; i < super.getRegistrar(); i++) {
            suma = suma + temperaturas[i][month];
        }
        
        return (double) suma / super.getRegistrar();
    };
    
    public String getReporte() {
        String informe = "";
        
        for (int i = 0; i < 12; i++) {           
            informe = informe + "\n Para el mes " + (i+1) + " el promedio es: " + this.getPromedioMonthly(i+1);
        }
        
        return informe;
    };
}