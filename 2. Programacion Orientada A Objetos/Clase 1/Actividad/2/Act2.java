import java.util.Scanner;

public class Act2 {    
    public static void main(String[] args) {
        Scanner scnn = new Scanner(System.in);

        int patenteAct = 1, total = 0;
        double totalPar = 0, totalImpar = 0;

        while (patenteAct != 0){
            System.out.println("Ingrese el numero de la patente: ");
            patenteAct = scnn.nextInt();

            if (((patenteAct % 2) == 0) && (patenteAct != 0)) {
                // Si es divisible por 2 (par) y no es 0
                System.out.println("La patente tiene permitido el acceso");
                totalPar++;
                total++;
            } else if (patenteAct != 0) {
                // Si no es divisible por 2 (impar) y no es 0
                System.out.println("La patente NO tiene permitido el acceso");
                totalImpar++;
                total++;
            }
        }

        System.out.println("Se procesaron un total de " + total + " autos. De ellos, el " + (double) totalPar/total * 100 + "% eran de patente par y el " + (double) totalImpar / total * 100 + "% eran de patente impar.");
    }
}