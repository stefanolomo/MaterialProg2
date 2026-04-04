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
    anio: integer;
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
  

procedure cargarFecha(var f: fecha);
var
  anio: integer;
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
  cant, i, pos: integer;
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
  cant, i, pos, tiene_hotel: integer;
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

var
  l: listaPaquetes;
begin
  Randomize;

  l := nil;
  crearLista(l); {carga automatica de la estructura disponible}
  writeln('LISTA GENERADA: ');
  imprimirLista(l);

  {Completar el programa}

  writeln('Fin del programa');
  readln;
end.
