public class Jugador extends Empleado {
    // |          Variables de estado          |

    int partidosJugados, golesAnotados;

    // |          Getters y Setters          |

    public int getPartidosJugados() {return this.partidosJugados;};

    public int getGolesAnotados() {return this.golesAnotados;};

    public void setPartidosJugados(int partidosJugados) {this.partidosJugados = partidosJugados;};

    public void setGolesAnotados(int golesAnotados) {this.golesAnotados = golesAnotados;};

    // |          Constructores          |

    public Jugador (String nombre, int dni, int sueldoBasico, int partidosJugados, int golesAnotados) {
        super(nombre, dni, sueldoBasico);
        this.partidosJugados = partidosJugados;
        this.golesAnotados = golesAnotados;
    }

    public Jugador () {};

    // |          Metodos          |

    public int getSueldoCobrar () {
        // Para los jugadores: el sueldo a cobrar es el sueldo básico y si el promedio de
        // goles por partido es superior a 0,5 se adiciona un plus de otro sueldo básico.
        int sueldoCobrar = this.getSueldoBasico();

        if (this.golesPromedioPorPartido() >= 0.5) {sueldoCobrar = 2 * sueldoCobrar;};        

        return sueldoCobrar;
    }

    public double golesPromedioPorPartido() {
        return ((double) golesAnotados / partidosJugados);
    }
}