
Program ActColaborativa;

Type
    datarbol =   Record
        nombre:   string;
        distancia:   real;
        ventas:   integer;
    End;

    // Arbol con datos
    arbol =   ^nodoA;
    nodoA =   Record
        datos:   datarbol;
        HI:   arbol;
        HD:   arbol;
    End;

Procedure enOrden( A: arbol );
Begin
    If ( A <> Nil ) Then
        Begin
            enOrden (a^.HI);
            Writeln('Nombre: ', A^.datos.nombre,
                '  Distancia: ', A^.datos.distancia:0:2,
                '  Ventas: ', A^.datos.ventas);
            enOrden (a^.HD)
        End;
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
Procedure Separador();
Begin
    writeln('');
    writeln('');
    writeln('----------------------------------------');
    writeln('');
End;
Procedure cargarDestino(Var a:arbol);

Var datos:   datarbol;
Begin
    write('inserte destino:');
    readln(datos.nombre);
    write('inserte distancia:');
    readln(datos.distancia);
    write('inserte ventas:');
    readln(datos.ventas);

    writeln();
End;
Procedure inicializar (Var a:arbol);
Begin
    a := Nil;
    writeln('Inicializando estructura...');
    delay(1000);
    writeln('Estructura inicializada ...');
End;

//Programa Principal

Var

    a:   arbol;
    decision:   integer;

Begin
    writeln('Bienvenido Al Programa De Gestion De Viajes en autobus')
    decision := 999;
    While (decision<>0) Do Begin
          writeln('Menu De Opciones:');
          writeln('1-Inicializar Estructura De Datos (Necesario para funcionamiento)');
          writeln('2-Cargar Destinos');
          writeln('3-imprimir Informacion Contenida');
          writeln('4-Buscar Destino Y Mostrar Su Informacion');
          writeln('5-Buscar Destino Mas Cercano');
          writeln('6-Sumar Pasajes A Un Destino');
          writeln('0-Terminar');
          writeln;
          write('Inserte Opcion:');readln(decision);
          while (decision<0)or(decision>6)do begin
             writeln('Inserte Opcion Valida:');readln(decision);
          end;
          if (decision=1)then
             Inicializar(a);
          if (decision=2)then
             Cargar(a);
        end;
End.
