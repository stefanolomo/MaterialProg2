### **Pregunta 1**

**Enunciado de la pregunta**
¿Usaron extends? ¿En qué clases y por qué?

**Respuesta**
> Si, usamos extends en clases que tenian el conector semantico "x es y" por ejemplo:
>
> - Una intervencion era una atencion
> - Un tratamiento era una atencion
>
> Al ser ambos atenciones, tenian metodos comunes, como:
>
> Settear y gettear dueños, fechas, precios, animales, numeros de atencion.
>
> Esos metodos en comun podian ser implementados en la clase padre Atencion y ser heredados para ser usados en intervencion o tratamiento.

### **Pregunta 2**

**Enunciado de la pregunta**
De la solución implementada para el TP, cite un caso de uso de la palabra reservada super. Justifique por qué le parece relevante el ejemplo seleccionado.

**Respuesta**
> Un caso en el que usamos super, es cuando necesitabamos acceder al constructor de la superclase. Por ejemplo, en el contructor de una intervencion, usamos a la vez el constructor de la superclase para reutilizar codigo solamente pasandole los parametros que el constructor super necesitaba.

### **Pregunta 3**

**Enunciado de la pregunta**
¿Cómo mostraron los datos en el programa principal? ¿incluyeron algún/os método/os? ¿dónde lo/s declararon?

**Respuesta**
> Para mostrar los datos en el programa principal usamos principalmente los metodos imprimir de las mismas clases. En la muestra del promedio usamos un metodo que calculaba el promedio y lo devolvia, que solo era un modulo del programa principal. Ese fue declarado en la clase del PP. Eso es porque no correspondia calcular el promedio en ninguna de las clases ya que era un requerimiento muy general.

### **Pregunta 4**

**Enunciado de la pregunta**
¿Usaron alguna clase abstracta? ¿Cuál y por qué?

**Respuesta**
> Si, en especifico usamos la clase Atencion como abstracta, ya que tenia procedimientos en comun con sus sublclases que no podian ser definidas para todas. Haciendo la clase abstracta, te aseguras que los metodos abstractos definidos, deben ser implementados en las subclases para que el programa compile.

### **Pregunta 5**

**Enunciado de la pregunta**
De la solución implementada para el TP, cite un caso de uso de un método abstracto. Justifique por qué le parece relevante el ejemplo seleccionado.

**Respuesta**
> Un metodo abstracto que usamos fue calcular el precio de cada atencion. Necesitó ser abstracto ya que la implementacion y la aplicacion de descuentos o recargos variaban si la atencion era una intervencion o un tratamiento. Es relevante porque que sea abstracta es la forma de obligar a las subclases a implementar el metodo, pero dando libertad de hacerlo como sea necesario para cada subclase.