
public class Circulo extends Figura{
    
    private double radio;
 
    
       /* AÑADIDO TEMA 4 */
    public Circulo(double nuevoRadio, String nuevoCR, String nuevoCL, Punto unPunto){
        super(nuevoCR,nuevoCL,unPunto);
        radio= nuevoRadio;   
    } 
    
    
    public double getRadio(){
        return radio;       
    }
  
    public void setRadio(double nuevoRadio){
        radio=nuevoRadio;
    }
  
    public double calcularArea(){
       return (Math.PI*radio*radio);
    }
    
    public double calcularPerimetro(){
       return (2*Math.PI*radio);
    }
    
    public String dibujar(){
        String resul= "Circulo: ";
        resul=resul+super.dibujar();
        resul=resul+"Radio: " + radio;
        return resul;
    }

}
