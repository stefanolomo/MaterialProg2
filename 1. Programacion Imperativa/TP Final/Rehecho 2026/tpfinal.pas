program tpfinal;

uses
  sysutils;

type
  str70 = string[70];
  
  equipaje = 1..3;
  paises = 1..15;

  destino = record
    nombre: str70;
    pais: str70;
  end;

  lista = ^nodoLista;
  nodoLista = record
    dato: destino;
    sig: lista;
  end;

  fecha = record
    dia: 1..31;
    mes: 1..12;
    anio: longint;
  end;
  
  paquete = record
    identificador: str70;
    fecha: fecha;
    aerolinea: str70;
    cant_equipaje: equipaje;
    hotel: boolean;
    destinos: lista;
  end;

  listaPaquetes = ^nodoPaquetes;
  nodoPaquetes = record
    dato: paquete;
    sig: listaPaquetes;
  end;

  nombres = array [1..20] of str70;

  numeros = set of paises;

  {--------------------}
  
  DatoNodoListaPaquetes = record
    identificador, aerolinea: str70;
    fecha: fecha;
    equipaje: equipaje;
    hotel: boolean;
  end;
  
  ListaPaquetesA = ^NodoListaPaquetes;
  NodoListaPaquetes = record
    dato: DatoNodoListaPaquetes;
    sig: ListaPaquetesA;
  end;
  
  destinoa = record
    nombre, pais: str70;
    paquetes: ListaPaquetesA;
  end;
  
  Arbol = ^NodoArbol;
  NodoArbol = record
    dato: destinoa;
    HI, HD: Arbol;
  end;

procedure cargarFecha(var f: fecha);
var
  anio: longint;
begin
  f.dia := random(30) + 1;
  f.mes := random(12) + 1;
  anio := random(2) + 1;
  case anio of
    1: f.anio := 2025;
    2: f.anio := 2026;
  end;
end;

procedure agregar(var l: listaPaquetes; p: paquete);
var
  aux: listaPaquetes;
begin
  new(aux);
  aux^.dato := p;
  aux^.sig := l;
  l := aux;
end;

procedure agregarDestino(var l: lista; d: destino);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := d;
  aux^.sig := l;
  l := aux;
end;

procedure cargarPaises(var v: nombres);
begin
  v[1] := 'España';
  v[2] := 'Francia';
  v[3] := 'Argentina';
  v[4] := 'Japon';
  v[5] := 'Turquia';
  v[6] := 'Estados Unidos';
  v[7] := 'Mexico';
  v[8] := 'Brasil';
  v[9] := 'Portugal';
  v[10] := 'Panama';
  v[11] := 'Ecuador';
  v[12] := 'Chile';
  v[13] := 'Colombia';
  v[14] := 'Inglaterra';
  v[15] := 'Italia';
end;

procedure cargarNombres(var v: nombres);
begin
  v[1] := 'Madrid';
  v[2] := 'Paris';
  v[3] := 'Buenos Aires';
  v[4] := 'Tokio';
  v[5] := 'Estambul';
  v[6] := 'Miami';
  v[7] := 'Cancun';
  v[8] := 'Rio de Janeiro';
  v[9] := 'Lisboa';
  v[10] := 'Islas San Blas';
  v[11] := 'Islas Galapagos';
  v[12] := 'Santiago';
  v[13] := 'Cartagena';
  v[14] := 'Londres';
  v[15] := 'Roma';
end;

procedure cargarAerolineas(var v: nombres);
begin
  v[1] := 'Aerolineas Argentinas';
  v[2] := 'Iberia';
  v[3] := 'American Airlines';
  v[4] := 'Emirates';
  v[5] := 'Air France';
  v[6] := 'Air Canada';
  v[7] := 'Qatar Airways';
  v[8] := 'LATAM';
  v[9] := 'Copa Airlines';
  v[10] := 'Lufthansa';
end;

procedure cargarDestinos(var l: lista);
var
  d: destino;
  cant, i, pos: longint;
  p, n: nombres;
  no_repetidos: numeros;
begin
  cargarPaises(p);
  cargarNombres(n);
  no_repetidos := [];
  cant := random(3) + 1;
  for i := 1 to cant do
  begin
    with d do begin
      pos := random(15) + 1;
      while (pos in no_repetidos) do
        pos := random(15) + 1;
      no_repetidos := no_repetidos + [pos];
      nombre := n[pos];
      pais := p[pos];
      pos := random(15) + 1;
    end;
    agregarDestino(l, d);
  end;
