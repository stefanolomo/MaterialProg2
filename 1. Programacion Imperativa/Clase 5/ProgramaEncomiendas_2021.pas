Program encomiendas;

Type

    encomienda =   Record
        codigo:   integer;
        peso:   integer;
    End;

    // Lista de encomiendas
    lista =   ^nodoL;
    nodoL =   Record
        dato:   encomienda;
        sig:   lista;
    End;

    listaid = ^nodoid;
    nodoid = Record
        id:integer;
        sig:listaid;
    End;

    arbol =   ^nodoA;
    nodoA =   Record
        peso:   integer;
        HI:   arbol;
        IDlista: listaid;
        HD:   arbol;
    End;

{-----------------------------------------------------------------------------
AgregarAdelante - Agrega una encomienda adelante en l}
Procedure agregarAdelante(Var l: Lista; enc: encomienda);

Var
    aux:   lista;
Begin
    new(aux);
    aux^.dato := enc;
    aux^.sig := l;
    l := aux;
End;

{-----------------------------------------------------------------------------
CREARLISTA - Genera una lista con datos de las encomiendas }
Procedure crearLista(Var l: Lista);

Var
    e:   encomienda;
    i:   integer;
Begin
    l := Nil;
    For i:= 1 To 20 Do
        Begin
            e.codigo := i;
            e.peso := random (10);
            While (e.peso = 0) Do
                e.peso := random (10);
            agregarAdelante(L, e);
        End;
End;

{-----------------------------------------------------------------------------
IMPRIMIRLISTA - Muestra en pantalla la lista l }
Procedure imprimirLista(l: Lista);
Begin
    While (l <> Nil) Do
        Begin
            writeln('Codigo: ', l^.dato.codigo, '  Peso: ', l^.dato.peso);
            l := l^.sig;
        End;
End;

Procedure imprimirListaId(l: Listaid);
Begin
    While (l <> Nil) Do
        Begin
            writeln('Codigo: ', l^.id);
            l := l^.sig;
        End;
End;

Procedure agregarId(Var l: Listaid; id:integer);

Var
    aux:   listaid;
Begin
    new(aux);
    aux^.id := id;
    aux^.sig := l;
    l := aux;
End;

Procedure InsertarIntegerNodoArbol(Var A: arbol; dato: encomienda);

Var
    aux:   arbol;

Begin
    new(aux);
    aux^.peso := dato.peso;
    aux^.IDlista:=nil;
    AgregarId(aux^.IDlista,dato.codigo);
    aux^.HI := Nil;
    aux^.HD := Nil;

    A := aux;
End;
Procedure InsertarIntegerArbol(Var A: arbol; dato: encomienda);

Begin
    If (A = Nil) Then
        InsertarIntegerNodoArbol(A, dato)
    Else If (A^.peso > dato.peso) Then
             InsertarIntegerArbol(A^.HI, dato)
    Else if (A^.peso < dato.peso) then
        InsertarIntegerArbol(A^.HD, dato)
         else agregarId(A^.IDlista,dato.codigo);
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
            writeln('Peso: ',a^.peso);
            imprimirListaId(a^.IDlista);
            enOrden (a^.HD)
        End;
End;

Var

    l:   lista;
    A:  arbol;
Begin
    Randomize;

    crearLista(l);
    writeln ('Lista de encomiendas generada: ');
    imprimirLista(l);

    A:=nil;
    InsertarArbolDesdeLista(l,a);
    writeln;
    writeln('Lista De Pesos:');writeln;
    enOrden(a);
    readln;
End.