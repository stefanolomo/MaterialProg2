import java.util.Scanner;

public class InstanciarT {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);

        System.out.println("Con que constructor quiere instanciar el triangulo? [1: full, 2: equilatero]");
        int m = in.nextInt();

        Triangulo T = LeerTriangulo(in, m);
        
        System.out.println("A continuacion se mostraran las caracteristicas del triangulo ingresado");
        imprimirDetalles(T);

    }

    public static void imprimirDetalles(Triangulo t) {
        // Primero, una buena práctica es verificar si el objeto que nos pasaron no es nulo.
        if (t == null) {
            System.out.println("Error: No se puede imprimir un triángulo nulo.");
            return; // Salimos del método para evitar errores.
        }

        System.out.println("\n┌──────────────────────────────┐");
        System.out.println("│   Reporte del Triángulo      │");
        System.out.println("├──────────────────────────────┤");
        
        // Usamos String.format para alinear el texto y que quede prolijo.
        // %-18s significa: "inserta un String y rellena con espacios hasta 18 caracteres".
        // El signo '-' alinea a la izquierda.
        System.out.printf("│ Color de Línea:   %-12s │\n", t.getColorLinea());
        System.out.printf("│ Color de Relleno: %-12s │\n", t.getColorRelleno());
        
        // %.2f significa: "inserta un número de punto flotante con 2 decimales".
        System.out.printf("│ Perímetro:        %-12.2f │\n", t.getPerimetro());
        System.out.printf("│ Área:             %-12.2f │\n", t.getArea());
        
        System.out.println("└──────────────────────────────┘");
    }
    
    public static void imprimirSimple(Triangulo t) {
        if (t == null) {
            System.out.println("Error: No se puede imprimir un triángulo nulo.");
            return;
        }
        System.out.println("\n--- Datos del Triángulo ---");
        System.out.println(" - Color Línea: " + t.getColorLinea());
        System.out.println(" - Color Relleno: " + t.getColorRelleno());
        System.out.println(" - Perímetro: " + String.format("%.2f", t.getPerimetro()));
        System.out.println(" - Área: " + String.format("%.2f", t.getArea()));
    }

    
    public static Triangulo LeerTriangulo(Scanner in, int modo) {
        if (modo == 1) {
            int l1, l2, l3;
            String Relleno, Linea;

            System.out.println("Ingrese el color de linea del primer triangulo");
            Linea = in.next();

            System.out.println("Ingrese el color del relleno del primer triangulo");
            Relleno = in.next();

            System.out.println("Ingrese el largo del primer lado");
            l1 = in.nextInt();
            System.out.println("Ingrese el largo del segundo lado");
            l2 = in.nextInt();
            System.out.println("Ingrese el largo del tercer lado");
            l3 = in.nextInt();

            Triangulo T = new Triangulo(Linea, Relleno, l1, l2, l3);

            return T;
        } else if (modo == 2) {
            // El modo 2 crea triangulos equilateros
            int Lado;
            String Linea, Relleno;

            System.out.println("Ingrese el color de linea del primer triangulo");
            Linea = in.next();

            System.out.println("Ingrese el color del relleno del primer triangulo");
            Relleno = in.next();

            System.out.println("Ingrese el largo de uno de los lados");
            Lado = in.nextInt();

            Triangulo T = new Triangulo(Linea, Relleno, Lado);

            return T;
        } else {
            // Si se le paso un modo que no existe, crea con el nulo
            Triangulo T = new Triangulo();
            return T;
        }
    }
}