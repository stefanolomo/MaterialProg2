public class VisorFigurasModificado {
    private int guardadas;
    private int capacidadMaxima = 5;
    private Figura [] vector;

    // Constructor

    public VisorFigurasModificado(){

    }

    // Metodos

    public void guardar(Figura f){
        if (quedaEspacio()) {
            this.vector[this.guardadas] = f;
        }
    }

    public boolean quedaEspacio(){
        return (this.guardadas < this.capacidadMaxima);
    }

    public void mostrar(Figura f){
        System.out.println(f.dibujar());
    }

    public int getGuardadas() {
        return guardadas;
    }
}