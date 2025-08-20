
Program arboles;

Type

    // Lista de enteros
    lista =   ^nodoL;
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
    n:=0;
    while (n=0)do
    begin
      n := random (1000);
    end;
    While (n <> 0) Do
        Begin
            agregarAdelante(L, n);
            n := random(20);
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
    If l= Nil Then l := nue
    Else ult^.sig := nue;
    ult := nue;
End;




{-----------------------------------------------------------------------------
IMPRIMIRPORNIVEL - Muestra los datos del �rbol a por niveles }

Procedure imprimirpornivel(a: arbol);

Var
    l, aux, ult:   listaNivel;
    nivel, cant, i:   integer;
Begin
    writeln;
    l := Nil;
    If (a <> Nil)Then
        Begin
            nivel := 0;
            agregarAtras (l,ult,a);
            While (l<> Nil) Do
                Begin
                    nivel := nivel + 1;
                    cant := contarElementos(l);
                    write ('Nivel ', nivel, ': ');
                    For i:= 1 To cant Do
                        Begin
                            write('');
                            write (l^.info^.dato, ' | ');
                            If (l^.info^.HI <> Nil) Then begin
                            agregarAtras (l,ult,l^.info^.HI)
                            end;

                            If (l^.info^.HD <> Nil) Then begin
                               agregarAtras (l,ult,l^.info^.HD);
                            end;
                            aux := l;
                            l := l^.sig;
                            dispose (aux);
                        End;
                    writeln;
                End;
        End;
End;
procedure InsertarNodo(var a:arbol; dato:integer);
var aux:arbol;
begin
  new(aux);
  aux^.dato:=dato;
  aux^.HD:=nil;
  aux^.HI:=nil;
  a:=aux;
end;

procedure insertar(var a:arbol; dato:integer);
begin
     if (a=nil)then
        InsertarNodo(a,dato)
     else
        if (dato<a^.dato)then
           Insertar(a^.HI,dato)
        else
           Insertar(a^.HD,dato);

end;
procedure InsertarDesdeLista(var a:arbol;l:lista);
begin
    While (l <> Nil) Do
        Begin
            Insertar(a,l^.dato);
            l := l^.sig;
        End;
end;

Var

    l:   lista;
    a:arbol;

Begin
    Randomize;

    crearLista(l);
    writeln ('Lista generada: ');
    imprimirLista(l);

    Insertardesdelista(a,l);
    imprimirpornivel(a);
    readln;
End.