end;

procedure crearLista(var l: listaPaquetes);
var
  p: paquete;
  cant, i, pos, tiene_hotel: longint;
  a: nombres;
begin
  cant := random(100) + 1;
  cargarAerolineas(a);
  for i := 1 to cant do
  begin
    with p do begin
      identificador := concat('PAQ-', IntToStr(random(1000000) + 1));
      cargarFecha(fecha);
      pos := random(10) + 1;
      aerolinea := a[pos];
      cant_equipaje := random(3) + 1;
      tiene_hotel := random(8);
      if (tiene_hotel mod 2 <> 0) then
        hotel := false
      else
        hotel := true;
      destinos := nil;
      cargarDestinos(destinos);
    end;
    agregar(l, p);
  end;
end;

procedure imprimirDestino(d: destino);
begin
  with d do begin
    writeln('DESTINO: ', nombre, ' | PAIS: ', pais);
  end;
end;

procedure imprimirDestinos(l: lista);
begin
  while (l <> nil) do begin
    imprimirDestino(l^.dato);
    l := l^.sig;
  end;
end;

procedure imprimir(p: paquete);
var
  tiene_hotel: str70;
begin
  with p do begin
    if (hotel) then
      tiene_hotel := 'Si'
    else
      tiene_hotel := 'No';
    writeln('');
    writeln('PAQUETE: ', identificador, ' | FECHA: ', fecha.dia, '/', fecha.mes, '/', fecha.anio, ' | AEROLINEA: ', aerolinea, ' | EQUIPAJE: ', cant_equipaje, ' | TIENE HOTEL?: ', tiene_hotel);
    imprimirDestinos(destinos);
  end;
end;

procedure imprimirLista(l: listaPaquetes);
begin
  while (l <> nil) do begin
    imprimir(l^.dato);
    l := l^.sig;
  end;
end;

procedure InsertarEnListaPaquetesA(var L: ListaPaquetesA; P: paquete);

var
  aux, nodoInsertar: ListaPaquetesA;

begin
  new(nodoInsertar); // Se crea el nodo a insertar
  nodoInsertar^.dato.identificador := P.identificador;
  nodoInsertar^.dato.fecha := P.fecha;
  nodoInsertar^.dato.aerolinea := P.aerolinea;
  nodoInsertar^.dato.equipaje := P.cant_equipaje;
  nodoInsertar^.dato.hotel := P.hotel;
  nodoInsertar^.sig := nil; // El siguiente es nil porque insertamos al final
  
  if (L = nil) then
    L := nodoInsertar // Si esta vacia, es la raiz
  else begin
    // Si la lista no esta vacia
    aux := L;
    
    while (aux^.sig <> nil) do begin // Recorremos hasta el ultimo nodo
      aux := aux^.sig;
    end;
    
    aux^.sig := nodoInsertar; // Enganchamos al final
  end;
end;

procedure InsertarDestinoEnArbol(var A: Arbol; nombre, pais: str70; P: paquete);

begin
  if (A = nil) then begin
    // Si el arbol esta vacio
    new(A); // Crear el arbol
    A^.dato.nombre := nombre;
    A^.dato.pais := pais;
    A^.HI := nil;
    A^.HD := nil;
    A^.dato.paquetes := nil;
    
    InsertarEnListaPaquetesA(A^.dato.paquetes, P); // Insertar en la lista el paquete
  end else if (A^.dato.nombre = nombre) then
    // Si el destino ya existe en el arbol, solo se agrega los datos del paquete
    InsertarEnListaPaquetesA(A^.dato.paquetes, P)
  else if (A^.dato.nombre > nombre) then
    InsertarDestinoEnArbol(A^.HI, nombre, pais, P)
  else if (A^.dato.nombre < nombre) then
    InsertarDestinoEnArbol(A^.HD, nombre, pais, P)
end;

procedure InsertarPaqueteEnArbol(var A: Arbol; P: paquete);

var
  aux: lista;

begin
  aux := P.destinos;
  while (aux <> nil) do begin
    InsertarDestinoEnArbol(A, aux^.dato.nombre, aux^.dato.pais, P);
    aux := aux^.sig;
  end;
end;

procedure CargarArbolDestinos(var A: Arbol; L: listaPaquetes);
begin
  while (L <> nil) do begin
    InsertarPaqueteEnArbol(A, L^.dato); // Llamamos al nuevo procedure
    L := L^.sig;
  end;
