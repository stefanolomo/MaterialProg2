public class Libro extends Ejemplar {
    private boolean esDeBolsillo;
    private int capitulos;
    private String titulo;

    public String getDatos () {
        return "El codigo identificatorio del libro es: " + super.getCodigo() + ". El titulo del libro es: " + this.titulo + ". El nombre del responsable es: " + super.getResponsable().getNombre() + ". \n";
    };

    public String getTitulo () {return this.titulo;};

    public int getCapitulos () {return this.capitulos;};

    public boolean getEsDeBolsillo () {return this.esDeBolsillo;};

    public void publicar () {
        if (getAnnioPublicacion() == 0) {
            this.setAnnioPublicacion(2025);
            if (this.esDeBolsillo) {
                this.titulo = this.titulo + " - De Bolsillo";
            }
        }
    };

    public Libro (int codigo, int cantPag, String resumen, Persona responsable, boolean esDeBolsillo, int capitulos, String titulo) {        
        // Constructor de libro no publicado
        super(codigo, cantPag, resumen, responsable);
        this.esDeBolsillo = esDeBolsillo;
        this.capitulos = capitulos;
        this.titulo = titulo;
    }
}