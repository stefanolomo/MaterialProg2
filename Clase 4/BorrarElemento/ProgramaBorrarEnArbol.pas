
Program ProgramaBorrarEnArbol;

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

procedure Separador();
begin
    writeln('');
    writeln('');
    writeln('----------------------------------------');
    writeln('');
end;


procedure verMin(A: arbol; var valor: integer);

begin
    // El minimo de un arbol binario ordenado siempre va a estar a la izquierda de todos los nodos, es decir, va a ser la hoja mas a la izquierda del arbol

    if (A = nil) then // El arbol esta vacio
        valor := -1
    else if (A^.HI = nil) then // Estamos en la ultima hoja a la izquierda
        valor := A^.dato
    else // Hay que seguir avanzando hacia la izquierda
        verMin(A^.HI, valor);
end;
procedure BorrarElemento(var a:arbol; dato:integer; var resultado:boolean);
var borrar:arbol;
    numero:integer;
begin
    if (a=nil) then resultado:=false
    else
        if (a^.dato>dato)then
        BorrarElemento(a^.HI,dato,resultado)
        else if (a^.dato<dato) then
        BorrarElemento(a^.HD,dato,resultado)
             else
             begin
                resultado:=true;
                if (a^.HI=nil) and (a^.HD=nil)then
                begin
                    borrar:=a;
                    a:=nil;
                    dispose(borrar);
                end
                else
                if (a^.HI=nil) and (a^.HD<>nil)then
                    begin
                    borrar:=a;
                    a:=a^.HD;
                    dispose(borrar);
                    end
                else if (a^.HI<>nil) and (a^.HD=nil)then
                    begin
                    borrar:=a;
                    a:=a^.HI;
                    dispose(borrar);
                    end
                    else
                    begin
                      verMin(a^.HD,numero);
                      a^.dato:=numero;
                      BorrarElemento(a^.HD,numero,resultado);
                    end;
             end;
end;
Var

    l:   lista;
    a, punteroBuscado:   arbol;
    enteroBuscado: integer;
    resultado:boolean;
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


    enteroBuscado:=1;
    while (enteroBuscado<>0)and(a<>nil)do
    begin
    writeln('Ingrese el entero que quiere Eliminar en la lista(0 para terminar)');
    readln(enteroBuscado);
    while enteroBuscado < 0 do begin
        writeln('Ingresar un numero valido ( > 0 )');
        readln(enteroBuscado);
    end;

    BorrarElemento(a, enteroBuscado, resultado);

    if (resultado = true) then
        writeln('Se elimino el valor ',enteroBuscado)
    else
        writeln('No se encontro el entero');
    Separador();
    imprimirpornivel(a);

    end;
    if (a=nil)then writeln('no hay mas elementos en la lista');
    writeln();readln;readln;
End.