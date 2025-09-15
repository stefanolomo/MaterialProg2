import java.util.Scanner;

public class Demo01DeclaracionVariables {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        
        boolean encontre=false;
        int miDNI =11222333, tuDNI = 10555444;char sexo, inicial='C';
        sexo = 'F';
        double miSueldo=1000.30;
        String miNombre="Pepe";
        miNombre = in.next();
        
        while (!miNombre.equals("x")) {
            System.out.println("El usuario " + miNombre + " no esta autorizado");
            System.out.println("Ingrese un nuevo nombre de usuario");
            miNombre = in.next();
        }
            
        // Imprimimos las variables
        System.out.println(miDNI);
        System.out.println(tuDNI);        
        System.out.println(sexo);
        System.out.println(miSueldo);
        System.out.println(miNombre);
    }
}
