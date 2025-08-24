
Program ActColaborativa;

Type
    datarbol = record
    nombre: string;
    distancia: real;
    ventas: integer;
    end;

    // Arbol con datos
    arbol =   ^nodoA;
    nodoA =   Record
        datos:   datarbol;
        HI:   arbol;
        HD:   arbol;
    End;

Procedure InsertarIntegerNodoArbol(Var A: arbol; datos: datarbol);

Var
    aux:   arbol;

Begin
    new(aux);

    aux^.datos := datos;
    aux^.HI := Nil;
    aux^.HD := Nil;

    A := aux;
End;

Procedure InsertarIntegerArbol(Var A: arbol; datos: datarbol);

Begin
    If (A = Nil) Then
        InsertarIntegerNodoArbol(A, dato)
    Else If (A^.dato > dato) Then
             InsertarIntegerArbol(A^.HI, dato)
    Else
        InsertarIntegerArbol(A^.HD, dato)
End;
procedure Separador();
begin
    writeln('');
    writeln('');
    writeln('----------------------------------------');
    writeln('');
end;
procedure cargarDestino(var a:arbol);
var datos:datarbol;
begin
  write('inserte destino:');readln(datos.nombre);
  write('inserte distancia:');readln(datos.distancia);
  write('inserte ventas:');readln(datos.ventas);

  writeln();
end;
procedure inicializar (var a:arbol);
begin
  a:=nil;
  writeln('Inicializando estructura...');
  delay(1000);
  writeln('Estructura inicializada ...');
end;

//Programa Principal
Var

    a:   arbol;
    decision: integer;

Begin
writeln('Bienvenido Al Programa De Gestion De Viajes en autobus')
decision:=999;
while (decision<>0)do
begin
End.

