import java.util.Scanner;

public class PPJugadorYEntrenador {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        
        Entrenador Scaloni = leerEntrenador(in);
        in.nextLine();
        Jugador Paredes = leerJugador(in);
        
        // Empleado E1 = Entrenador(, int dni, int sueldoBasico, int campeonatosGanados);
    }
    
    public static Jugador leerJugador(Scanner in) {
        String nombre;
        int dni, sueldoBasico, golesAnotados, partidosJugados;
        
        System.out.println("Ingrese el nombre del jugador");
        nombre = in.next();
        
        System.out.println("Ingrese el dni de " + nombre);
        dni = in.nextInt();
        
        System.out.println("Ingrese el sueldo basico de " + nombre);
        sueldoBasico = in.nextInt();
        
        System.out.println("Ingrese los partidos jugados de " + nombre);
        partidosJugados = in.nextInt();
        
        System.out.println("Ingrese los goles anotados de " + nombre);
        golesAnotados = in.nextInt();
        
        Jugador EmpleadoLeido = new Jugador(nombre, dni, sueldoBasico, partidosJugados, golesAnotados);
        
        return EmpleadoLeido;
    }
    
    public static Entrenador leerEntrenador(Scanner in) {
        String nombre;
        int dni, sueldoBasico, campeonatosGanados;
        
        System.out.println("Ingrese el nombre del entrenador");
        nombre = in.next();
        
        System.out.println("Ingrese el dni de " + nombre);
        dni = in.nextInt();
        
        System.out.println("Ingrese el sueldo basico de " + nombre);
        sueldoBasico = in.nextInt();
        
        System.out.println("Ingrese los campeonatos ganados de " + nombre);
        campeonatosGanados = in.nextInt();
        
        Entrenador EmpleadoLeido = new Entrenador(nombre, dni, sueldoBasico, campeonatosGanados);
        
        return EmpleadoLeido;
    }
}