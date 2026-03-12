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

procedure Reemplazar(var A: Arbol; var Aux: Arbol);
var
  nodoEliminar: Arbol;
begin
  if (Aux^.HD <> nil) then
    { Seguimos bajando a la derecha para buscar el valor más grande }
    Reemplazar(A, Aux^.HD)
  else begin
    { Encontramos el mayor de los menores }
    A^.data := Aux^.data; { Copiamos el contenido (DNI, etc.) }
    nodoEliminar := Aux;   { Guardamos el nodo para borrarlo }
    Aux := Aux^.HI;       { Enganchamos el subárbol izquierdo que pudiera tener }
    dispose(nodoEliminar); { Liberamos memoria }
  end;
end;

procedure EliminarNodo(var A: Arbol);
var aux: Arbol;
begin
  if (A^.HI = nil) then begin        { Caso 1 y 2: Sin hijo izquierdo }
    aux := A;
    A := A^.HD;
    dispose(aux);
  end 
  else if (A^.HD = nil) then begin   { Caso 2: Sin hijo derecho }
    aux := A;
    A := A^.HI;
    dispose(aux);
  end 
  else begin                         { Caso 3: Dos hijos }
    Reemplazar(A, A^.HI);            { Buscamos el mayor de los menores }
  end;
end;

function BorrarDni(var A: Arbol; Dni: integer): boolean;

begin
  if (A = nil) then
    BorrarDni := False
  else if (A^.data.dni = Dni) then begin
    EliminarNodo(A);
    BorrarDni := True;
  end else if (A^.data.dni < Dni) then
    BorrarDni := BorrarDni(A^.HD, Dni)
  else if (A^.data.dni > Dni) then
    BorrarDni := BorrarDni(A^.HI, Dni);
end;

Procedure ImprimirArbol(A: Arbol);

begin
  if (A <> nil) then begin
    ImprimirArbol(A^.HI);
    ImprimirData(A^.data);
    ImprimirArbol(A^.HD);
  end;
end;

Procedure ImprimirEnRango(A: Arbol; inf, sup: integer);

begin
  if (A <> nil) then begin
    if (A^.data.dni >= inf) then begin
      if (A^.data.dni <= sup) then begin
        // Esta en el rango
        ImprimirEnRango(A^.HI, inf, sup);
        ImprimirData(A^.data);
        ImprimirEnRango(A^.HD, inf, sup);
      end else
        ImprimirEnRango(A^.HI, inf, sup);
    end else
      ImprimirEnRango(A^.HD, inf, sup);
  end;
end;

var
  ArbolPersonas, NodoDni: Arbol;
  DniBuscar, DniBorrar, limiteInf, limiteSup: integer;
  ApellidoBuscar: string;

begin
  ArbolPersonas := nil;

  CargarArbol(ArbolPersonas);
  
  Separador();
  
  writeln('El arbol quedó como: ');
  ImprimirArbol(ArbolPersonas);
  
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
  
  Separador();
  
  writeln('Ingrese un DNI para borrar');
  readln(DniBorrar);
  
  if BorrarDni(ArbolPersonas, DniBorrar) then
    writeln('La persona con dni ', DniBorrar, ' fue borrada del arbol.')
  else
    writeln('No se encontró a nadie con el dni ingresado.');
  
  Separador();
  
  writeln('Se va a imprimir el arbol final: ');
  ImprimirArbol(ArbolPersonas);
  
  Separador();
  writeln('--- BUSQUEDA POR RANGO DE DNI ---');
  write('Ingrese el limite inferior: '); readln(limiteInf);
  write('Ingrese el limite superior: '); readln(limiteSup);
  writeln('Resultados en el rango [', limiteInf, ' - ', limiteSup, ']:');
  ImprimirEnRango(ArbolPersonas, limiteInf, limiteSup);
  
  LiberarArbol(ArbolPersonas);
end.
