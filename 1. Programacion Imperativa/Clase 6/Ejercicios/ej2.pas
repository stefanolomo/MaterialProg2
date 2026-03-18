program ej2;

type
  { CORRECCIÓN 1: La estructura ahora guarda directamente los puntos acumulados 
    por código de vuelo, no las millas ni la clase, como pedía el inciso a. }
  vuelo = record
    cod: string;
    puntos: longint; 
  end;

  ListaVuelos = ^NodoListaVuelos;
  NodoListaVuelos = record
    dato: vuelo;
    sig: ListaVuelos
  end;

  pasajero = record
    nombreApellido: string;
    dni: longint;
    vuelos: ListaVuelos;
  end;
  
  ArbolPasajeros = ^NodoArbolPasajeros;
  NodoArbolPasajeros = record
    dato: pasajero;
    HI, HD: ArbolPasajeros;
  end;

{ --- MÓDULOS DE CARGA --- }

procedure InsertarArbol(var A: ArbolPasajeros; dni: longint; nom, cod: string; puntos: longint);
var
  nuevoVuelo: ListaVuelos;
begin
  if (A = nil) then begin
    new(A);
    A^.HI := nil;
    A^.HD := nil;
    A^.dato.dni := dni;
    A^.dato.nombreApellido := nom;
    
    // Creamos el nodo de la lista para su primer vuelo
    new(nuevoVuelo);
    nuevoVuelo^.dato.cod := cod;
    nuevoVuelo^.dato.puntos := puntos;
    nuevoVuelo^.sig := nil;
    
    A^.dato.vuelos := nuevoVuelo;
  end else begin
    if (dni < A^.dato.dni) then
      InsertarArbol(A^.HI, dni, nom, cod, puntos)
    else if (dni > A^.dato.dni) then
      InsertarArbol(A^.HD, dni, nom, cod, puntos)
    else begin 
      // Si ya existe el DNI, simplemente insertamos el vuelo adelante en la lista
      new(nuevoVuelo);
      nuevoVuelo^.dato.cod := cod;
      nuevoVuelo^.dato.puntos := puntos;
      nuevoVuelo^.sig := A^.dato.vuelos; 
      A^.dato.vuelos := nuevoVuelo;
    end;
  end;
end;

function CargarArbolPasajeros(): ArbolPasajeros;
var
  ArbolCargado: ArbolPasajeros;
  dni, millas, puntos: longint;
  nom, cod, clase: string;
begin
  ArbolCargado := nil;
  
  writeln('Dni (0 para terminar): ');
  readln(dni);
  
  while (dni > 0) do begin
    writeln('Nombre y Apellido: ');
    readln(nom);
    writeln('Codigo de vuelo: ');
    readln(cod);
    writeln('Millas recorridas: ');
    readln(millas);
    writeln('Clase volada (ejecutiva/turista): ');
    readln(clase);
    
    // CORRECCIÓN 2: Calculamos los puntos al momento de leer, antes de guardar.
    if (clase = 'ejecutiva') then
      puntos := 100 * millas
    else if (clase = 'turista') then
      puntos := 25 * millas
    else
      puntos := 0; 
      
    InsertarArbol(ArbolCargado, dni, nom, cod, puntos);
    
    writeln('---');
    writeln('Dni (0 para terminar): ');
    readln(dni);
  end;
  
  CargarArbolPasajeros := ArbolCargado;
end;

{ --- MÓDULOS DE PROCESAMIENTO --- }

function SumarPuntos(L: ListaVuelos): longint;
var
  suma: longint;
begin
  suma := 0;
  while (L <> nil) do begin
    suma := suma + L^.dato.puntos;
    L := L^.sig;
  end;
  SumarPuntos := suma;
end;

{ INCISO B: Módulo que devuelve el mayor puntaje total }
function MayorPuntaje(A: ArbolPasajeros): longint;
var
  maximoActual, maximoDer, maximoIzq, maximoTotal: longint;
begin
  if (A = nil) then 
    MayorPuntaje := -1 // Retornamos -1 para ignorarlo en la comparación
  else begin
    maximoActual := SumarPuntos(A^.dato.vuelos);
    maximoIzq := MayorPuntaje(A^.HI);
    maximoDer := MayorPuntaje(A^.HD);
    
    maximoTotal := maximoActual; 
    
    if (maximoIzq > maximoTotal) then 
      maximoTotal := maximoIzq;
    
    if (maximoDer > maximoTotal) then 
      maximoTotal := maximoDer;
      
    MayorPuntaje := maximoTotal;
  end;
end;

{ INCISO C: Módulos para imprimir el máximo en un rango }
procedure BuscarMaximoRango(A: ArbolPasajeros; inf, sup: longint; var maxRango: longint);
var
  puntosActuales: longint;
begin
  if (A <> nil) then begin
    if (A^.dato.dni >= inf) then begin
      if (A^.dato.dni <= sup) then begin
        // CORRECCIÓN 3: Si está en el rango, vemos si su puntaje es el máximo hasta ahora
        puntosActuales := SumarPuntos(A^.dato.vuelos);
        if (puntosActuales > maxRango) then
          maxRango := puntosActuales;
        
        BuscarMaximoRango(A^.HI, inf, sup, maxRango);
        BuscarMaximoRango(A^.HD, inf, sup, maxRango);
      end else
        // Se pasó del límite superior, vamos hacia la izquierda (menores)
        BuscarMaximoRango(A^.HI, inf, sup, maxRango);
    end else
      // No llegó al límite inferior, vamos hacia la derecha (mayores)
      BuscarMaximoRango(A^.HD, inf, sup, maxRango);
  end;
end;

procedure ImprimirMayorPuntajeRangoDni(A: ArbolPasajeros; inf, sup: longint);
var
  maxRango: longint;
begin
  maxRango := -1; // Inicializamos con un valor "imposible"
  BuscarMaximoRango(A, inf, sup, maxRango);
  
  if (maxRango <> -1) then
    writeln('El mayor puntaje en el rango de DNI [', inf, ' - ', sup, '] es de: ', maxRango, ' puntos.')
  else
    writeln('No se encontraron pasajeros en ese rango de DNI.');
end;


{ --- PROGRAMA PRINCIPAL (INCISO D) --- }
var
  ArbolNuevo: ArbolPasajeros;

begin
  ArbolNuevo := CargarArbolPasajeros();
  
  writeln('');
  writeln('--- RESULTADOS ---');
  writeln('El cliente con mayor puntaje en la aerolinea acumula: ', MayorPuntaje(ArbolNuevo), ' puntos.');
  
  ImprimirMayorPuntajeRangoDni(ArbolNuevo, 40000000, 50000000);
end.
