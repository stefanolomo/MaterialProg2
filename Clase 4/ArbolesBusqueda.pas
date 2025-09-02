
Program ArbolesBusqueda;

Type

    // Lista de enteros
    Lista =   ^nodoL;
    nodoL =   Record
        dato:   integer;
        sig:   lista;
    End;

    // Arbol de enteros
    arbol =   ^nodoA;
    nodoA =   Record
        dato:   integer;
        HI:   arbol;
        HD:   arbol;
    End;

    // Lista de Arboles
    listaNivel =   ^nodoN;
    nodoN =   Record
        info:   arbol;
        sig:   listaNivel;
    End;


{-----------------------------------------------------------------------------
    AgregarAdelante - Agrega nro adelante de l}
Procedure agregarAdelante(Var l: Lista; nro: integer);

Var
    aux:   lista;
Begin
    new(aux);
    aux^.dato := nro;
    aux^.sig := l;
    l := aux;
End;


{-----------------------------------------------------------------------------
    CREARLISTA - Genera una lista con n�meros aleatorios }
Procedure crearLista(Var l: Lista);

Var
    n:   integer;
Begin
    l := Nil;
    n := random (40);

    While n=0 Do
        n := random (40);

    While (n <> 0) Do
        Begin
            agregarAdelante(L, n);
            n := random (20);
        End;
End;


{-----------------------------------------------------------------------------
IMPRIMIRLISTA - Muestra en pantalla la lista l }
Procedure imprimirLista(l: Lista);
Begin
    While (l <> Nil) Do
        Begin
            write(l^.dato, ' - ');
            l := l^.sig;
        End;
End;

Procedure InsertarIntegerNodoArbol(Var A: arbol; dato: integer);

Var
    aux:   arbol;

Begin
    new(aux);

    aux^.dato := dato;
    aux^.HI := Nil;
    aux^.HD := Nil;

    A := aux;
End;

Procedure InsertarIntegerArbol(Var A: arbol; dato: integer);

Begin
    If (A = Nil) Then
        InsertarIntegerNodoArbol(A, dato)
    Else If (A^.dato > dato) Then
            InsertarIntegerArbol(A^.HI, dato)
    Else
        InsertarIntegerArbol(A^.HD, dato)
End;

Procedure InsertarArbolDesdeLista(L: Lista; Var A: arbol);

Begin
    While (L <> Nil) Do
        Begin
            InsertarIntegerArbol(A, L^.dato);

            L := L^.sig;
        End;
End;

Procedure enOrden( A:
                  arbol );
Begin
    If ( A <> Nil ) Then
        Begin
            enOrden (a^.HI);
            write (a^.dato, ' ');
            enOrden (a^.HD)
        End;
End;

Procedure Separador();
Begin
    writeln('');
    writeln('');
    writeln('----------------------------------------');
    writeln('');
End;

Procedure busquedaAcotada(a: arbol; inf:integer; sup:integer);

Begin
    If (a <> Nil) Then
        If (a^.dato >= inf) Then // Si el dato es mayor o igual a la cota inferior
            If (a^.dato <= sup) Then Begin // Y también menor o igual a la cota superior
                write(a^.dato,' - '); // Imprimirlo
                busquedaAcotada(a^.hi, inf, sup); // Seguir en su rama derecha
                busquedaAcotada (a^.hd, inf, sup); // y seguir en su rama izquierda
            End Else
                // El dato es mayor o igual la cota menor pero se pasa de la cota superior, entonces seguir a la izquierda donde hay datos menores a el
                busquedaAcotada(a^.hi, inf, sup)
        Else
        // El dato es menor a la cota inferior (a ambas) entonces seguir a la derecha donde hay datos mayores a el
        busquedaAcotada(a^.hd, inf, sup);
End;


Var

    l:   lista;
    a:   arbol;
    sup,inf:   integer;
Begin
    Randomize;

    crearLista(l);
    writeln ('Lista generada: ');
    imprimirLista(l);

    InsertarArbolDesdeLista(l, a);

    Separador();

    writeln('En Orden');
    enOrden(a);

    Separador();

    write('Rango inferior de busqueda: ');
    readln(inf);

    write('Rango superior de busqueda: ');
    readln(sup);

    BusquedaAcotada(a,inf,sup);

    writeln();
    readln;
End.
