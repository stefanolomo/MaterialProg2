
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

Procedure InformarEnOrden( A: arbol );
Begin
    If ( A <> Nil ) Then
        Begin
            InformarEnOrden(a^.HI);
            Writeln('Nombre: ', A^.datos.nombre,
                    '  Distancia: ', A^.datos.distancia:0:2,
                    '  Ventas: ', A^.datos.ventas);
            InformarEnOrden(a^.HD)
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

Procedure LeerDestino(Var a :arbol);

Var
    datos:   datarbol;

Begin
    write('Inserte destino:');
    readln(datos.nombre);
    If datos.nombre <> 'Fin' Then
        Begin
            write('Inserte distancia:');
            readln(datos.distancia);

            write('Inserte ventas:');
            readln(datos.ventas);
        End;
End;

Procedure inicializar (Var a:arbol);
Begin
    a := Nil;
End;

//Programa Principal

Var
    a:   arbol;
    decision:   integer;

Begin
    writeln('Bienvenido Al Programa De Gestion De Viajes en autobus');
    Inicializar(a);
    decision := 999;

    While (decision <> 0) Do
        Begin
        // Writelns
            writeln('Menu De Opciones:');
            writeln('1-Inicializar Estructura De Datos (Necesario para funcionamiento)');
            writeln('2-Cargar Destinos');
            writeln('3-imprimir Informacion Contenida');
            writeln('4-Buscar Destino Y Mostrar Su Informacion');
            writeln('5-Buscar Destino Mas Cercano');
            writeln('6-Sumar Pasajes A Un Destino');
            writeln('0-Terminar');

            Separador();

            write('Inserte Opcion:');
            readln(decision);

            Separador();

        // Decisiones

            While not (decision in [1, 2, 3, 4, 5, 6, 0]) Do
                Begin
                    writeln('Inserte Opcion Valida:');
                    readln(decision);
                End;
            Case decision Of
                1:   writeln(); // Implementar inicializar
                     2:   writeln(); // Implementar Cargar
                          3:   InformarEnOrden(a);
                               4:   BuscarDestino(a); // Implementar
                                    5:   BuscarMasCercano(a); // Implementar
                                         6:   SumarPasajeADestino(a);
                                              0:   exit();
            End;
        End;
End.
