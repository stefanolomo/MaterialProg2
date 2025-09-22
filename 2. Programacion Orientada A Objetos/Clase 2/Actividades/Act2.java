import java.util.Scanner;

/**
 * Write a description of class Act2 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Act2
{
    public static void main(String[] args){
        Persona [] vPersonas = new Persona[5];

        int i;
        for (i = 0; i <= 4; i++) {
            vPersonas[i] = leerPersona();
        }

        int may60;

        may60 = cantMay60(vPersonas);
        System.out.println("La cantidad de personas con edad mayor a 60 es: " + may60);

        String toStrMenor;
        toStrMenor = menEdad(vPersonas);
        System.out.println("La persona con menor DNI ingresada es la siguiente: " + toStrMenor);
        
        // vPersona[i]=leerPersona;
    }

    public static int cantMay60(Persona[] vector) {
        int cant = 0;
        int i;

        for (i = 0; i <= 4; i++) {
            if (vector[i].getEdad() >= 60) {
                cant++;
            }
        }

        return cant;
    }

    public static String menEdad(Persona[] vector) {
        int minEdad = 9999; int i;
        String toStr = "";

        for (i = 0; i <= 4; i++) {
            if (vector[i].getEdad() < minEdad) {
                minEdad = vector[i].getDNI();
                toStr = vector[i].toString();
            }
        }
        
        return toStr;
    }

    public static Persona leerPersona(){
        Scanner in = new Scanner(System.in);

        Persona p1 = new Persona();

        System.out.println("Ingrese el DNI de la persona");
        p1.setDNI(in.nextInt());

        System.out.println("Ingrese la edad de la persona");
        p1.setEdad(in.nextInt());

        System.out.println("Ingrese el nombre de la persona");
        p1.setNombre(in.next());

        return p1;
    }
}
