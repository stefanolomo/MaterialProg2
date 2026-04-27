import java.util.Scanner;

public class Actividad4 {
    public static void main(String[] args) {        
        for (int i = 1; i <= 9; i++) {
            int factorial = 1;
            if (i % 2 == 0) { // Imprime solo los factoriales de numeros pares
                for (int j = 1; j <= i; j++) {
                    factorial *= j;
                }

                System.out.println("El factorial de " + i + " es: " + factorial);
            }
        }
    }
}