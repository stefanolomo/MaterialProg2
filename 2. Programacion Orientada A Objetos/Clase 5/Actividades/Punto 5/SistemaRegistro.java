public abstract class SistemaRegistro {
    // |          Variables de estado          |

    protected EstacionMeteorologica estacion;
    protected int inicio;
    protected int registrar;
    protected double[][] temperaturas;

    // |          Constructores          |

    public SistemaRegistro () {}

    public SistemaRegistro (EstacionMeteorologica estacion, int inicio, int registrar) {
        this.estacion = estacion;
        this.inicio = inicio;
        this.registrar = registrar;

        this.temperaturas = new double[registrar][12];
        for (int i = 0; i < registrar; i++) {
            for (int j = 0; j < 12; j++) {
                this.temperaturas[i][j] = 9999.0; // Valor "muy alto"
            }
        }
    }

    // |          Getters y Setters          |

    public int getInicio () {return this.inicio;};

    public int getRegistrar () {return this.registrar;};

    public EstacionMeteorologica getEstacion() {return this.estacion;};

    public void setTemperatura(int month, int year, double temperatura){
        if ((month <= 12 && month >= 1 ) && (year <= this.getRegistrar() && year >= this.getInicio())) {
            this.temperaturas[year - this.inicio][month - 1] = temperatura;
        }
    };

    public double getTemperatura(int month, int year) {
        return this.temperaturas[year - this.inicio][month - 1];
    };

    public abstract String getReporte();
}