import java.util.Scanner;

public class Act2 {    
    public static void main(String[] args) {
        Scanner scnn = new Scanner(System.in);
        
        int patenteAct = 1;
        
        while (patenteAct != 0) {
            System.out.println("Ingrese el numero de la patente: ");
            patenteAct = scnn.nextInt();
            
            if (((patenteAct % 2) == 0) && (patenteAct != 0)) {
                System.out.println("La patente tiene permitido el acceso");   
            } else if (patenteAct != 0) {
                System.out.println("La patente NO tiene permitido el acceso");
            }
        }
    }
}