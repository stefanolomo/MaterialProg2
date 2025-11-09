
### **Pregunta 1**

**Enunciado de la pregunta**
De la solución implementada para el TP, cite algún caso donde tuvo que utilizar el mecanismo de memoria distribuida de R-Info. Justifique por qué le parece relevante el ejemplo seleccionado.

**Respuesta**
> Un caso en el que se uso memoria distribuida fue en las areas parcialmente compartidas. Estas areas, las dos de las escaleras, serian accedidas por el robot 1 o el robot 2, pero nunca el robot coordinador. Debido a esto, se debian implementar areas que permitieran a en el pero caso, acceder a alguno de los dos robots, pero no a todos.
>
> Es relevante este ejemplo ya que si fueren areas compartidas, se podria intuir que todos los robots acceden a ella en algun momento. Esto no es cierto y hubiera sido incorrecto.

### **Pregunta 2**

**Enunciado de la pregunta**
De la solución implementada para el TP, cite algún caso donde tuvo que utilizar el mecanismo de memoria compartida de R-Info. Justifique por qué le parece relevante el ejemplo seleccionado.

**Respuesta**
> Un caso en el que tuve que utilizar la memoria compartida de Rinfo fue en las areas compartidas. Esto es porque en el area del deposito, se sabia que todos los robots entrarian o a depositar elemntos o a limpiar las esquinas.
>
> Es relevante porque tambien se tuvo que implementar que los robots bloqueen la esquina del deposito correspondiente, para que en el caso de que les toque la misma esquina a los dos, no choquen entre si.

### **Pregunta 3**

**Enunciado de la pregunta**
De la solución implementada para el TP, cite algún caso donde se maximiza la concurrencia. Justifique por qué le parece relevante el ejemplo seleccionado. Como ayuda para elegir el ejemplo: piense que ocurriría con ese caso si no se hubiese programado de manera concurrente.

**Respuesta**
> Un ejemplo de una instancia en la que se maximizó la concurrencia fue cuando los robots 1 y 2 que recorrian avenidas pares e imapres, dejaban lo que habian tomado en el area deposito.
>
> Es relevante porque si no se hubiera usado concurrencia, el programa tendria que esperar que un robot deje todo en su esquina del deposito, mientras otro no hace nada. Esto haria que el programa complete las avenidas en mucho mas tiempo del que se requiere.

### **Pregunta 4**

**Enunciado de la pregunta**
De la solución implementada para el TP, cite los tipos de áreas declaradas necesarios para cada caso del problema. Justifique por qué optó por ese tipo de área en cada caso.

**Respuesta**
> Los tipos de areas del programa que fueron declarados fueron:
>
> Las avenidas pares, para el robot que las recorria. (Eran privadas a ese robot)
>
> Las avenidas impares, para el robot que las recorria (Tambien privadas a ese robot)
>
> El area del deposito, era un area compartida, ya que todos los robots accedian a ella en algun momento.
>
> El area para hacer la escalera inferior, era parcialmente compartida porque podria aceder el recolector 1 o el 2, pero nunca el coordinador.
> El area para hacer la escalera superior igual, podrian acceder o el 1 o el 2 pero no el coordinador.
>
> Tambien las areas en las que iniciaban cada robot eran privadas a cada uno. La del coordinador era un punto.