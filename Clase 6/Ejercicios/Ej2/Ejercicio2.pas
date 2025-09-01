
Program Ejercicio2;



// Una aerolínea quiere premiar a sus mejores clientes y para ello, lee la información de los pasajes que ha vendido. De cada venta se conoce un código de vuelo (alfanumérico, ej: AR1620), cantidad de millas recorridas, DNI del pasajero, su nombre y apellido y la clase en que solicitó el boleto. Esta información se lee ordenada por código de vuelo.

// Se necesita saber qué cantidad de puntos acumularon los pasajeros de la siguiente manera: cada pasajero que haya viajado en clase ejecutiva suma 100 puntos por milla de vuelo, mientras que aquellos que viajaron en clase turista suman 25 puntos por milla. Por lo que se pide:

// A. Generar una estructura que almacene para cada pasajero su DNI, nombre y apellido y los puntajes acumulados por cada código de vuelo, de manera tal que resulte eficiente la búsqueda por DNI del pasajero.

// Al finalizar el procesamiento de a):

// B. Escriba un módulo que devuelva el mayor puntaje total (sumando todos sus vuelos) para dar el premio al mejor cliente.

// C. Escriba un módulo que imprima el mayor puntaje (entre sus vuelos) de los pasajeros cuyo DNI se encuentre entre 40.000.000 y 50.000.000.

// D. Realizar un programa que simule el llamado a los módulos b) y c), e informe lo devuelto por c).

Type
    venta =   Record
        codigo, nombre, apellido:   string;
        millas, dni:   integer;
        clase:   integer;
    End;

    vuelo =   Record
        codigo:   string;
        puntos:   integer;
    End;

    listaVuelos =   ^nodoVuelos;
    nodoVuelos =   Record
        datos:   vuelo;
        sig:   listaVuelos;
    End;

    pasajero =   Record
        nombre, apellido:   string;
        millas, puntos, dni:   integer;
    End;

    arbol =   ^Nodo;
    Nodo =   Record
        datos:   pasajero;
        HI:   arbol;
        HD:   arbol;
    End;

Procedure leerVuelos(Var vuelos: listaVuelos);

Begin
    // Lee los vuelos y los almacena en la lista
End;

Procedure actualizarArbol(Var arbol: arbol; vuelos: listaVuelos);

Begin
    // Actualiza el árbol con los vuelos
End;

Function calcularSumaPuntos(arbol: arbol):   integer;

Begin
    // Calcula la suma de puntos de cada nodo y encuentra el máximo
End;

Procedure imprimirMayorPuntaje(arbol: arbol);

Begin
    // Imprime el mayor puntaje de los pasajeros cuyo DNI se encuentre entre 40.000.000 y 50.000.000
End;

Var
    vuelos:   listaVuelos;
    arbol:   arbol;

Begin
    // Programa principal
    leerVuelos(vuelos);
    actualizarArbol(arbol, vuelos);
    writeln('Mayor puntaje:', calcularSumaPuntos(arbol));
    imprimirMayorPuntaje(arbol);
End.
