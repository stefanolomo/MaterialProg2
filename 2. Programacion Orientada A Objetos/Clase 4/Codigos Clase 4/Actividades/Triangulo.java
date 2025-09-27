
/**
 * Write a description of class Triangulo here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Triangulo
{
    // instance variables - replace the example below with your own
    private String colorLinea;
    private String colorRelleno;
    private double lado1, lado2, lado3;

    /**
     * Constructor for objects of class Triangulo
     */
    public Triangulo()
    {
        // Tamaño de 3 lados, color de linea, color de relleno 
    }

    /**
     * Clase que crea un triangulo con el largo de sus 3 lados, color de linea y color de relleno.
     * Sus metodos son para setear las 3 propiedades, gettear las 3 propiedades, devolver el area, y devolver el perimetro.
     */

    public void setColorRelleno(String color)
    {
        this.colorRelleno = color;    
    }

    public void setColorLinea(String color)
    {
        this.colorLinea = color;
    }

    public void setLados(double lado1, double lado2, double lado3)
    {
        this.lado1 = lado1;
        this.lado2 = lado2;
        this.lado3 =  lado3;
    }

    public String getColorRelleno(String color)
    {
        return this.colorRelleno;
    }

    public String getColorLinea()
    {
        return this.colorLinea;
    }

    public double getPerimetro(String color)
    {
        return (this.lado1 + this.lado2 + this.lado3);
    }

    public double getArea()
    {
        double s;
        s = (this.lado1 + this.lado2 + this.lado3) / 2;
        return (Math.sqrt(s * (s - this.lado1) * (s - this.lado2) * (s - this.lado3)));
    }
}