end;

function HayPaqueteConOcurrencia(L: ListaPaquetesA): boolean;

begin
  // Recibe una lista de paquetes y debe recorrerla hasta encontrar uno que coincida con criterios indicados
  
  // Recorre la lista mientras no llegue al final o mientras no coincida
  while (L <> nil) and not (((L^.dato.aerolinea = 'Iberia') or (L^.dato.aerolinea = 'Emirates')) and (L^.dato.equipaje = 3) and (L^.dato.hotel) and (L^.dato.fecha.anio = 2026) and (L^.dato.fecha.mes in [1, 2, 3])) do
    L := L^.sig;
  // Si llego al final, no hay ocurrencias (Es nil)
  // Si no esta en el final, hay al menos una ocurrencia (No es nil)
  HayPaqueteConOcurrencia := (L <> nil);
end;

function HallarOcurrenciasDestinos(A: Arbol): longint;

begin
  if (A = nil) then
    HallarOcurrenciasDestinos := 0
  else begin
    // Si coincide, devolver 1 + ocurrencias de rama izquierda + ocurrencias de rama derecha
    if (HayPaqueteConOcurrencia(A^.dato.paquetes)) then HallarOcurrenciasDestinos := 1 + HallarOcurrenciasDestinos(A^.HI) + HallarOcurrenciasDestinos(A^.HD)
    // Si no coincide, devolver ocurrencias de rama izquierda + ocurrencias de rama derecha
    else HallarOcurrenciasDestinos := HallarOcurrenciasDestinos(A^.HI) + HallarOcurrenciasDestinos(A^.HD);
  end;
end;

procedure ImprimirData(D: destinoa);

begin
  writeln('> Nombre: ', D.nombre, ' Pais: ', D.pais);
end;

Procedure ImprimirEnRangoNombre(A: Arbol; inf, sup: str70);

begin
  if (A <> nil) then begin
    if (A^.dato.nombre >= inf) then begin
      if (A^.dato.nombre <= sup) then begin
        // Esta en el rango
        ImprimirEnRangoNombre(A^.HI, inf, sup);
        ImprimirData(A^.dato);
        ImprimirEnRangoNombre(A^.HD, inf, sup);
      end else
        ImprimirEnRangoNombre(A^.HI, inf, sup);
    end else
      ImprimirEnRangoNombre(A^.HD, inf, sup);
  end;
end;

procedure ImprimirDataListaPaquetesA(L: ListaPaquetesA);

var
  tieneHotel: string;

begin
  while (L <> nil) do begin
    if L^.dato.hotel then tieneHotel := 'Si' else tieneHotel := 'No';
    
    writeln('  - Paquete: ', L^.dato.identificador, 
            ' | Fecha: ', L^.dato.fecha.dia, '/', L^.dato.fecha.mes, '/', L^.dato.fecha.anio,
            ' | Aerolinea: ', L^.dato.aerolinea, 
            ' | Equipaje: ', L^.dato.equipaje, 
            ' | Hotel: ', tieneHotel);
    
    writeln('--------------------');
    
    L := L^.sig;
  end;
end;

procedure ImprimirArbol(A: Arbol);

begin
  if (A <> nil) then begin
    ImprimirArbol(A^.HI);
    ImprimirData(A^.dato); // Imprime el pais y nombre
    ImprimirDataListaPaquetesA(A^.dato.paquetes); // Imprimir los paquetes
    ImprimirArbol(A^.HD);
  end;
end;

procedure LiberarListaPaquetesA(var L: listaPaquetesA);

var
  aux: listaPaquetesA;

begin 
  while (L <> nil) do begin
    aux := L;
    L := L^.sig;
    dispose(aux);
  end;
end;

function ContarPaquetes(L: ListaPaquetesA): longint;

var
  total: longint;

begin
  total := 0;
  
  while (L <> nil) do begin
    total := total + 1; 
    L := L^.sig;
  end;
  
  ContarPaquetes := total;
end;

procedure Separador();

begin
  writeln(' ');
  writeln('--------------------');
  writeln(' ');
end;


procedure Reemplazar(var A: Arbol; var Aux: Arbol);

var
  nodoAEliminar: Arbol;
  
