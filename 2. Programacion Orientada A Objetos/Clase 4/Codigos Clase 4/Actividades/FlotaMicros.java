public class FlotaMicros {

    /*

    4-a) Definir una clase para representar flotas de micros. Una flota se caracteriza por conocer a
    los micros que la componen (a lo sumo 15).
    i. Defina un constructor para crear una flota vacía (sin micros)

    Implemente métodos para:

    ii. devolver si la flota está completa (tiene 15 micros) o no. [x]
    iii. agregar a la flota un micro recibido como parámetro. [x]
    iv. eliminar de la flota el micro con patente igual a una recibida como parámetro. [x]
    v. buscar en la flota un micro con patente igual a una recibida como parámetro y
    retornarlo (en caso de no existir dicho micro, retornar NULL). [x]
    vi. buscar en la flota un micro con destino igual a uno recibido como parámetro y
    retornarlo (en caso de no existir dicho micro, retornar NULL). [x]
     */

    // |          Variables de estado          |

    private Micro[] microsDeFlota;
    private int cantidadDeMicros;

    // |          Metodos          |
    
    public boolean eliminarPorPatente(String patente) {
        Micro buscado = buscarPorPatente(patente);
        
        if (buscado != null) {
            buscado = null;
            cantidadDeMicros--;
            
            return true;
        }
        
        return false;    
    }

    public boolean estaCompleta () {
        return (this.cantidadDeMicros == 20);
    }

    public boolean agregarMicro (Micro microAgregar) {
        if (cantidadDeMicros < 20) {
            this.microsDeFlota[cantidadDeMicros] = microAgregar;
            return true;
        }

        return false;
    }

    public Micro buscarPorPatente (String patente) {
        for (int i = 0; i < cantidadDeMicros; i++) {
            if (microsDeFlota[i] != null && microsDeFlota[i].getPatente().equals(patente)) {
                return microsDeFlota[i];                
            }
        }

        return null;
    }
    
    public Micro buscarPorDestino (String destino) {
        for (int i = 0; i < cantidadDeMicros; i++) {
            if (microsDeFlota[i].getDestino().equals(destino)) {
                return microsDeFlota[i];           
            }
        }

        return null;
    }

    // |          Constructores          |

    public FlotaMicros () {
        // Crea una flota vacia
        this.microsDeFlota = new Micro[15];
        this.cantidadDeMicros = 0;
    }

    // |          Getters y Setters          |

    public int getCantidadDeMicros() {
        return this.cantidadDeMicros;
    }
}