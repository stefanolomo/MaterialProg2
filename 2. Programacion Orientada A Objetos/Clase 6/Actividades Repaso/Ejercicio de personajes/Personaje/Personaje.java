public abstract class Personaje {

    private String nombre;
    private int nivel;
    private int vida;
    private String estado;

    public Personaje(){

    }

    public Personaje(String nombre, int nivel, int vida){
        this.nombre = nombre;
        this.nivel = nivel;
        this.vida = vida;
        this.estado = "Normal";
    }

    public Personaje(String nombre){
        this.nombre = nombre;
    }

    public String getNombre(){
        return nombre;
    }

    public int getNivel(){
        return nivel;
    }

    public int getVida(){
        return vida;
    }

    public String getEstado(){
        return estado;
    }

    public void setNombre(String unNombre){
        this.nombre = unNombre;
    }

    public void setNivel(int unNivel){
        this.nivel = unNivel;
    }

    public void setVida(int unaVida){
        this.vida = unaVida;
    }

    public void setEstado(String unEstado){
        this.estado = unEstado;
    }

    public void subirNivel(){
        this.nivel++;
        this.vida = this.vida + 10;
    }

    public int recibirDaño(int daño){
        if (estado.equals("Envenenado"))
            daño = daño + 5;
        vida=vida-daño;
        if (vida<0)
            vida = 0;
        if (vida==0)
            estado = "derrotado";
            
        return daño;
    }

    public String toString() {
        return "[Tipo: " + this.getClass().getSimpleName() +
        ", Nombre: " + nombre +
        ", Nivel: " + nivel +
        ", Vida: " + vida +
        ", Estado: " + estado ;
    }

    public abstract double Habilidad ();
}