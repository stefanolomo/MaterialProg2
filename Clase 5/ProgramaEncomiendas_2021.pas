
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


Var

    l:   lista;

Begin
    Randomize;

    crearLista(l);
    writeln ('Lista de encomiendas generada: ');
    imprimirLista(l);

    readln;
End.
