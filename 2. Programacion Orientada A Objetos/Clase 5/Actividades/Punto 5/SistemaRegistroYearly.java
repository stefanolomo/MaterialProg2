public class SistemaRegistroYearly extends SistemaRegistro {
    // Constructores
    
    public SistemaRegistroYearly () {}
    
    public SistemaRegistroYearly (EstacionMeteorologica estacion, int inicio, int registrar) {
        super(estacion, inicio, registrar);
        temperaturas = new double[registrar][12];
    }
    
    // Getters y Setters
    
    public double getPromedioYearly(int year) {
        double suma = 0;
        
        for (int i = 0; i < 12; i++) {
            suma = suma + temperaturas[year][i];
        }
        
        return suma / 12.0;   
    };
    
    public String getReporte() {
        String informe = "";
        
        for (int i = 0; i < super.getRegistrar(); i++) {           
            informe = informe + "\n Para el año " + (i+1) + " el promedio es: " + this.getPromedioYearly(i+1);
        }
        
        return informe;
    };
}