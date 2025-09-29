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
    
        
        MicroMarDelPlata = MicroMarDelPlata.leerMicro(in);
    }
}