public class Entrenador extends Empleado {
    // |          Variables de estado          |
    
    int campeonatosGanados;
    
    // |          Setters y Getters          |
    
    public int getCampeonatosGanados() {return this.campeonatosGanados;};
    
    public void setCampeonatosGanados() {this.campeonatosGanados = campeonatosGanados;};
    
    // |          Contructores          |
    
    public Entrenador(String nombre, int dni, int sueldoBasico, int campeonatosGanados) {
        super(nombre, dni, sueldoBasico);
        this.campeonatosGanados = campeonatosGanados;
    }
    
    public Entrenador () {}
    
    // |          Metodos          |
    
    public int getSueldoCobrar () {
        // Para los jugadores: el sueldo a cobrar es el sueldo básico y si el promedio de
        // goles por partido es superior a 0,5 se adiciona un plus de otro sueldo básico.
        int sueldoCobrar = this.getSueldoBasico();

        if (this.campeonatosGanados > 0 && this.campeonatosGanados <= 4) {
            sueldoCobrar = sueldoCobrar + 5000;
        } else if (this.campeonatosGanados > 4 && this.campeonatosGanados <= 10) {
            sueldoCobrar = sueldoCobrar + 30000;
        } else if (this.campeonatosGanados > 10) {
            sueldoCobrar = sueldoCobrar + 50000;
        }

        return sueldoCobrar;
    }
    
    // Entrenador E1 = new Entrenador(.., .., ..);
    
    // Entrenador.setNombre("Pepe");
    // int goles = Entrenador.getCampeonatosGanados;
    
    // Empleado E1 = E1;
    
    // String NombreE1 = Entrenador.getNombre;
    // int goles = Entrenador.getCampeonatosGanados; // ERROR
}