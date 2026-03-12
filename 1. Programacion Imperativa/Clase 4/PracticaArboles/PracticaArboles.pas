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

var
  ArbolPersonas: Arbol;

begin
  ArbolPersonas := nil;

  CargarArbol(ArbolPersonas);
  
  
  LiberarArbol(ArbolPersonas);
end.
