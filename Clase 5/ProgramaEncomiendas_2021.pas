
Program encomiendas;

Type

    encomienda =   Record
        codigo:   integer;
        peso:   integer;
    End;

    // Lista de encomiendas
    ListaEncomiendas =   ^nodoL;
    nodoL =   Record
        dato:   encomienda;
        sig:   ListaEncomiendas;
    End;

    ptrListaCod = ^nodoCod;
    nodoCod = record
        codigo: integer;
        sig: ptrListaCod;
    end;

    // Arbol de pesos
    arbol = ^nodoArbol;
    nodoArbol = record
        peso: integer;
        ListaCodigos: ptrListaCod;
        HI, HD: arbol;
    end;

{-----------------------------------------------------------------------------
AgregarAdelante - Agrega una encomienda adelante en l}
Procedure agregarAdelante(Var l: ListaEncomiendas; enc: encomienda);

Var
    aux:   ListaEncomiendas;
Begin
    new(aux);
    aux^.dato := enc;
    aux^.sig := l;
    l := aux;
End;

{-----------------------------------------------------------------------------
CREARLISTA - Genera una lista con datos de las encomiendas }
Procedure crearLista(Var l: ListaEncomiendas);

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
Procedure imprimirLista(l: ListaEncomiendas);
Begin
    While (l <> Nil) Do
        Begin
            writeln('Codigo: ', l^.dato.codigo, '  Peso: ', l^.dato.peso);
            l := l^.sig;
        End;
End;

Procedure Separador();
Begin
    writeln('');
    writeln('');
    writeln('----------------------------------------');
    writeln('');
End;

procedure Buscar(A: arbol; var ptr: arbol; pesoBuscado: integer);

begin
    ptr := nil;

    if (A = nil) then
        ptr := nil
    else if (A^.peso = pesoBuscado) then
        ptr := A
    else if (A^.peso < pesoBuscado) then
        Buscar(A^.HD, ptr, pesoBuscado)
    else
        Buscar(A^.HI, ptr, pesoBuscado)
end;

procedure insertarAlFinalListaCodigos(var ListaNodo: ptrListaCod; codigo: integer);

var
    ant, act, nuevo: ptrListaCod;

begin
    ant := nil;
    act := ListaNodo;

    new(nuevo);
    nuevo^.codigo := codigo;
    nuevo^.sig := nil;

    while (act <> nil) do begin
        ant := act;
        ListaNodo := ListaNodo^.sig;
    end;

    ant^.sig := nuevo;
end;

procedure InsertarCodigoEnArbol(var A: arbol; peso, codigo: integer);

var
    NodoEncontrado: arbol;

begin
    Buscar(A, NodoEncontrado, peso);

    if (NodoEncontrado <> nil) then
        insertarAlFinalListaCodigos(NodoEncontrado^.ListaCodigos, codigo);
end;

Procedure InsertarArbolDesdeLista(L: ListaEncomiendas; Var A: arbol);

Begin
    While (L <> Nil) Do
        Begin
            // InsertarCodigoEnArbol(A, L^.peso, L^.codigo);

            L := L^.sig;
        End;
End;

Var

    l:   ListaEncomiendas;
    ArbolDePesos: arbol;

Begin
    Randomize;

    crearLista(l);
    writeln ('Lista de encomiendas generada: ');
    imprimirLista(l);

    Separador();

    InsertarArbolDesdeLista(l, ArbolDePesos);


End.
