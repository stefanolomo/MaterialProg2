program EstadisticasDeportivas;

Uses
     sysutils;
Type
     str10 = string[10];
     jugador = record
            dni: longint;
	          nombreApellido: string;
	          posicion: str10;
            puntaje: longint;
     end;

     lista = ^nodoLista;
     
     nodoLista = record
               dato: jugador;
               sig: lista;
     end;

     partido = record
               estadio: string;
               equipoLocal: string;
               equipoVisitante: string;
               fecha: str10;
               jugadores: lista;
     end;

     listaPartidos = ^nodoPartido;
     nodoPartido = record
               dato: partido;
               sig: listaPartidos;
     end;
  
  listaJugados = ^NodoListaJugados;
  
  NodoListaJugados = record
    puntaje: longint;
    fecha: string;
    sig: listaJugados;
  end;
  
  datoJugador = record
    nombreApellido, posicion: string;
    dni: longint;
    partidosJugados: listaJugados;
  end;

  ArbolJugadores = ^NodoArbolJugadores;
  NodoArbolJugadores = record
    dato: datoJugador;
    HI, HD: ArbolJugadores;
  end;

procedure cargarFecha(var s: str10);
var
  dia, mes: longint;
begin
  dia := random(30)+1;
  mes := random(12)+1;
  if(mes = 2) and (dia > 28)then
	dia := 31;
  if((mes = 4) or (mes = 6) or (mes =9) or (mes = 11)) and (dia = 31)then
	dia := 30;
  s := Concat('2022/',IntToStr(mes),'/',IntToStr(dia));
end;

Procedure agregar(var l: listaPartidos; p: partido);
var
   aux: listaPartidos;
begin
     new(aux);
     aux^.dato := p;
     aux^.sig := l;
     l:= aux;
end;

Procedure agregarJugador(var l: lista; j: jugador);
var
   aux: lista;
begin
     new(aux);
     aux^.dato := j;
     aux^.sig := l;
     l:= aux;
end;

procedure cargarJugadores(var l: lista);
var
   j: jugador;
   cant, i, pos: longint;
begin
     cant := random(10)+22;
     for i:=1 to cant do
     begin
          with(j) do begin
              dni := random(36000000)+20000000;
	      nombreApellido:= Concat('Jugador-', IntToStr(dni));
	      pos:= random(4)+1;
              case pos of
                1: posicion:= 'arquero';
                2: posicion:= 'defensa';
                3: posicion:= 'mediocampo';
                4: posicion:= 'delantero';
              end;
              puntaje:= random(10)+1;
          end;
          agregarJugador(l, j);
     end;
end;

procedure crearLista(var l: listaPartidos);
var
   p: partido;
   cant, i: longint;
begin
     cant := random(10);
     for i:=1 to cant do
     begin
          with(p) do begin
               estadio:= Concat('Estadio-', IntToStr(random (500)+1));
               equipoLocal:= Concat('Equipo-', IntToStr(random (200)+1));
               equipoVisitante:= Concat('Equipo-', IntToStr(random (200)+1));
               cargarFecha(fecha);
               jugadores:= nil;
               cargarJugadores(jugadores);
          end;
          agregar(l, p);
     end;
end;



procedure imprimirJugador(j: jugador);
begin
     with (j) do begin
          writeln('Jugador: ', nombreApellido, ' con dni ',dni, ' en posicion: ', posicion, ' y puntaje: ', puntaje);
     end;
end;

procedure imprimirJugadores(l: lista);
begin
     while (l <> nil) do begin
          imprimirJugador(l^.dato);
          l:= l^.sig;
     end;
end;

procedure imprimirPartido(p: partido);
begin
     with (p) do begin
          writeln('');
          writeln('Partido en el ', estadio, ' entre ',equipoLocal, ' y ', equipoVisitante, ' jugado el: ', fecha, ' por los siguientes jugadores: ');
          imprimirJugadores(jugadores);
     end;
end;

procedure imprimirLista(l: listaPartidos);
begin
     while (l <> nil) do begin
          imprimirPartido(l^.dato);
          l:= l^.sig;
     end;
end;

procedure InsertarEnArbolJugadores(var A: ArbolJugadores; P: partido; J: jugador);

var
  aux: listaJugados;

