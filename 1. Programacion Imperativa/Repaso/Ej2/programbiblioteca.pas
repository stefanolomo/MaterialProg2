
Program programbiblioteca;

Type
    Libro =   Record
        ISBN,Cod:   longint;
        Titulo:   string;
    End;

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
    L:   libro;

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
Begin
    writeln('Titulo: ',L.Titulo);
    writeln('ISBN: ',L.ISBN);
    Writeln('Codigo Clasificador: ',L.Cod);
    writeln;
End;

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

Procedure Buscar(A: arbol; Var Encontrado:boolean; ISBN: longint);

Begin
    Encontrado := false;

    If (A = Nil) Then
        Encontrado := false
    Else If (A^.datos.ISBN = ISBN) Then
             Encontrado := true
    Else If (A^.datos.ISBN < ISBN) Then
             Buscar(A^.HD, Encontrado, ISBN)
    Else
        Buscar(A^.HI, Encontrado, ISBN)
End;

procedure ContarCodClasificador(A: arbol; codBuscado: longint; var veces: longint);

begin
    If ( A <> Nil ) Then // Si no esta vacio
        Begin
            if (A^.datos.Cod = codBuscado) then // Si es el que buscamos, sumamos 1
                veces := veces + 1;

            ContarCodClasificador (a^.HI, codBuscado, veces); // Seguir en las dos ramas
            ContarCodClasificador (a^.HD, codBuscado, veces);
        End;
end;

{PROGRAMA PRINCIPAL}

Var ArbolLibros:   arbol;
    Encontrado:   boolean;
    ISBN, n, codABuscar:   longint;
Begin
    n := 0;

    ArbolLibros := Nil;
    CargarArbol(ArbolLibros);

    Separador();

    EnOrden(ArbolLibros);

    Separador();

    write('Inserte ISBN a buscar: ');
    readln(ISBN);

    Buscar(ArbolLibros,Encontrado,ISBN);

    If (Encontrado)Then writeln('El ISBN esta en el arbol de libros')
    Else writeln('El ISBN no se encontro/no existe en el arbol');

    writeln('Ingrese el codigo clasificador que quiere buscar: ');
    readln(codABuscar);

    ContarCodClasificador(ArbolLibros, codABuscar, n);
    writeln('El codigo clasificador ingresado se encontró en ', n, ' libros distintos');
End.
