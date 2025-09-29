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

    // |          Metodos          |

    public int primerDesocupado () {
        for (int i = 0; i < this.estadoAsientos.length; i++) {
            if (this.estadoAsientos[i] == false) {
                return (i);
            }
        }
        return (-1);
    }

    public int cantidadDeOcupados () {
        return this.asientosOcupados;
    }

    public boolean estaLleno () {
        return (this.cantidadDeOcupados() == this.asientosTotales);
    }

    public boolean esAsientoValido (int asiento) {
        return ((asiento < this.asientosTotales) && (asiento >= 0));
    }

    public boolean estadoAsientoValido (int asiento) {
        if (this.esAsientoValido(asiento)) {
            return (this.estadoAsientos[asiento]);
        }
        return false;
    }

    public boolean ocuparAsiento(int asiento) {
        if (this.esAsientoValido(asiento) && !this.estadoAsientos[asiento]) {
            this.estadoAsientos[asiento] = true;
            this.asientosOcupados++;
            return true;
        }
        return false;
    }

    public boolean liberarAsiento(int asiento) {
        if (this.esAsientoValido(asiento) && this.estadoAsientos[asiento]) {
            this.estadoAsientos[asiento] = false;
            this.asientosOcupados--;
            return true;
        }
        return false;
    }

    public boolean modificarAsiento (int asientoAOcupar, boolean modificacion) {
        if (modificacion) {
            return this.ocuparAsiento(asientoAOcupar);
        } else {
            return this.liberarAsiento(asientoAOcupar);
        }
    }

    public static Micro leerMicro(Scanner in) {
        Micro microCreado;

        System.out.println("\n--- Asistente de Creación de Micros ---");
        System.out.println("¿Cómo desea crear el micro?");
        
        System.out.println("  1. Nuevo para un viaje (vacío)");
        System.out.println("  2. Cargar desde un estado existente (full)");
        System.out.println("  Cualquier otro número: Crear micro por defecto (nulo)");
        
        System.out.print("Seleccione una opción: ");
        int opcion = in.nextInt();

        if (opcion == 1) {
            System.out.print("Ingrese la patente: ");
            String patente = in.next();
            
            in.nextLine();
            System.out.print("Ingrese el destino: ");
            String destino = in.nextLine();
            
            System.out.print("Ingrese la hora de salida (formato 24hs, ej: 22): ");
            
            int hora = in.nextInt();
            microCreado = new Micro(patente, destino, hora);
        } else if (opcion == 2) {
            System.out.print("Ingrese la patente: ");
            String patente = in.next();
            
            in.nextLine();
            System.out.print("Ingrese el destino: ");
            String destino = in.nextLine();
            
            System.out.print("Ingrese la hora de salida: ");
            int hora = in.nextInt();
            
            boolean[] estadoAsientos = leerEstadoDeAsientos(in);
            microCreado = new Micro(patente, destino, hora, estadoAsientos);
        } else {
            System.out.println("Opción no válida. Se creará un micro por defecto.");
            microCreado = new Micro();
        }

        return microCreado;
    }

    public static boolean[] leerEstadoDeAsientos(Scanner in) {
        boolean[] asientos = new boolean[20];
        System.out.println("--- Carga del estado de los asientos ---");
        for (int i = 0; i < asientos.length; i++) {
            System.out.print("El asiento " + (i + 1) + " esta ocupado? [1: Si, 2: No]: ");
            asientos[i] = (in.nextInt() == 1);
        }
        return asientos;
    }

    public void cargarEstadoAsientos(Scanner in) {
        for (int i = 0; i < this.estadoAsientos.length; i++) {
            System.out.println("El asiento " + (i + 1) + " esta ocupado? [1: Si, 2: No]: ");
            this.estadoAsientos[i] = (in.nextInt() == 1) ;
        }
        this.asientosOcupados = this.recalcularOcupados();
    }

    private int recalcularOcupados() {
        int contador = 0;
        for (int i = 0; i < this.estadoAsientos.length; i++) {
            if (this.estadoAsientos[i]) {
                contador++;
            }
        }
        return contador;
    }

    // |          Getters y Setters          |

    public void setPatente (String patente) {this.patente = patente;}

    public void setDestino (String destino) {this.destino = destino;}

    public void setHoraDeSalida(int horaDeSalida) {this.horaDeSalida = horaDeSalida;}

    public String getPatente () {return this.patente;}

    public String getDestino () {return this.destino;}

    public int getHoraDeSalida() {return this.horaDeSalida;}

    // |          Constructores          |

    public Micro (String patente, String destino, int horaDeSalida) {
        this.estadoAsientos = new boolean [20];
        this.patente = patente;
        this.destino = destino;
        this.horaDeSalida = horaDeSalida;
        this.asientosTotales = 20;
        this.asientosOcupados = 0;
    }

    public Micro (String patente, String destino, int horaDeSalida, boolean[] estadoAsientos) {
        this.patente = patente;
        this.destino = destino;
        this.horaDeSalida = horaDeSalida;
        this.estadoAsientos = estadoAsientos; 
        this.asientosTotales = 20;
        this.asientosOcupados = this.recalcularOcupados();
    }

    public Micro () {
        this.estadoAsientos = new boolean[20];
        this.asientosTotales = 20;
        this.asientosOcupados = 0;
    }
}