begin
  if (A = nil) then begin
    new(A);
    A^.HI := nil;
    A^.HD := nil;
    
    {NodoListaJugados = record
    puntaje: longint;
    fecha: string;
    sig: listaJugados;
  end;
  
  datoJugador = record
    nombreApellido, posicion: string;
    dni: longint;
    partidosJugados: listaJugados;
  end;}
    
    // Para el jugador
    A^.dato.dni := J.dni;
    A^.dato.nombreApellido := J.nombreApellido;
    A^.dato.posicion := J.posicion;
    
    // Para el partido (Agregamos al principio)
    new(A^.dato.partidosJugados); // Reservamos espacio
    
    A^.dato.partidosJugados^.fecha := P.fecha; // Reemplazamos al primero por los datos entrantes
    A^.dato.partidosJugados^.puntaje := J.puntaje;
    
    A^.dato.partidosJugados^.sig := nil; // Acoplamos el puntero guardado al siguiente del nuevo
  end else if (A^.dato.dni < J.dni) then
    InsertarEnArbolJugadores(A^.HD, P, J)
  else if (A^.dato.dni > J.dni) then
    InsertarEnArbolJugadores(A^.HI, P, J)
  else begin
    new(aux); // Reservamos espacio
    
    aux^.fecha := P.fecha; // Guardamos los datos
    aux^.puntaje := J.puntaje;
    
    aux^.sig := A^.dato.partidosJugados; // El siguiente es los partidos que ya tenia
    A^.dato.partidosJugados := aux; // Aux es cabeza de lista ahora
  end;
end;

function CargarArbolJugadores (L: listaPartidos): ArbolJugadores;

var
  aux: lista;
  ArbolCargado: arbolJugadores;

begin
  if (L = nil) then
    CargarArbolJugadores := nil
  else begin
    ArbolCargado := nil;
    
    while (L <> nil) do begin
      aux := L^.dato.jugadores;
      while (aux <> nil) do begin
        InsertarEnArbolJugadores(ArbolCargado, L^.dato, aux^.dato);
        aux := aux^.sig;
      end;
      L := L^.sig;
    end;
    
    CargarArbolJugadores := ArbolCargado
  end;
end;

procedure imprimirReporte(A: ArbolJugadores);

var
  aux: listaJugados;
  contadorPartidos, contadorPuntaje: longint;

begin
  if (A <> nil) then begin
    imprimirReporte(A^.HI);
    
    aux := A^.dato.partidosJugados;
    contadorPartidos := 0;
    contadorPuntaje := 0;
    
    while (aux <> nil) do begin
      contadorPartidos := contadorPartidos + 1;
      contadorPuntaje := contadorPuntaje + aux^.puntaje;
      aux := aux^.sig;
    end;
    
    writeln('El jugador ', A^.dato.nombreApellido, ' tiene dni ', A^.dato.dni, ' y juega en la posicion ', A^.dato.posicion, '. Jugo ', contadorPartidos, ' y en ellos acumulo ', contadorPuntaje, ' puntos');
    
  imprimirReporte(A^.HD);
  end;
end;

function BuscarAcotadoArbolJugadores(A: arbolJugadores; sup, inf: longint): longint;

begin
  BuscarAcotadoArbolJugadores := 0;
  if (A <> nil) then begin
    if (A^.dato.dni < sup) and (A^.dato.dni > inf) then
      BuscarAcotadoArbolJugadores := 1 + BuscarAcotadoArbolJugadores(A^.HI, sup, inf) + BuscarAcotadoArbolJugadores(A^.HD, sup, inf)
    else if (A^.dato.dni < sup) then
      BuscarAcotadoArbolJugadores := BuscarAcotadoArbolJugadores + BuscarAcotadoArbolJugadores(A^.HD, sup, inf)
    else
      BuscarAcotadoArbolJugadores := BuscarAcotadoArbolJugadores + BuscarAcotadoArbolJugadores(A^.HI, sup, inf);
  end;
end;

var
   l: listaPartidos;
   ArbolNuevo: ArbolJugadores;
begin
     Randomize;

     l:= nil;
     crearLista(l); {carga automática de la estructura disponible}
     writeln ('Lista generada: ');
     imprimirLista(l);


  writeln('Se va a cargar la lista en el arbol ordenado por DNI');
  
  ArbolNuevo := CargarArbolJugadores(l);
  
  writeln('Se va a imprimir el arbol: ');
  
  imprimirReporte(ArbolNuevo);
  
  writeln('Jugadores con DNI entre 25 millones y 30 millones: ', BuscarAcotadoArbolJugadores(ArbolNuevo, 30000000, 25000000));
end.
