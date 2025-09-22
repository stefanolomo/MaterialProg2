import java.util.Scanner;

/**
 * Write a description of class Act4 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Act4
{
    public static void main(String[] args){
        Scanner in = new Scanner(System.in);
        Partido [] vPartidos = new Partido[5];

        int i;
        for (i = 0; i <= 4; i++) {
            vPartidos[i] = leerPartido();
        }

        String equipoInteres;

        System.out.println("Ingrese el equipo que tiene interes saber cuantos partidos empato (en % sobre partidos jugados)");
        equipoInteres = in.nextLine();

        System.out.println("El equipo " + equipoInteres + " empato el " + porcPartidosEmpatados(vPartidos, equipoInteres) + "% de los partidos que jugo.");
    }

    public static int cantPartidosGanados(Partido[] vector, String equipo) {
        int ganados = 0;

        return ganados;
    }

    public static int cantGolesMetidos(Partido[] vector, String equipo) {
        int metidos = 0;

        return metidos;
    }

    public static double porcPartidosEmpatados(Partido[] vector, String equipo) {
        double porc = 0; int jugados = 0; int jugadosEmp = 0;
        int i;

        for (i = 0; i <= 4; i++) {
            if ((vector[i].getLocal().equals(equipo)) | (vector[i].getVisitante().equals(equipo))) {
                // Si el equipo jugo en el partido (de local o de visitante)...

                jugados++; // Sumar 1 a los partidos jugados

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

    public static Partido leerPartido(){
        Scanner in = new Scanner(System.in);

        Partido p1 = new Partido();

        System.out.println("Ingrese el nombre del equipo local: ");
        p1.setLocal(in.next());

        System.out.println("Ingrese la cantidad de goles que metio el equipo local: ");
        p1.setGolesLocal(in.nextInt());

        System.out.println("Ingrese el nombre del equipo visitante: ");
        p1.setVisitante(in.next());

        System.out.println("Ingrese la cantidad de goles que metio el equipo visitante: ");
        p1.setGolesVisitante(in.nextInt());

        return p1;

    }
}