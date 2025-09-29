import java.util.Scanner;

/* 
Realice un programa ppal. que cree un micro con patente “ABC123”, destino “Mar del Plata”
y hora de salida “5:00 am”.

Luego, cargue pasajeros en el micro de la siguiente manera: Leer nros de asientos
desde teclado que corresponden a pedidos de personas. La lectura finaliza
cuando se ingresa el nro de asiento -1 o cuando se llenó el micro. Para cada nro. de asiento
leído debe: validar el nro; en caso que esté libre, ocuparlo e informar a la persona el éxito de la 
operación; en caso que esté ocupado informar a la persona la situación y mostrar el nro. del primer asiento libre.
Al finalizar, informe la cantidad de asientos ocupados del micro.
 */

public class ProgramaPrincipalMicros {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        
        Micro MicroMarDelPlata= Micro.leerMicro(in);
        
        
    }
    
    public static void gestionarCargaInteractiva(Micro microACargar, Scanner in) {
        System.out.println("--- Carga de Pasajeros para el Micro a " + microACargar.getDestino() + " ---");
        
        System.out.println("A continuacion, ingresar el número de asiento a ocupar (1-20). Ingrese -1 para finalizar.");
        
        int asientoLeido = 0;
        
        while (!microACargar.estaLleno() && asientoLeido != -1) {
            System.out.print("Ingrese nro. de asiento: ");
            asientoLeido = in.nextInt(); // Asiento leido en lenguaje coloquial
            
            if (asientoLeido != -1) {
                int indiceAsiento = asientoLeido - 1; // Es el indice del asiento leido
                
                if (microACargar.esAsientoValido(indiceAsiento)) {
                    if (microACargar.ocuparAsiento(indiceAsiento)) { // Si  se ocupa con exito se informa
                        System.out.println("El asiento " + (asientoLeido) + " se ocupo exitosamente.");
                    } else { // Si no, el asiento ya estaba ocupado, se informa igual
                        System.out.println("El asiento " + (asientoLeido) + " ya estaba ocupado");
                        
                        int primerLibre = microACargar.primerDesocupado();
                        // Si hay al menos un asiento libre siguiente, se sugiere usar ese
                        if (primerLibre != -1) {
                            System.out.println("El proximo asiento libre es: " + (primerLibre +  1) + ". Desea cargar al pasajero en ese asiento? [1: Si, 2: No]");
                            int decision = in.nextInt();
                            
                            if (decision == 1) { // Si se elegie usar el siguiente asiento libre, se ocupa ese
                                microACargar.ocuparAsiento(primerLibre);
                                System.out.println("El asiento " + (primerLibre + 1) + " se ocupo exitosamente.");
                            }
                        }
                    }
                } else { // Si no ingreso un asiento valido, se informa
                    System.out.println("El asiento ingresado no es valido! Debe estar entre 1 y 20");   
                }
            }
        }
    }
}