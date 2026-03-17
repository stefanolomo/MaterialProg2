program ej2;

type
  vuelo = record
    cod, clase: string;
    millas: integer;
  end;

  ListaVuelos = ^NodoListaVuelos;
  NodoListaVuelos = record
    dato: vuelo;
    sig: ListaVuelos
  end;

  venta = record
    nombreApellido: string;
    dni: longint;
    vuelos: listavuelos;
  end;
  
  ArbolPasajeros = ^NodoArbolPasajeros;
  NodoArbolPasajeros = record
    dato: venta;
    HI, HD: ArbolPasajeros;
  end;

procedure InsertarArbolPasajeros(var A: ArbolPasajeros; V: venta);

{var
  aux: ListaVuelos;}

begin
  if (A = nil) then begin
    new(A);
    A^.HI := nil;
    A^.HD := nil;
    A^.dato := V;
    
  end else begin
    if (A^.dato.dni < V.dni) then
      InsertarArbolPasajeros(A^.HD, V)
    else if (A^.dato.dni > V.dni) then
      InsertarArbolPasajeros(A^.HI, V)
    else begin // Es el mismo pasajero, agregamos a la lista de viajes
      {new(aux); // Creamos el auxiliar
      
      // Lo llenamos con el dato del vuelo incoming
      aux^.dato.cod := V.vuelos^.dato.cod;
      aux^.dato.clase := V.vuelos^.dato.clase;
      aux^.dato.millas := V.vuelos^.dato.millas;
      aux^.sig := A^.dato.vuelos; // Lo que le sigue es lo que habia antes
      
      // Ahora aux es la cabeza de lista
      A^.dato.vuelos := aux;}
      
      {Otra manera de hacerlo, es usar el puntero que esta adentro de V. Se ahorra usar la variable auxiliar.}
      
      V.vuelos^.sig := A^.dato.vuelos; // Lo que le sigue es lo que habia antes
      A^.dato.vuelos := V.vuelos; // Ahora V.vuelos es cabeza de lista
    end;
  end;
end;

function LeerVenta(): venta;

var
  V: venta;

begin
  writeln('Dni (0 para terminar): ');
  readln(V.dni);
  
  if (V.dni > 0) then begin
    writeln('Nombre y Apellido: ');
    readln(V.nombreApellido);
    
    new(V.vuelos);
    V.vuelos^.sig := nil;
    
    writeln('Codigo de vuelo: ');
    readln(V.vuelos^.dato.cod);
    
    writeln('Millas recorridas: ');
    readln(V.vuelos^.dato.millas);
    
    writeln('Clase volada: ');
    readln(V.vuelos^.dato.clase);
  end;
  
  LeerVenta := V;
end;

function CargarArbolPasajeros(): ArbolPasajeros;

var
  ArbolCargado: ArbolPasajeros;
  V: venta;

begin
  ArbolCargado := nil;
  
  repeat
    V := LeerVenta();
    
    if (V.dni > 0) then
      InsertarArbolPasajeros(ArbolCargado, V);
  until (V.dni <= 0);
  
  CargarArbolPasajeros := ArbolCargado;
end;

var
  ArbolNuevo: ArbolPasajeros;

begin
  ArbolNuevo := CargarArbolPasajeros();
end.
