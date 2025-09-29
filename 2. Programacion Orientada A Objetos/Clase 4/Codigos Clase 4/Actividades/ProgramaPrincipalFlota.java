import java.util.Scanner;

public class ProgramaPrincipalFlota {
    /*
     * b) Genere un programa que cree una flota vacía. Cargue micros (sin pasajeros) a la flota con
    información leída desde teclado (hasta que se ingresa la patente “ZZZ000” o hasta completar la
    flota).

    Luego lea una patente, busque si existe un micro con dicha patente y en ese caso
    elimínelo de la flota. Lea un destino e informe la patente del micro que va a dicho destino y su
    hora de salida.
     * 
     */

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);

        FlotaMicros flotaPrincipal = new FlotaMicros(); 

        cargarFlota(flotaPrincipal, in);
    }

    public static void cargarFlota(FlotaMicros flota, Scanner in) {
        Micro microAgregar;
        String patente = "";

        while (!patente.equals("ZZZ000") && !flota.estaCompleta()) {
            System.out.print("Ingrese la patente: ");
            patente = in.next();

            if (!patente.equals("ZZZ000")){
                in.nextLine();
                System.out.print("Ingrese el destino: ");
                String destino = in.nextLine();

                System.out.print("Ingrese la hora de salida (formato 24hs, ej: 22): ");
                int hora = in.nextInt();

                microAgregar = new Micro(patente, destino, hora);

                System.out.println("El micro hacia " + destino + ", con patente " + patente + ", y hora de salida " + hora + "hs fue agregado a la lista de micros disponibles");

                flota.agregarMicro(microAgregar);
            }
        }
    }
}