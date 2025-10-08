public class Guerrero extends Personaje{
    private double fuerza;

    public Guerrero(){

    }

    public Guerrero(String unNombre,int unNivel, int unaVida,double unaFuerza){
        super(unNombre,unNivel,unaVida);
        this.fuerza = unaFuerza;
    }

    public double getFuerza(){
        return fuerza;
    }

    public void setFuerza(double unaFuerza){
        this.fuerza = unaFuerza;
    }

    public double Habilidad(){
        return (fuerza*2);
    }

    @Override
    public String toString(){
        return (super.toString()+ "\n Fuerza: "+ fuerza + "]");
    }
}