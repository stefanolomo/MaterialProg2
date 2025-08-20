
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

    while n=0 do
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
    writeln();
    writeln();
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

                            If (l^.info^.HI <> Nil) Then agregarAtras (l,ult,l^.info^.HI);

                            If (l^.info^.HD <> Nil) Then agregarAtras (l,ult,l^.info^.HD);

                            aux := l;
                            l := l^.sig;

                            dispose (aux);
                        End;
                    writeln;
                End;
        End;
End;

procedure InsertarIntegerNodoArbol(var A: arbol; dato: integer);

var
    aux: arbol;

begin
    new(aux);

    aux^.dato := dato;
    aux^.HI := nil;
    aux^.HD := nil;

    A := aux;
end;

procedure InsertarIntegerArbol(var A: arbol; dato: integer);

begin
    if (A = nil) then
        InsertarIntegerNodoArbol(A, dato)
    else if (A^.dato > dato) then
        InsertarIntegerArbol(A^.HI, dato)
    else
        InsertarIntegerArbol(A^.HD, dato)
end;

procedure InsertarArbolDesdeLista(L: Lista; var A: arbol);

begin
    while (L <> nil) do begin
        InsertarIntegerArbol(A, L^.dato);

        L := L^.sig;
    end;
end;

Var

    l:   lista;
    a:   arbol;

Begin
    Randomize;

    crearLista(l);
    writeln ('Lista generada: ');
    imprimirLista(l);

    InsertarArbolDesdeLista(l, a);

    imprimirpornivel(a);

    readln;
End.
