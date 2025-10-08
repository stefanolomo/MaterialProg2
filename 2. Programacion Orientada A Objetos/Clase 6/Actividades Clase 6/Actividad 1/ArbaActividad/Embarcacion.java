public class Embarcacion extends Vehiculo{
    private int rey;
    private String nombre;
    private String tipo;
    private double eslora;
    private double peso;
    private double valor;
    
    public Embarcacion(){
    
    }
    
    public Embarcacion(int año,double importe, Propietario propietario, int rey,
    String nombre,String tipo,double eslora,double peso,double valor){
        super(año,importe,propietario);
        this.rey = rey;
        this.nombre = nombre;
        this.tipo = tipo;
        this.eslora = eslora;
        this.peso = peso;
        this.valor = valor;
    }
    
    public int getRey(){
        return rey;
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public String getTipo(){
        return tipo;
    }
    
    public double getEslora(){
        return eslora;
    }
    
    public double getPeso(){
        return peso;
    }
    
    public double getValor(){
        return valor;
    }
    
    public void setRey(int rey){
        this.rey = rey;
    }
    
    public void setNombre(String nombre){
        this.nombre = nombre;
    }
    
    public void setTipo(String tipo){
        this.tipo = tipo;
    }
    
    public void setEslora(double eslora){
        this.eslora = eslora;
    }
    
    public void setPeso(double peso){
        this.peso = peso;
    }
    
    public void setValor(double valor){
        this.valor = valor;
    }
    
    public double calcularImpuesto(){
        double impuesto = this.valor/100;
        if (this.valor<=6000){
            impuesto = impuesto * 4;
        }
        if ((this.valor>=6000)&&(this.valor<=180000)){
            impuesto = impuesto * 2;
        }
        if (this.valor>=180000){
            impuesto = impuesto * 5;
        }
        return impuesto;
    }
}