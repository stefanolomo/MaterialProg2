Program encomiendas;

Type
  {-------------------- Lista de encomiendas --------------------}
  encomienda = record
    codigo: integer;
    peso: integer;
    end;

  // Lista de encomiendas
  lista = ^nodoL;
  
  nodoL = record
    dato: encomienda;
    sig: lista;
  end;
  
  {-------------------- Lista de codigos --------------------}
  listaCodigos = ^NodoCodigos;
  NodoCodigos = record
    codigo: integer;
    sig: ListaCodigos;
  end;
  
  {-------------------- Arbol de pesos, adentro tiene lista de codigos --------------------}
  data = record
    peso: integer;
    codigos: listaCodigos;
  end;

  Arbol = ^Nodo;

  Nodo = record
    data: data;
    HI, HD: Arbol; 
  end;
  
{-----------------------------------------------------------------------------
AgregarAdelante - Agrega una encomienda adelante en l}
procedure agregarAdelante(var l: Lista; enc: encomienda);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := enc;
  aux^.sig := l;
  l:= aux;
end;


{-----------------------------------------------------------------------------
CREARLISTA - Genera una lista con datos de las encomiendas }
procedure crearLista(var l: Lista);
var
  e: encomienda;
  i: integer;
begin
 l:= nil;
 for i:= 1 to 20 do begin
    e.codigo := i;
   e.peso:= random (10);
   while (e.peso = 0) do e.peso:= random (10);
   agregarAdelante(L, e);
 End;
end;


{-----------------------------------------------------------------------------
IMPRIMIRLISTA - Muestra en pantalla la lista l }
procedure imprimirLista(l: Lista);
begin
 While (l <> nil) do begin
   writeln('Codigo: ', l^.dato.codigo, '  Peso: ', l^.dato.peso);
   l:= l^.sig;
 End;
end;

procedure Separador();

begin
  writeln('--------------------');
end;

procedure InsertarEnListaCodigos(var L: listaCodigos; codigo: integer);

var
  aux: listaCodigos;
  
begin
  new(aux);
  aux^.codigo := codigo;
  aux^.sig := L;
  L:= aux;
end;


procedure InsertarEnArbol(codigo, peso: integer; var A: Arbol);

begin
  if (A = nil) then begin
    new(A);
    A^.HI := nil;
    A^.HD := nil;
    A^.data.peso := peso;
    A^.data.codigos := nil;
    InsertarEnListaCodigos(A^.data.codigos, codigo);
    
  end else if (A^.data.peso < peso) then // Si el valor era mayor, sigue por la rama derecha
    InsertarEnArbol(codigo, peso, A^.HD)
  else if (A^.data.peso > peso) then // Si el valor era menor, sigue por la rama 
    InsertarEnArbol(codigo, peso, A^.HI)
  else
    InsertarEnListaCodigos(A^.data.codigos, codigo);
end;

Function GenerarArbol(l: lista): Arbol;

var
  ArbolGenerado: Arbol;

begin
  if (l = nil) then
    GenerarArbol := nil
  else begin
    ArbolGenerado := nil;
    
    while (l <> nil) do begin
      InsertarEnArbol(l^.dato.codigo, l^.dato.peso, ArbolGenerado); // Insertamos el elemento de la lista
      l := l^.sig; // Continua con el siguiente
    end;
    
    GenerarArbol := ArbolGenerado;
  end;
end;

procedure ImprimirArbol(A: Arbol);
var
  aux: listaCodigos;
begin
  if (A <> nil) then begin
    { 1. Visitamos el hijo izquierdo (Pesos menores) }
    ImprimirArbol(A^.HI);

    { 2. Procesamos el nodo actual }
    writeln('--- Peso: ', A^.data.peso, ' ---');
    write('Codigos: ');
    
    { RECORRIDO DE LA LISTA INTERNA }
    aux := A^.data.codigos;
    while (aux <> nil) do begin
      write(aux^.codigo, ' | ');
      aux := aux^.sig;
    end;
    writeln; { Salto de línea para el próximo peso }

    { 3. Visitamos el hijo derecho (Pesos mayores) }
    ImprimirArbol(A^.HD);
  end;
end;

procedure liberarListaCodigos(var L: listaCodigos);
var
  aux: listaCodigos;
begin
  while (L <> nil) do begin
    aux := L;
    L := L^.sig;
    dispose(aux);
  end;
end;

procedure liberarLista(var L: lista);
var
  aux: lista;
begin
  while (L <> nil) do begin
    aux := L;
    L := L^.sig;
    dispose(aux);
  end;
end;

procedure liberarArbol(var A: Arbol);
begin
  if (A <> nil) then begin
    { 1. Ir hasta el fondo de las ramas }
    liberarArbol(A^.HI);
    liberarArbol(A^.HD);
    
    { 2. Liberar la lista de códigos de este nodo }
    liberarListaCodigos(A^.data.codigos);
    
    { 3. Liberar el nodo actual del árbol }
    dispose(A);
    A := nil; // Buena práctica para evitar punteros colgantes
  end;
end;

Var

 l: lista;
 ArbolPesos: Arbol;

begin
 Randomize;

 crearLista(l);
 writeln ('[x] Lista de encomiendas generada.');
 writeln ('Se imprimirá la lista de encomiendas a continuacion: ');
 imprimirLista(l);
 
 Separador();
 
  writeln('Se va a cargar la lista generada a un arbol para procesamiento por peso mas eficiente.');
  
  ArbolPesos := GenerarArbol(l);
  
  if ArbolPesos <> nil then writeln('[x] Se genero el arbol con exito.');
  
  Separador();
  
  
  writeln('Se imprimirá el arbol de pesos a continuacion:');
  ImprimirArbol(ArbolPesos);
  
  LiberarLista(l);
  LiberarArbol(ArbolPesos)
end.
