program biblioteca;

type
  libro = record
    titulo, clasificador: String;
    isbn: longint;
  end;
  
  Arbol = ^NodoArbol;
  NodoArbol = record
    dato: libro;
    HI, HD: Arbol;
  end;

function LeerLibro(): libro;

var
  LibroLeido: libro;

begin
  writeln('Ingrese el ISBN: ');
  readln(LibroLeido.isbn);
  
  if (LibroLeido.isbn <> 0) then begin
    writeln('Ingrese el titulo: ');
    readln(LibroLeido.titulo);
    writeln('Ingrese el clasificador: ');
    readln(LibroLeido.clasificador);
  end;
  
  LeerLibro := LibroLeido;
end;

procedure InsertarLibroEnArbol(var A: arbol; L: libro);

begin
  if (A = nil) then begin
    new(A);
    A^.HI := nil;
    A^.HD := nil;
    A^.dato := L;
    
  end else if (A^.dato.isbn < L.isbn) then // Si el valor era mayor, sigue por la rama derecha
    InsertarLibroEnArbol(A^.HD, L)
  else if (A^.dato.isbn > L.isbn) then // Si el valor era menor, sigue por la rama izquierda
    InsertarLibroEnArbol(A^.HI, L)
end;

procedure CargarArbol(var A: arbol);

var
  LibroCargar: libro;

begin
  repeat
    LibroCargar := LeerLibro();
    
    if (LibroCargar.isbn <> 0) then
      InsertarLibroEnArbol(A, LibroCargar);
  until (LibroCargar.isbn = 0);
end;

procedure ImprimirArbolEnOrden(A: arbol);

begin
  if (A <> nil) then begin
    ImprimirArbolEnOrden(A^.HI);
    writeln('> ISBN: ', A^.dato.isbn, ' Titulo: ', A^.dato.titulo, ' Clasificador: ', A^.dato.clasificador);
    ImprimirArbolEnOrden(A^.HD);
  end;
end;

function ExisteIsbn(A: Arbol; isbn: longint): boolean;

begin
  if (A = nil) then // si el arbol esta vacio, no existe
    ExisteIsbn := False
  else if (A^.dato.isbn = isbn) then // si es el mismo, existe
    ExisteIsbn := True
  else if (A^.dato.isbn > isbn) then // si es menor, debe estar en la rama izquierda de existir 
    ExisteIsbn := ExisteIsbn(A^.HI, isbn)
  else if (A^.dato.isbn < isbn) then // si es mayor, debe estar en la rama derecha de existir
    ExisteIsbn := ExisteIsbn(A^.HD, isbn)
end;

function OcurrenciasClasificador(A: Arbol; clasificador: String): longint;

begin
  if (A = nil) then // Si el arbol esta vacio, no hay ocurrencias
    OcurrenciasClasificador := 0
  else if (A^.dato.clasificador = clasificador) then // Si clasificador de la raiz es el que se busca, se suma 1 a la cantidad de ocurrencias que haya en las ramas
    OcurrenciasClasificador := 1 + OcurrenciasClasificador(A^.HI, clasificador) + OcurrenciasClasificador(A^.HD, clasificador)
  else // Si la raiz no es el clasificador, se busca en las ramas sin sumar
    OcurrenciasClasificador := OcurrenciasClasificador(A^.HI, clasificador) + OcurrenciasClasificador(A^.HD, clasificador)
end;

function ExisteTitulo(A: Arbol; titulo: String): boolean;

var
  EsElActual: boolean;

begin
  if (A = nil) then // si el arbol esta vacio, no existe
    ExisteTitulo := False
  else begin
    EsElActual := (A^.dato.titulo = titulo);
    ExisteTitulo := EsElActual or ExisteTitulo(A^.HI, titulo) or ExisteTitulo(A^.HD, titulo); 
  end;
end;

var
  ArbolLibros: Arbol;
  isbn, ocurrencias: longint;
  clasificador, titulo: String;

begin
  ArbolLibros := nil;
  CargarArbol(ArbolLibros);
  
  ImprimirArbolEnOrden(ArbolLibros);
  
  writeln('Ingrese un isbn para buscar: ');
  readln(isbn);
  if (ExisteIsbn(ArbolLibros, isbn)) then writeln('El isbn ', isbn, ' existe en el arbol.')
  else writeln('El isbn no existe en el arbol.');

  writeln('Ingrese un clasificador para buscar sus ocurrencias: ');
  readln(clasificador);
  ocurrencias := OcurrenciasClasificador(ArbolLibros, clasificador);
  if (ocurrencias > 0) then writeln('El clasificador ', clasificador, ' existe en el arbol ', ocurrencias, ' veces.')
  else writeln('El clasificador no existe en el arbol.');

  writeln('Ingrese un titulo para buscar: ');
  readln(titulo);
  if (ExisteTitulo(ArbolLibros, titulo)) then writeln('El titulo ', titulo, ' existe en el arbol.')
  else writeln('El titulo no existe en el arbol.');
end.
