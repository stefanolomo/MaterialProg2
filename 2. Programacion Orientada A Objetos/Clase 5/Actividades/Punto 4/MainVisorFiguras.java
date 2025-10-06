public class MainVisorFiguras {
    public static void main(String[] args) {
        VisorFiguras visor = new VisorFiguras();

        Punto p1=new Punto(2,3);
        Punto p2=new Punto(5,10);
        Punto p3=new Punto(20,30);

        Circulo c1 = new Circulo(10,"Violeta","Rosa",p1);
        Figura Triangulotr = new Triangulo(20,10,5,"Azul","Celeste", p2);
        Circulo c2 = new Circulo(30,"Rojo","Naranja",p3);

        visor.mostrar(c1);
        visor.mostrar(Triangulotr);
        visor.mostrar(c2);

        System.out.println(visor.getMostradas());
    }
}
