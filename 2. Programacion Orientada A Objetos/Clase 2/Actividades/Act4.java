import java.util.Scanner;

public class Act4 {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        Partido[] vPartidos = new Partido[3];

        // Leer partidos
        for (int i = 0; i < vPartidos.length; i++) {
            vPartidos[i] = leerPartido(in);
        }

        String equipoInteres;

        // Porcentaje de empates
        System.out.println("Ingrese el equipo para saber cuántos partidos empató (en % sobre partidos jugados):");
        equipoInteres = in.nextLine();
        System.out.println("El equipo " + equipoInteres + " empató el " + porcPartidosEmpatados(vPartidos, equipoInteres) + "% de los partidos que jugó.");

        // Cantidad de partidos ganados
        System.out.println("Ingrese el equipo para saber cuántos partidos ganó (en cantidad de partidos ganados):");
        equipoInteres = in.nextLine();

        System.out.println("El equipo " + equipoInteres + " ganó " + cantPartidosGanados(vPartidos, equipoInteres) + " de los partidos que jugó.");

        // Cantidad de goles metidos
        System.out.println("Ingrese el equipo para saber cuántos goles metió (en cantidad de goles metidos):");
        equipoInteres = in.nextLine();
        System.out.println("El equipo " + equipoInteres + " metió " + cantGolesMetidos(vPartidos, equipoInteres) + " goles.");
    }

    public static int cantPartidosGanados(Partido[] vector, String equipo) {
        int ganados = 0;
        for (int i = 0; i < vector.length; i++) {
            if ((vector[i].getLocal().equals(equipo) || vector[i].getVisitante().equals(equipo))
            && vector[i].getGanador().equals(equipo)) {
                ganados++;
            }
        }
        return ganados;
    }

    public static int cantGolesMetidos(Partido[] vector, String equipo) {
        int metidos = 0;
        for (int i = 0; i < vector.length; i++) {
            if (vector[i].getLocal().equals(equipo)) {
                metidos += vector[i].getGolesLocal();
            } else if (vector[i].getVisitante().equals(equipo)) {
                metidos += vector[i].getGolesVisitante();
            }
        }
        return metidos;
    }

    public static double porcPartidosEmpatados(Partido[] vector, String equipo) {
        double porc = 0; int jugados = 0; int jugadosEmp = 0;
        int i;

        for (i = 0; i <= 4; i++) {
            if ((vector[i].getLocal().equals(equipo)) | (vector[i].getVisitante().equals(equipo))) {

                jugados++; // Sumar 1 a los partidos jugados

            if (vector[i].getLocal().equals(equipo) || vector[i].getVisitante().equals(equipo)) {
                if (vector[i].hayEmpate()) {
                    // Si fue empatado, sumar 1 a los partidos empatados
                    jugadosEmp++;
                }
            }
        }

        if (jugados > 0) {
            porc = (double) jugadosEmp / jugados * 100;    
        } else {
            porc = 0;
        }

        return porc;
    }

    public static Partido leerPartido(Scanner in) {
        Partido p1 = new Partido();

        System.out.println("Ingrese el nombre del equipo local:");
        p1.setLocal(in.nextLine());

        System.out.println("Ingrese la cantidad de goles que metió el equipo local:");
        p1.setGolesLocal(in.nextInt());
        in.nextLine(); // limpiar buffer

        System.out.println("Ingrese el nombre del equipo visitante:");
        p1.setVisitante(in.nextLine());

        System.out.println("Ingrese la cantidad de goles que metio el equipo visitante: ");
        System.out.println("Ingrese la cantidad de goles que metió el equipo visitante:");
        p1.setGolesVisitante(in.nextInt());
        in.nextLine(); // limpiar buffer

        return p1;
    }
}