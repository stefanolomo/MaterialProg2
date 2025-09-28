import java.util.Scanner;

public class Micro {

    /*

    3) Definir una clase para representar micros. Un micro se c.aracteriza por su patente, destino,
    hora salida, una cantidad de asientos fija (20) para los que debe registrar su estado (es decir si
    está o no ocupado) y cantidad de asientos ocupados. El micro puede ocuparse total o
    parcialmente.

    a) Defina métodos getters/setters para patente, destino y hora de salida.

    b) Implemente un constructor que permita inicializar el micro creado con una patente, un
    destino y una hora de salida (recibidas como parámetro) y sin pasajeros.

    c) Implemente métodos para:
    i. devolver la cantidad de asientos ocupados [x]
    ii. devolver si el micro está lleno [x] 
    iii. validar un número de asiento recibido como parámetro [x]
    iv. devolver el estado de un nro. de asiento válido recibido como parámetro [x]
    v. ocupar un nro. de asiento válido recibido como parámetro [x]
    vi. liberar un nro. de asiento válido recibido como parámetro [x]
    vii. devolver el nro. del primer asiento libre [x]

     */

    private int asientosTotales, asientosOcupados, horaDeSalida;
    private String destino, patente;
    private boolean [] estadoAsientos;
    // |           Getters y setters          |

    public void setPatente (String patente) {this.patente = patente;}

    public void setDestino (String destino) {this.destino = destino;}

    public void setHoraDeSalida(int horaDeSalida) {this.horaDeSalida = horaDeSalida;}
    
    public String getPatente () {return this.patente;}
    
    public String getDestino () {return this.destino;}
    
    public int getHoraDeSalida() {return this.horaDeSalida;}

    // |          Constructores          |
    
    public Micro (String patente, String destino, int horaDeSalida) {
        // Constructor sin pasajeros
        this.estadoAsientos = new boolean [20];

        this.patente = patente;
        this.destino = destino;
        this.horaDeSalida = horaDeSalida;
        this.asientosTotales = 20;
        this.asientosOcupados = 0;
        inicializarEstadoAsientos(this.estadoAsientos);
    }

    public Micro () {
        // Constructor nulo
    }

    public static boolean[] inicializarEstadoAsientos(boolean[] asientos) {
        int i;

        for (i = 0; i < asientos.length; i++) {
            asientos[i] = false;
        }

        return asientos;
    }
}