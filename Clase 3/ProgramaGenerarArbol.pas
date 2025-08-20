
Program arboles;

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

{-----------------------------------------------------------------------------
CONTARELEMENTOS - Devuelve la cantidad de elementos de una lista l }

Function ContarElementos (l: listaNivel):   integer;

Var c:   integer;
Begin
    c := 0;
    While (l <> Nil) Do
        Begin
            c := c+1;
            l := l^.sig;
        End;
    contarElementos := c;
End;

{-----------------------------------------------------------------------------
AGREGARATRAS - Agrega un elemento atr�s en l}

Procedure AgregarAtras (Var l, ult: listaNivel; a:arbol);

Var nue:   listaNivel;

Begin
    new (nue);
    nue^.info := a;
    nue^.sig := Nil;

    If l= Nil Then
        l := nue
    Else
        ult^.sig := nue;

    ult := nue;
End;

{-----------------------------------------------------------------------------
IMPRIMIRPORNIVEL - Muestra los datos del �rbol a por niveles }

Procedure imprimirpornivel(a: arbol);

Var
    l, aux, ult:   listaNivel;
    nivel, cant, i:   integer;

Begin
    l := Nil;
    If (a <> Nil) Then
        Begin
            nivel := 0;
            agregarAtras (l,ult,a);
            While (l <> Nil) Do
                Begin
                    nivel := nivel + 1;
                    cant := contarElementos(l);
                    write ('Nivel ', nivel, ': ');
                    For i:= 1 To cant Do
                        Begin
                            write (l^.info^.dato, ' - ');

                            If (l^.info^.HI <> Nil) Then agregarAtras (l,ult,l^.
                                                                       info^.HI)
                            ;

                            If (l^.info^.HD <> Nil) Then agregarAtras (l,ult,l^.
                                                                       info^.HD)
                            ;

                            aux := l;
                            l := l^.sig;

                            dispose (aux);
                        End;
                    writeln;
                End;
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

Procedure preOrden( A:
                   arbol );
Begin
    If ( A <> Nil ) Then
        Begin
            write (a^.dato, ' ');
            preOrden (a^.HI);
            preOrden (a^.HD)
        End;
End;

Procedure enOrden( A:
                   arbol );
Begin
    If ( A <> Nil ) Then
        Begin
            preOrden (a^.HI);
            write (a^.dato, ' ');
            preOrden (a^.HD)
        End;
End;

Procedure postOrden( A:
                   arbol );
Begin
    If ( A <> Nil ) Then
        Begin
            preOrden (a^.HI);
            preOrden (a^.HD);
            write (a^.dato, ' ');
        End;
End;

procedure Separador();
begin
    writeln('');
    writeln('');
    writeln('----------------------------------------');
    writeln('');
end;

procedure Buscar(A: arbol; var ptr: arbol; valor: integer);

begin
    ptr := nil;

    if (A = nil) then
        ptr := nil
    else if (A^.dato = valor) then
        ptr := A
    else if (A^.dato < valor) then
        Buscar(A^.HD, ptr, valor)
    else
        Buscar(A^.HI, ptr, valor)
end;

Var

    l:   lista;
    a, punteroBuscado:   arbol;
    enteroBuscado: integer;

Begin
    Randomize;

    crearLista(l);
    writeln ('Lista generada: ');
    imprimirLista(l);

    InsertarArbolDesdeLista(l, a);

    Separador();

    writeln('Arbol ordenado por nivel');
    imprimirpornivel(a);

    Separador();

    writeln('Pre Orden');
    preOrden(a);

    Separador();

    writeln('En Orden');
    enOrden(a);

    Separador();

    writeln('Post Orden');
    postOrden(a);

    Separador();

    writeln('Ingrese el entero que quiere buscar en la lista');
    readln(enteroBuscado);
    Buscar(a, punteroBuscado, enteroBuscado);

    if (punteroBuscado <> nil) then
        writeln('Se encontro el puntero al numero ', punteroBuscado^.dato)
    else
        writeln('La lista esta vacia / No se encontro el entero');

    writeln();
End.
