### **Pregunta 1**

**Enunciado de la pregunta**
De la solución implementada para el TP, mencione aquellos casos donde utilizó recursión. Justifique por qué le pareció necesario utilizarlo durante el desarrollo.

**Respuesta**
> Los casos en los que se utilizo recursion fue:
>
> Insertar destino al arbol: Para insertar ordenadamente.
>
> Imprimir en rango destino: Para podar el arbol y no recorrer estructuras innecesariamente. Solamente las que estan en rango.
>
> Imprimir en rango fecha: Para podar el arbol y solo tomar las que estan en el rango de fecha.
>
> En los modulos de verMin: Para actualizar el minimo y recorrer cada nodo en sus hijos.
>
> En todos estos casos es necesario usar recursion para mejorar la legibilidad, hacer soluciones eficientes o seguir procesando o imprimiendo en cada rama de un nodo del arbol.

### **Pregunta 2**

**Enunciado de la pregunta**
De la solución implementada para el TP, enumere donde realizó recorridos de la estructura. Explique por qué eligió cada manera de recorrer la estructura.

**Respuesta**
> Se realizo recorridos de la estructura en el Insertar. Ademas, se necesito recorrer la lista de destinos para insertar en el arbol (iterarContarPaquete y IterarListaDestinos).
>
> En contarNodosListaPaquetes se recorrio tambien la lista de paquetes para contar sus elementos.

### **Pregunta 3**

**Enunciado de la pregunta**
De la solución implementada para el TP, al crear la nueva estructura ¿Tuvo que procesar elementos repetidos? ¿Cuál/es? ¿Por qué?

**Respuesta**
> Si, se tuvieron que procesar elementos repetidos. En especifico, se podia dar el caso que un destino estuviera incluido en varios paquetes. En ese caso, no se creaba un nuevo nodo en el arbol, sino que solo se agregaba el paquete a la lista de paquetes del nodo destino.

### **Pregunta 4**

**Enunciado de la pregunta**
De la solución implementada para el TP, identifique y mencione todas las operaciones sobre árboles utilizadas (aquellas que vimos a lo largo del módulo). Justifique brevemente para qué utilizó cada una de estas operaciones en el contexto del problema.

**Respuesta**
> Los modulos en los que se uso operaciones sobre arboles binarios son:
>
> InsertarNodoArbol --> Para insertar un nodo en el arbol, partiendo de un paquete y insertando tambien la lista de paquetes que cada nodo debe tener.
>
> insertarDestinoAlArbol --> En este modulo se controlaban las condiciones para insertar ordenadamente por el nombre del destino.
>
> imprimirAcotadoDestino --> Se uso recursion para recorrer el arbol en orden e imprimir solo los destinos que estan dentro del rango.
>
> contarAcotadoPorFecha --> Lo mismo que el anterior, nada mas que el rango que se imponia era una fecha minima y maxima.
>
> EliminarNodo --> En este modulo se realizaban los enganches para eliminar un nodo que ya sabemos que existe. Tambien se maneja los casos en los que este nodo tengo 0 hijos, 1 hijo o ambos hijos.
>
> ImprimirArbol --> En este modulo se recorria el arbol para imprimir sus nodos. Notar que tambien se debia iterar la lista paquetes para imprimirla entera por cada nodo.

### **Pregunta 5**

**Enunciado de la pregunta**
De la solución implementada para el TP, para el caso de eliminar un elemento, construya un pseudo-código que contemple todos los casos que pueden darse al eliminar un elemento de la estructura generada. Detalle en cada caso el listado de acciones a llevar adelante con palabras, no con código.

**Respuesta**
> begin
>
> &nbsp;&nbsp;&nbsp;Si es una hoja
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Begin
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Se borra directamente, pasando el ptr a una var auxiliar y haciendo dispose y poniendo el puntero en nil
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;End
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si no, entonces tiene un hijo a la derecha,
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pasar el hijo al nodo y despues eliminarlo
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si no, entonces tiene un hijo a la derecha
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pasar el hijo al nodo y despues eliminarlo
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si no tiene hijos en los dos sentidos
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Begin
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;// Encontrar el dato menor en la rama derecha
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;// Sobreecribe el que queres eliminar
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;// Elimina el reacomodado
>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;End;
>
> end;