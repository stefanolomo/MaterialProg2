import java.util.Scanner;
/**
 * Write a description of class Programa here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Ej05Jugadores
{
    /**
     * Método main
     * 
     */
    public static void main(String[] args)
    {
        double [] vAlturas;
        vAlturas = new double[15];
        double suma = 0;
        double outliers = 0;
        double promedio;
        
        Scanner in = new Scanner(System.in);
        
        for (int i = 0; i < 14; i++) {
            System.out.println("Ingrese la altura del jugador " + (i+1));
            vAlturas[i] = in.nextDouble();
        }
        
        //  Sumar todas las alturas.
        //  Dividir por 15.
        
        for (int i = 0; i < 14; i++) {
            suma = suma + vAlturas[i];
        }
        promedio = suma / 15.0;
        
        //  Recorrer el vector
        //  Para cada numero mayor al promedio, sumar 1 al total
        for (int i = 0; i < 14; i++) {
            if (vAlturas[i] > promedio) {
                outliers = outliers + 1;
            }
        }
        
        System.out.println("La altura promedio es: " + promedio + " y la cantidad de outliers es: " + outliers);
        
        // No se lee mas
        in.close();
    }
}