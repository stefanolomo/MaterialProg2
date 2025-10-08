public class program1{
    public static void main(String[] args){
        int tamañoGrupo = 2;
        Personaje[] grupoAventureros = new Personaje [tamañoGrupo];
        Guerrero conan = new Guerrero("Conan",5,150,20);
        Mago merlin = new Mago("Merlin",6,80,25);
        grupoAventureros[0] = conan;
        grupoAventureros[1] = merlin;

        System.out.println("--- Estado inicial del grupo de aventureros ---");
        for (Personaje p : grupoAventureros){
            System.out.println(p.toString());
        }

        System.out.println("\n--- Los aventureros realizan sus ataques especiales ---");
        for (Personaje p : grupoAventureros){
            double dañoPotencial = p.Habilidad();
            System.out.println(p.getNombre() + " realiza su ataque especial. Daño potencial calculado: " + dañoPotencial);
        }

        for (Personaje p : grupoAventureros){
            int dañoBaseSimulado = 20;
            int dañoEfectivoRecibido = p.recibirDaño(dañoBaseSimulado);
            System.out.println(p.getNombre() + " recibió " + dañoEfectivoRecibido + " puntos de daño efectivo.");
            System.out.println("Vida restante de " + p.getNombre() + ": " + p.getVida());

            if (p.getVida()==0)
                System.out.println(p.getNombre() + " ha sido derrotado.");   
        }
        
        for (Personaje p : grupoAventureros){
            p.subirNivel();
            System.out.println(p.getNombre() + " ha subido al nivel " + p.getNivel() + "!");
            System.out.println("Nuevo estado de " + p.getNombre() + ": " + p.toString());
        }
        
        System.out.println("\n--- Estado final del grupo ---");
        
        for (Personaje p : grupoAventureros) {
            System.out.println(p.toString());
        }
    }
}