public class Revista extends Ejemplar {
    private int volumen, articulos;
    private String titulo;
    private Generador generador = new Generador();

    public int getVolumen () {return this.volumen;};
    
    public String getTitulo () {return this.titulo;};
    
    public int getArticulos () {return this.articulos;};    
    
    public void publicar () {
        this.volumen = generador.getNroVolumen();
        if (getAnnioPublicacion() == 0) {
            this.setAnnioPublicacion(2025);
            this.titulo = this.titulo + " - Volumen " + this.volumen;
        }
    };

    public String getDatos () {
        return "El nombre de la revista es: " + this.titulo + ". El volumen es: " + this.volumen;
    };

    public Revista (int codigo, int cantPag, String resumen, Persona responsable, int volumen, int articulos, String titulo) {        
        // Constructor de revista no publicada
        super(codigo, cantPag, resumen, responsable);
        this.articulos = articulos;
        this.titulo = titulo;
    }
}