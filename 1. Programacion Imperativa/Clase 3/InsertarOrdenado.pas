Program InsertarEnArbol;

type
  Nodo = record
    dato: integer;
    HI: ^Nodo;
    HD: ^Nodo;
  end;
  Arbol = ^Nodo;
  
procedure InsertarOrdenado (var A: Arbol; valor: integer);

// var
//  NuevoNodo: Arbol;

begin
  if (A = nil) then begin // Si llegamos a una hoja...
    // -----------------------
    // Creamos un nodo con el valor que necesitamos
    // new(NuevoNodo);
    // NuevoNodo^.dato := valor;
    // NuevoNodo^.HI := nil;
    // NuevoNodo^.HD := nil;
    
    // Lo insertamos en la hoja
    // A := NuevoNodo;
    // -----------------------
    
    // -----------------------
    // Otra forma de hacerlo sin usar NuevoNodo (o cualquier otra variable) es hacer new() del mismo A que es nil:
    new(A);
    A^.HI := nil;
    A^.HD := nil;
    A^.dato := valor;
  end else if (A^.dato <= valor) then // Si el valor era mayor o igual, sigue por la rama derecha
    InsertarOrdenado(A^.HD, valor)
  else if (A^.dato > valor) then // Si el valor era menor, sigue por la rama 
    InsertarOrdenado(A^.HI, valor)
end;

procedure ImprimirArbolEnOrden (A: Arbol);

begin
  if (A <> nil) then begin
    ImprimirArbolEnOrden(A^.HI);
    writeln(A^.dato);
    ImprimirArbolEnOrden(A^.HD);
  end;
end;
  
procedure LeerInsertarArbol (var A: Arbol);

var
  valor: integer;

begin
  valor := 0;
  
  write('Ingrese el valor a insertar en el arbol (-1 para cortar): ');
    readln(valor);
  
  while (valor >= 0) do begin
    InsertarOrdenado(A, valor);

    write('Ingrese el valor a insertar en el arbol (-1 para cortar): ');
    readln(valor);
  end;
end;
  
procedure Separador();

begin
  writeln('----------------');
end;

function BuscarEnArbol(A: Arbol; k: integer): Arbol;

begin
  if (A = nil) then // Si es nil el nodo, devolvemos nil (consigna)
    BuscarEnArbol := nil
  else if (A^.dato = k) then // Si encontramos el dato, devolvemos su nodo
    BuscarEnArbol := A
  else if (A^.dato < k) then // Si el dato del nodo es menor al buscado, entonces vamos por la derecha
    BuscarEnArbol := BuscarEnArbol(A^.HD, k)
  else if (A^.dato > k) then // Si es dato del nodo es mayor al buscado, entonces vamos por la izquierda
    BuscarEnArbol := BuscarEnArbol(A^.HI, k);
end;
  
function verMax(A: Arbol): Arbol;

begin // El maximo de un arbol esta siempre a la derecha de todas las ramas
  if (A = nil) then // Si esta vacio, devolvemos nil
    verMax := nil
  else if (A^.HD = nil) then // Si no tiene mas ramas a la derecha, estamos en el puntero al maximo
    verMax := A
  else if (A^.HD <> nil) then // Si sigue habiendo camino hacia la derecha, seguimos para ahi
    verMax := verMax(A^.HD);
end;

function verMin(A: Arbol): Arbol;

begin // El minimo de un arbol esta siempre a la izquierda de todas las ramas
  if (A = nil) then // Si esta vacio, devolvemos nil
    verMin := nil
  else if (A^.HI = nil) then // Si no tiene mas ramas a la derecha, estamos en el puntero al maximo
    verMin := A
  else if (A^.HI <> nil) then // Si sigue habiendo camino hacia la derecha, seguimos para ahi
    verMin := verMin(A^.HI);
end;

procedure LiberarArbol(var A: Arbol);
begin
  if (A <> nil) then begin
    LiberarArbol(A^.HI);
    LiberarArbol(A^.HD);
    dispose(A);
    A := nil;
  end;
end;
  
var
  ArbolParaInsertar, maximo, minimo: arbol;
  ValorABuscar: integer;
  
begin
  ArbolParaInsertar := nil;
  
  LeerInsertarArbol(ArbolParaInsertar);
  
  Separador();
  
  writeln('Se imprimirá el arbol: ');
  
  ImprimirArbolEnOrden(ArbolParaInsertar);
  
  Separador();
  
  writeln('Ingrese un numero >= 0 para buscar en el arbol: ');
  
  readln(ValorABuscar);
  
  if (BuscarEnArbol(ArbolParaInsertar, ValorABuscar) <> nil) then
    writeln('Se encontró el numero buscado')
  else writeln('No se encontró el valor buscado');
    
  Separador();
  
  maximo := verMax(ArbolParaInsertar);
  minimo := verMin(ArbolParaInsertar);
  
  if (maximo <> nil) then
    writeln('El maximo numero en el arbol es: ', maximo^.dato)
  else writeln('El arbol esta vacio, no hay maximo');
  
  if (minimo <> nil) then
    writeln('El minimo numero en el arbol es: ', minimo^.dato)
  else writeln('El arbol esta vacio, no hay minimo');
  
  LiberarArbol(ArbolParaInsertar);
end.
