Program ejercicio1;
Uses
     sysutils;
Type
     str10= string[10];
     jugador = record
              dni: longint;
	          nombreApellido: string;
	          posicion: str10;
              puntaje: integer;
     end;

     ListaPuntajes = ^nodopuntajes;
     nodopuntajes = record
                  puntaje:integer;
                  fecha: str10;
                  sig:ListaPuntajes;
     end;
     jugadorypuntajes = record
              dni: longint;
	          nombreApellido: string;
	          posicion: str10;
              puntajes: ListaPuntajes;
     end;


     lista = ^nodoLista;
     nodoLista = record
               dato: jugador;
               sig: lista;
     end;

     partido= record
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

     arbol =   ^nodoA;
     nodoA =   Record
         dato:   jugadorypuntajes;
         HI:   arbol;
         HD:   arbol;
     End;


procedure cargarFecha(var s: str10);
var
  dia, mes: integer;
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
   cant, i, pos: integer;
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
   cant, i: integer;
begin
     cant := random(10)+1;
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

Procedure Separador();
Begin
    writeln('');
    writeln('');
    writeln('----------------------------------------');
    writeln('');
End;

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

procedure imprimir(p: partido);
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
          imprimir(l^.dato);
          l:= l^.sig;
     end;
end;

Procedure agregarPuntaje(Var l: ListaPuntajes; Puntaje:integer; fecha:str10);

Var
    aux:   listaPuntajes;
Begin
    new(aux);
    aux^.puntaje := puntaje;
    aux^.fecha:=fecha;
    aux^.sig := l;
    l := aux;
End;

Procedure InsertarJugadorNodoArbol(Var A: arbol; dato: Jugador; fecha: str10);

Var
    aux:   arbol;

Begin
    new(aux);

    aux^.dato.dni := dato.dni;
    aux^.dato.nombreApellido := dato.nombreApellido;
    aux^.dato.posicion := dato.posicion;
    aux^.dato.puntajes:=nil;
    AgregarPuntaje(aux^.dato.puntajes,dato.puntaje,fecha);
    aux^.HI := Nil;
    aux^.HD := Nil;

    A := aux;
End;

Procedure InsertarJugadorArbol(Var A: arbol; dato: jugador; fecha: str10);

Begin
    If (A = Nil) Then
        InsertarJugadorNodoArbol(A, dato,fecha)
    Else If (A^.dato.dni > dato.dni) Then
             InsertarJugadorArbol(A^.HI, dato,fecha)
    Else if (A^.dato.dni < dato.dni) then
        InsertarJugadorArbol(A^.HD, dato,fecha)
         else agregarPuntaje(A^.dato.puntajes,dato.puntaje,fecha);
End;

Procedure InsertarArbolDesdeLista(L: ListaPartidos; Var A: arbol);
var listaJ:lista;
Begin
    While (L <> Nil) Do
        Begin
            ListaJ:=l^.dato.jugadores;
            While (ListaJ<>Nil)do
                begin
                InsertarJugadorArbol(A, ListaJ^.dato,L^.dato.fecha);
                ListaJ:=ListaJ^.sig;
                end;
            L := L^.sig;
        End;
End;

Procedure ImprimirPuntajes(l:listapuntajes);
var suma:integer;
begin
    suma:=0;
    while (l<>nil)do
        begin
            writeln(l^.fecha,': ',l^.puntaje);
            suma:=suma + l^.puntaje;
            l:=l^.sig;
        end;
    writeln('Puntaje total: ',suma);
end;

Procedure ImprimirJugador2(dato:jugadorypuntajes);
begin
  writeln('Jugador: ',dato.nombreApellido,' con dni: ',dato.dni,' y posicion: ',dato.posicion);
  writeln('Puntajes: ');
  ImprimirPuntajes(dato.puntajes);
  writeln;

end;

Procedure EnOrdenDescendiente (A:arbol);
begin
    if (A <> Nil) then
        begin
            EnOrdenDescendiente(A^.HD);
            ImprimirJugador2(A^.dato);
            EnOrdenDescendiente(A^.HI);
        end;
end;

Procedure ImprimirCantEnRango(a: arbol; inf:longint; sup:longint;var cant:integer);
Begin
    If (a <> Nil) Then
        If (a^.dato.dni >= inf) Then
            If (a^.dato.dni <= sup) Then Begin
                ImprimirCantEnRango(a^.hi, inf, sup,cant);
                cant:=cant+1;
                ImprimirCantEnRango (a^.hd, inf, sup,cant);
            End Else
                ImprimirCantEnRango(a^.hi, inf, sup,cant)
        Else ImprimirCantEnRango(a^.hd, inf, sup,cant);
End;

Procedure ContarSegunPosicion (A:arbol; pos:str10; var cant:integer);
begin
    if (A <> Nil) then
        begin
            ContarSegunPosicion(A^.HD,pos,cant);
            if (A^.dato.posicion=pos)then cant:=cant+1;
            ContarSegunPosicion(A^.HI,pos,cant);
        end;
end;
var
   l: listaPartidos;
   A: arbol;
   cant:integer;
   pos:str10;
begin
     Randomize;

     l:= nil;
     crearLista(l); {carga automática de la estructura disponible}
     writeln ('Lista generada: ');
     imprimirLista(l);

     separador();
     {A)se crea estructura ordenada segun DNI, con los datos de jugadores y sus puntajes/Fechas}
     A:=nil;
     InsertarArbolDesdeLista(l,A);

     {B) Se informa los datos de cada jugador y sus puntajes de manera de DNI descendente}
     EnOrdenDescendiente(A);

     separador();
     {C) se informa la cantidad de jugadores con DNI entre 30m y 40m}
     cant:=0;
     ImprimirCantEnRango(A,30000000,40000000,cant);
     writeln('La cantidad de jugadores con DNI entre 30 millones y 40 millones son: ',cant);

     separador();
     {D) se informa la cantidad de jugadores con una posicion pedida por teclado}
     cant:=0;
     write('inserte posicion a contar: ');readln(pos);
     while (pos<>'delantero')and(pos<>'defensa')and(pos<>'mediocampo')and(pos<>'arquero')do
         begin
             write('inserte posicion valida(delantero/defensa/mediocampo/arquero): ');readln(pos);
         end;
     ContarSegunPosicion(A,pos,cant);
     writeln('La cantidad de jugadores con posicion ',pos,' son: ',cant);

     writeln('Fin del programa');
     readln;
end.