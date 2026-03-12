Program practicaArboles;

type
  data = record
    dni: integer;
    nombre: string;
    apellido: string;
  end;

  Arbol = ^Nodo;
  
  Nodo = record
    data: data;
    HI, HD: ^Nodo;
  end;

procedure Separador();

begin
  writeln('--------------------');
end;

function LeerData(): data;

var
  D: data;

begin
  Separador();
  writeln('DNI (-1 para cortar): ');
  readln(D.dni);

  if (D.dni > 0) then begin
    writeln('Nombre: ');
    readln(D.nombre);
  
    writeln('Apellido: ');
    readln(D.apellido);
  end;
  
  leerData := D;
end;

Procedure InsertarOrdenado(var A: Arbol; D: data);

begin
  if (A = nil) then begin
    new(A);
    A^.HI := nil;
    A^.HD := nil;
    A^.data := D;
    
  end else if (A^.data.dni < D.dni) then // Si el valor era mayor, sigue por la rama derecha
    InsertarOrdenado(A^.HD, D)
  else if (A^.data.dni > D.dni) then // Si el valor era menor, sigue por la rama 
    InsertarOrdenado(A^.HI, D)
end;

Procedure CargarArbol (var A: Arbol);

var
  DataInsertar: data;

begin
  repeat
    DataInsertar := LeerData();
    
    if (DataInsertar.dni > 0) then
      InsertarOrdenado(A, DataInsertar);
  until (DataInsertar.dni <= 0);
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

function BuscarDNI(var A: Arbol; DniBuscar: integer): Arbol;

begin
  BuscarDNI := nil;
  
  if (A = nil) then // Si esta vacio, devuelve nil
    BuscarDNI := nil
  else if (A^.data.dni = DniBuscar) then // Si lo encontramos, lo devolvemos
    BuscarDNI := A
  else if (A^.data.dni < DniBuscar) then // Si el nodo es menor, buscamos a la derecha
    BuscarDNI := BuscarDNI(A^.HD, DniBuscar)
  else if (A^.data.dni > DniBuscar) then // Si el nodo es mayor, buscamos a la izquierda
    BuscarDNI := BuscarDNI(A^.HI, DniBuscar)
end;

Procedure ImprimirData(D: data);

begin
  writeln('Nombre: ', D.nombre, ', ', 'Apellido: ', D.apellido, ', ', 'DNI: ', D.dni);
end;

Procedure BuscarApellidoEnArbol(A: Arbol; Apellido: string);

begin
  if (A <> nil) then begin // Si no esta vacio...
    BuscarApellidoEnArbol(A^.HI, Apellido);
    if (A^.data.apellido = Apellido) then // Si lo encontramos, lo imprimimos
      ImprimirData(A^.data);
    BuscarApellidoEnArbol(A^.HD, Apellido);
  end;
end;

var
  ArbolPersonas, NodoDni: Arbol;
  DniBuscar: integer;
  ApellidoBuscar: string;

begin
  ArbolPersonas := nil;

  CargarArbol(ArbolPersonas);
  
  Separador();
  
  writeln('Ingrese un DNI para buscarlo en el arbol: ');
  readln(DniBuscar);
  
  NodoDni := BuscarDNI(ArbolPersonas, DniBuscar);
  
  if (NodoDni <> nil) then
    writeln('Se encontró el dni ingresado para la persona: ', NodoDni^.data.nombre, ' ', NodoDni^.data.apellido)
  else
    writeln('No se encontró ese DNI en el arbol');
    
  Separador();
  
  writeln('Ingrese un apellido para imprimir los datos de todos los que lo tienen: ');
  readln(ApellidoBuscar);
  
  BuscarApellidoEnArbol(ArbolPersonas, ApellidoBuscar);
  
  LiberarArbol(ArbolPersonas);
end.
