program programbiblioteca;
type
    Libro = record
        ISBN,Cod:integer;
        Titulo: string;
    end;

    arbol =   ^nodoA;
    nodoA =   Record
        datos:   Libro;
        HI:   arbol;
        HD:   arbol;
    End;

Procedure InsertarLibroNodoArbol(Var A: arbol; L: Libro);

Var
    aux:   arbol;

Begin
    new(aux);

    aux^.datos := L;
    aux^.HI := Nil;
    aux^.HD := Nil;

    A := aux;
End;

Procedure InsertarLibroEnArbol(Var A: arbol; L: Libro);

Begin
    If (A = Nil) Then // El arbol esta vacio, insertar al principio
        InsertarLibroNodoArbol(A,L)
    Else If (L.ISBN < A^.datos.ISBN) Then // Si se pasa, busca en la izquierda
             InsertarLibroEnArbol(A^.HI, L)
    Else // Sino, busca en la derecha
        InsertarLibroEnArbol(A^.HD, L);

End;

Procedure leerLibro(Var L: Libro);

Begin
    writeln('Ingrese el ISBN del libro (cero para terminar): ');
    readln(L.ISBN);
    While (L.ISBN < 0) Do
        Begin
            writeln('Ingrese un ISBN valido (mayor a 0, cero para terminar):'
            );
            readln(L.ISBN);
        End;

    If (L.ISBN <> 0) Then
        Begin
            writeln('Ingrese el Cod Del Libro');
            readln(L.Cod);

            writeln('Ingrese el Titulo Del libro');
            readln(L.Titulo);
        End;
End;

Procedure Separador();
Begin
    writeln('');
    writeln('--------------------');
    writeln('');
End;

Procedure CargarArbol(Var A: arbol);

Var
    L: libro;

Begin
    leerLibro(L);

    While (L.ISBN <> 0) Do
        Begin
            InsertarLibroEnArbol(A, L);

            Separador();

            leerLibro(L);
        End;
End;

Procedure ImprimirLibro(L: Libro);
begin
    writeln('Titulo: ',L.Titulo);
    writeln('ISBN: ',L.ISBN);
    Writeln('Codigo Clasificador: ',L.Cod);
    writeln;
end;

Procedure enOrden( A:
                   arbol );
Begin
    If ( A <> Nil ) Then
        Begin
            enOrden (a^.HI);
            ImprimirLibro(A^.datos);
            enOrden (a^.HD)
        End;
End;

procedure Buscar(A: arbol; var Encontrado:boolean; ISBN: integer);

begin
    Encontrado := false;

    if (A = nil) then
        Encontrado := false
    else if (A^.datos.ISBN = ISBN) then
        Encontrado := true
    else if (A^.datos.ISBN < ISBN) then
        Buscar(A^.HD, Encontrado, ISBN)
    else
        Buscar(A^.HI, Encontrado, ISBN)
end;

{PROGRAMA PRINCIPAL}
var ArbolLibros:arbol;
    Encontrado:boolean;
    ISBN:integer;
begin
ArbolLibros:=nil;
CargarArbol(ArbolLibros);
Separador();
EnOrden(ArbolLibros);
Separador();
write('Inserte ISBN a buscar: ');readln(ISBN);
Buscar(ArbolLibros,Encontrado,ISBN);
if (Encontrado)then writeln('El ISBN se encontro')
               else writeln('El ISBN no se encontro/no existe en el arbol');
readln;
end.

