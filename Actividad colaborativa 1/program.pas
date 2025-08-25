
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

procedure verMinRecorrido(A: arbol; var valor: real);

begin
    // El minimo de un arbol binario ordenado siempre va a estar a la izquierda de todos los nodos, es decir, va a ser la hoja mas a la izquierda del arbol

    if (A = nil) then // El arbol esta vacio
        valor := -1
    else if (A^.HI = nil) then // Estamos en la ultima hoja a la izquierda
        valor := A^.datos.distancia
    else // Hay que seguir avanzando hacia la izquierda
        verMinRecorrido(A^.HI, valor);
end;

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
        InsertarIntegerNodoArbol(A, datos)
    Else If (A^.datos.nombre > datos.nombre) Then
             InsertarIntegerArbol(A^.HI, datos)
    Else
        InsertarIntegerArbol(A^.HD, datos)
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
    datos.nombre:='';
    while (datos.nombre<>'Fin')and(datos.nombre<>'fin')do
    begin
    writeln;
      write('inserte Destino(Fin para terminar): ');
      readln(datos.nombre);
      if (datos.nombre<>'fin')and(datos.nombre<>'Fin') then begin
      write('inserte Distancia: ');
      readln(datos.distancia);
      write('inserte Ventas: ');
      readln(datos.ventas);
      InsertarIntegerArbol(A,datos);
      end;
    end;
End;

Procedure inicializar (Var a:arbol);
Begin
    a := Nil;
    writeln;
    writeln('Inicializando estructura...');
    writeln;
    writeln('Estructura inicializada ...');
    writeln;
End;

//Programa Principal

Var
    a:   arbol;
    decision:   integer;
    valor:real;

Begin
    writeln('Bienvenido Al Programa De Gestion De Viajes en autobus');
    decision := 999;valor:=9999999;
    While (decision<>0) Do Begin
          writeln;
          writeln('Menu De Opciones:');writeln;
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
             CargarDestino(a);
          if(decision=3)then
             enOrden(a);
          if(decision=4)then

          if(decision=5)then begin
             verMinRecorrido(a,valor);
             writeln('')
          end;
        end;
End.
