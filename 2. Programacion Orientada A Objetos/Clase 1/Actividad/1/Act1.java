import java.util.Scanner;
/**
 * Write a description of class Programa here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class Act1
{
    /**
     * Método main
     *
     */
    public static void main(String[] args)
    {
        Scanner in = new Scanner(System.in);

        double a, b, c;
        boolean pasa;

        System.out.println("Ingrese el lado A del triangulo");
        a = in.nextDouble();
        System.out.println("Ingrese el lado B del triangulo");
        b = in.nextDouble();
        System.out.println("Ingrese el lado C del triangulo");
        c = in.nextDouble();

        pasa = (a < b + c) && (b < a + c) && (c < a + b);

        if (pasa) {
            double perimetro = a + b + c;
            System.out.println("El triangulo es valido. Su perimetro es: " + perimetro + " unidades." );
        }

        // No se lee mas
        in.close();
    }
}
