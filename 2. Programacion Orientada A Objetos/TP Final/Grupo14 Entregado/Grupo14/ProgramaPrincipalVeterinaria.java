public class ProgramaPrincipalVeterinaria {
    public static void main(String[] args) {
        Atencion[] Veterinaria = new Atencion[30];
        
        Duenno D1 = new Duenno("Fran", "asdjn", "Credito", 1234);
        Atencion at1 = new Tratamiento(1, "Perro", "12/12/2025", true, D1, 100.00, "Fiebre, wefniw", 2);
        Veterinaria[0] = at1;
        
        Duenno D2 = new Duenno("oife", "owe", "Efectivo", 13234);
        String[] medicamentos2 = new String[10];
        medicamentos2[1] = "fewnf";
        medicamentos2[2] = "skjf";
        medicamentos2[3] = "kjbwef";
        Atencion at2 = new Intervencion(1, "Gato", "12/09/2025", true, D1, 100.00, 3, true, medicamentos2);
        Veterinaria[1] = at2;
        
        Duenno D3 = new Duenno("Fran", "asdjn", "Credito", 14234);
        Atencion at3 = new Tratamiento(1, "Perro", "12/12/2025", true, D1, 100.00, "Fiebre, wefniw", 2);
        Veterinaria[2] = at3;
        
        Duenno D4 = new Duenno("oife", "owe", "Credito", 133234);
        String[] medicamentos4 = new String[10];
        medicamentos4[1] = "fewnf";
        medicamentos4[2] = "skjf";
        Atencion at4 = new Intervencion(1, "Gato", "12/09/2025", true, D1, 100.00, 3, true, medicamentos4);
        Veterinaria[3] = at4;
        
        for (int i = 0; i < 4; i++) {
            System.out.println(Veterinaria[i].imprimirEspecifico());
        };
        
        System.out.println(this.hacerPromedioTotal(Veterinaria));
    }
    
    public static double hacerPromedioTotal(Atencion[] Veterinaria) {
        double suma = 0;
        
        for (int i = 0; i < 4; i++) {
            suma = suma + Veterinaria[i].calcularPrecioComun();
        };
        
        return (suma / 4) * 100.0;
    };
}