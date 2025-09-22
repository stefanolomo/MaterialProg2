import java.util.Scanner;
/**
 * Write a description of class Act1 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Act1 {
    public static void main(String[] args){
        Scanner in = new Scanner(System.in);
        
        Persona p1 = new Persona();
        
        System.out.println("Ingrese el DNI de la persona");
        p1.setDNI(in.nextInt());
        
        System.out.println("Ingrese la edad de la persona");
        p1.setEdad(in.nextInt());
        
        System.out.println("Ingrese el nombre de la persona");
        p1.setNombre(in.next());
        
        
        
        System.out.println(p1.toString());
    }
}
