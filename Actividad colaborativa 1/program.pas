
Program ActColaborativa;

Uses crt;

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

Procedure verMinRecorrido(A: arbol; Var valor: real);

Begin

// El minimo de un arbol binario ordenado siempre va a estar a la izquierda de todos los nodos, es decir, va a ser la hoja mas a la izquierda del arbol

    If (A = Nil) Then // El arbol esta vacio
        valor := -1
    Else If (A^.HI = Nil) Then // Estamos en la ultima hoja a la izquierda
             valor := A^.datos.distancia
    Else // Hay que seguir avanzando hacia la izquierda
        verMinRecorrido(A^.HI, valor);
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
    writeln('Bienvenido Al Programa De Gestion De Viajes en autobus');

    decision := 999;

    While (decision<>0) Do
        Begin
            writeln('Menu De Opciones:');
            writeln(
             '1-Inicializar Estructura De Datos (Necesario para funcionamiento)'
            );
            writeln('2-Cargar Destinos');
            writeln('3-imprimir Informacion Contenida');
            writeln('4-Buscar Destino Y Mostrar Su Informacion');
            writeln('5-Buscar Destino Mas Cercano');
            writeln('6-Sumar Pasajes A Un Destino');
            writeln('0-Terminar');
            writeln;
            write('Inserte Opcion:');
            readln(decision);
            While (decision<0)Or(decision>6) Do
                Begin
                    writeln('Inserte Opcion Valida:');
                    readln(decision);
                End;
            If (decision=1)Then
                Inicializar(a);
            If (decision=2)Then
                Cargar(a);
        End;
End.
