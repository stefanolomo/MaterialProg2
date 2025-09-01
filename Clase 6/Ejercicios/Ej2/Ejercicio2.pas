
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
        dni     :   integer;
        nombre  :   string;
        apellido:   string;
        vuelos  :   listaVuelos;  { vuelos y sus puntos }
    End;
    arbol =   ^Nodo;
    Nodo =   Record
        datos:   pasajero;
        HI:   arbol;
        HD:   arbol;
    End;

Procedure InsertarOActualizarVuelo(Var L: listaVuelos; V: vuelo);

Var
    act, nuevo:   listaVuelos;

Begin
    act := L;
    While (act <> Nil) And (act^.datos.codigo <> V.codigo) Do
        act := act^.sig;

    If (act <> Nil) Then // El vuelo ya existe, se suman los puntos.
        act^.datos.puntos := act^.datos.puntos + V.puntos
    Else // Hay que crear el nodo para el vuelo
        Begin
            new(nuevo);
            nuevo^.datos := V;
            nuevo^.sig := L;

            L := nuevo;
            // Se inserta adelante
        End;
End;

Procedure LeerRegistroVentas(Var V: venta);

Begin
    // codigo, nombre apellido, dni, millas, clase
    writeln('Ingresar el DNI del pasajero (0 para terminar):');
    readln(V.dni);

    While (V.dni < 0) Do
        Begin
            writeln('El DNI ingresado no es valido. Ingresar otro:');
            readln(V.dni);
        End;

    If (V.dni <> 0) Then
        Begin
            writeln('Ingresar el nombre del pasajero:');
            readln(V.nombre);

            writeln('Ingresar el apellido del pasajero:');
            readln(V.apellido);

            writeln('Ingresar el codigo de vuelo:');
            readln(V.codigo);

            writeln('Ingresar las millas recorridas:');
            readln(V.millas);

            writeln('Ingresar la clase (1: Turista, 2: Ejecutiva):');
            readln(V.clase);

            While Not (v.clase In [1, 2]) Do
                Begin
                    writeln('La clase ingresada no es valida. Ingresar otra (1: Turista, 2: Ejecutiva):');
                    readln(V.clase);
                End;
        End;
End;

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