begin
  if (Aux^.HD <> nil) then
    Reemplazar(A, Aux^.HD) // Buscamos el mayor de la rama izquierda
  else begin // Encontrado y es aux
    LiberarListaPaquetesA(A^.dato.paquetes); // Borramos la lista de A
    A^.dato := Aux^.dato; // Reemplazamos sus datos
    
    nodoAEliminar := Aux; // Guardamos el nodo en una variable
    Aux := Aux^.HI; // Enganchamos lo que pueda tener a la izquierda (nil o subarbol)
    
    dispose(nodoAEliminar); // Se elimina el nodo repetido
  end;
end;

procedure EliminarNodo(var A: Arbol);

var 
  aux: Arbol;
  
begin
  if (A^.HI = nil) then begin // Si tiene solo hijo derecho
    aux := A;
    A := A^.HD;
    LiberarListaPaquetesA(aux^.dato.paquetes);
    dispose(aux);
  end 
  else if (A^.HD = nil) then begin // Si tiene solo hijo izquierdo
    aux := A;
    A := A^.HI;
    LiberarListaPaquetesA(aux^.dato.paquetes);
    dispose(aux);
  end else // Si tiene los dos hijos
    Reemplazar(A, A^.HI);
end;

procedure BorrarPorNombre(var A: Arbol; nombreAEliminar: str70);

begin
  if (A <> nil) then begin
    if (nombreAEliminar < A^.dato.nombre) then
      BorrarPorNombre(A^.HI, nombreAEliminar)
    else if (nombreAEliminar > A^.dato.nombre) then
      BorrarPorNombre(A^.HD, nombreAEliminar)
    else
      // Es el buscado, hay que eliminarlo
      EliminarNodo(A);
    
  end;
end;

function HallarMenorPaquetes(A: Arbol): Arbol;

var
  minAct, minIzq, minDer: Arbol;
  cantAct, cantIzq, cantDer: longint;

begin
  if (A = nil) then // Si esta vacia, no hay puntero al menor
    HallarMenorPaquetes := nil
  else begin
    // Asumiendo que el menor es el actual
    minAct := A;
    // Buscamos en los subarboles
    minIzq := HallarMenorPaquetes(A^.HI);
    minDer := HallarMenorPaquetes(A^.HD);
    
    cantAct := ContarPaquetes(minAct^.dato.paquetes);
    if (minDer <> nil) then cantDer := ContarPaquetes(minDer^.dato.paquetes);
    if (minIzq <> nil) then cantIzq := ContarPaquetes(minIzq^.dato.paquetes);
    
    if (minIzq <> nil) and (cantIzq < cantAct) then
      minAct := minIzq; // Si el de la izquierda es menor, gana ese
      
    cantAct := ContarPaquetes(minAct^.dato.paquetes);
    
    if (minDer <> nil) and (cantDer < cantAct) then
      minAct := minDer; // Si el de la derecha es menor, gana ese
      
    HallarMenorPaquetes := minAct;
  end;
end;

procedure EliminarMenorPaquetes(var A: Arbol);

var
  NodoEliminar: Arbol;

begin
  if (A <> nil) then begin
    NodoEliminar := HallarMenorPaquetes(A); 
    BorrarPorNombre(A, NodoEliminar^.dato.nombre);
  end;
end;

var
  l: listaPaquetes;
  ArbolDestinos: Arbol;
  ocurrencias: longint;
  
begin
  Randomize;

  l := nil;
  crearLista(l); {carga automatica de la estructura disponible}
  writeln('LISTA GENERADA: ');
  imprimirLista(l);

  {--------------------}
  
  ArbolDestinos := nil;
  CargarArbolDestinos(ArbolDestinos, l);
  
  ocurrencias := HallarOcurrenciasDestinos(ArbolDestinos);
  if (ocurrencias > 0) then writeln('En el arbol hay ', ocurrencias, ' destinos que coinciden con el criterio detallado.')
  else writeln('En el arbol no hay destinos que coinciden con el criterio detallado.');
  
  writeln('Se va a imprimir los nombres y paises de los destinos entre Estambul y Madrid.');
  ImprimirEnRangoNombre(ArbolDestinos, 'Estambul', 'Madrid');
  
  writeln('El arbol se va a imprimir en orden.');
  ImprimirArbol(ArbolDestinos);
  
  writeln('Se va a eliminar del arbol el destino con menos paquetes.');
  EliminarMenorPaquetes(ArbolDestinos);
  ImprimirArbol(ArbolDestinos);
  
  writeln('Se va a mostrar como queda despues de eliminar el destino.');
  ImprimirArbol(ArbolDestinos);
end.
