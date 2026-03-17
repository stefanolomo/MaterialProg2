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
