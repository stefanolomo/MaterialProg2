import java.util.*;

public class ProgramaArba {

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        Vehiculo[] vehiculos = new Vehiculo[10000];
        int cantidad = 0;
        int opcion;

        System.out.println("=== SISTEMA DE IMPUESTOS ARBA ===");

        do {
            System.out.println("\nSeleccione el tipo de vehículo a cargar:");
            System.out.println("1 - Automotor");
            System.out.println("2 - Embarcación");
            System.out.println("0 - Salir y calcular impuestos");
            System.out.print("Opción: ");
            opcion = in.nextInt();

            if (opcion == 1 && cantidad < 10000) {
                vehiculos[cantidad] = leerAutomotor(in);
                cantidad++;
            } else if (opcion == 2 && cantidad < 10000) {
                vehiculos[cantidad] = leerEmbarcacion(in);
                cantidad++;
            } else if (opcion != 0 && cantidad >= 10000) {
                System.out.println("Se alcanzó el máximo de vehículos (10000).");
            }
        } while (opcion != 0);

        System.out.println("\n=== CÁLCULO DE IMPUESTOS ===");
        for (int i = 0; i < cantidad; i++) {
            Vehiculo v = vehiculos[i];
            double impuesto = v.calcularImpuesto();
            System.out.println("------------------------------");
            System.out.println("Propietario: " + v.getPropietario().getNombre() + " " + v.getPropietario().getApellido());
            System.out.println("Tipo de vehículo: " + v.getClass().getSimpleName());
            System.out.println("Impuesto a pagar: $" + impuesto);
        }

        System.out.println("\nFin del programa.");
        in.close();
    }


    public static Propietario leerPropietario(Scanner in) {
        System.out.print("Ingrese CIT: ");
        int cit = in.nextInt();
        in.nextLine();
        System.out.print("Ingrese nombre: ");
        String nombre = in.nextLine();
        System.out.print("Ingrese apellido: ");
        String apellido = in.nextLine();

        return new Propietario(nombre, apellido, cit);
    }

    public static Automotor leerAutomotor(Scanner in) {
        System.out.println("\n--- Datos Automotor ---");
        Propietario p = leerPropietario(in);

        System.out.print("Año de fabricación: ");
        int año = in.nextInt();
        System.out.print("Importe básico: ");
        double importe = in.nextDouble();
        in.nextLine(); // limpiar buffer
        System.out.print("Patente: ");
        String patente = in.nextLine();
        System.out.print("Importe adicional: ");
        double adicional = in.nextDouble();
        in.nextLine();
        System.out.print("Descripción: ");
        String descripcion = in.nextLine();

        return new Automotor(año, importe, p, patente, adicional, descripcion);
    }

    public static Embarcacion leerEmbarcacion(Scanner in) {
        System.out.println("\n--- Datos Embarcación ---");
        Propietario p = leerPropietario(in);

        System.out.print("Año de fabricación: ");
        int año = in.nextInt();
        System.out.print("Importe básico: ");
        double importe = in.nextDouble();
        System.out.print("Código REY: ");
        int rey = in.nextInt();
        in.nextLine();
        System.out.print("Nombre de la embarcación: ");
        String nombre = in.nextLine();
        System.out.print("Tipo de embarcación: ");
        String tipo = in.nextLine();
        System.out.print("Eslora (m): ");
        double eslora = in.nextDouble();
        System.out.print("Peso (toneladas): ");
        double peso = in.nextDouble();
        System.out.print("Valor declarado ($): ");
        double valor = in.nextDouble();

        return new Embarcacion(año, importe, p, rey, nombre, tipo, eslora, peso, valor);
    }
}
