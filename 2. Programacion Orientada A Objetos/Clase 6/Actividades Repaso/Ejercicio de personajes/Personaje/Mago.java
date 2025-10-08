public class Mago extends Personaje{
    private double poderMagico;

    public Mago(){

    }

    public Mago(String unNombre,int unNivel, int unaVida, double unPoder){
        super(unNombre,unNivel,unaVida);
        this.poderMagico = unPoder;
    }

    public double getPoder(){
        return poderMagico;
    }

    public void setPoder(double unPoder){
        this.poderMagico= unPoder;
    }
    
    public double Habilidad(){
        return(1.5*poderMagico);
    }
    
    @Override
    public String toString(){
        return (super.toString()+ "\n Poder Magico: "+ poderMagico + "]");
    }
}