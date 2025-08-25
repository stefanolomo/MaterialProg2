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

procedure Separador();
begin
    writeln('');
    writeln('');
    writeln('----------------------------------------');
    writeln('');
end;

Procedure busquedaAcotada(a: arbol; inf:integer; sup:integer);
begin
  if (a <> nil) then
    if (a^.dato >= inf) then
      if (a^.dato <= sup) then begin
        write(a^.dato,' - ');
        busquedaAcotada(a^.hi, inf, sup);
        busquedaAcotada (a^.hd, inf, sup);
      end
      else
        busquedaAcotada(a^.hi, inf, sup)
    else
      busquedaAcotada(a^.hd, inf, sup);
end;


Var

    l:   lista;
    a: arbol;
    sup,inf:integer;
begin
  Randomize;

    crearLista(l);
    writeln ('Lista generada: ');
    imprimirLista(l);

    InsertarArbolDesdeLista(l, a);

    Separador();

    writeln('En Orden');
    enOrden(a);

    writeln('Escribir rango:');
    write('inferior: ');readln(inf);
    write('superior: ');readln(sup);
    BusquedaAcotada(a,inf,sup);
    readln;readln;
end.

