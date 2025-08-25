
Program ActColaborativa;

Uses crt;

Type
    dataDestino =   Record
        nombre:   string;
        distancia:   real;
        ventas:   longint;
    End;

    // Arbol con datos
    arbol =   ^nodoA;
    nodoA =   Record
        datos:   dataDestino;
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

Procedure verMinRecorrido(A: arbol; Var D: dataDestino);

Begin

    // El minimo de un arbol binario ordenado siempre va a estar a la izquierda de todos los nodos, es decir, va a ser la hoja mas a la izquierda del arbol

    If (A = Nil) Then // El arbol esta vacio
        D.ventas := -1
    Else If (A^.HI = Nil) Then // Estamos en la ultima hoja a la izquierda
        D := A^.datos
    Else // Hay que seguir avanzando hacia la izquierda
        verMinRecorrido(A^.HI, D);
End;

Procedure InsertarIntegerNodoArbol(Var A: arbol; datos: dataDestino);

Var
    aux:   arbol;

Begin
    new(aux);

    aux^.datos := datos;
    aux^.HI := Nil;
    aux^.HD := Nil;

    A := aux;
End;

Procedure InsertarIntegerArbol(Var A: arbol; datos: dataDestino);

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

Procedure LeerDestino(Var datos: dataDestino);

Begin
    write('Inserte el nombre del destino:');
    readln(datos.nombre);
    If (datos.nombre <> 'Fin')and(datos.nombre <> 'fin') Then
        Begin
            write('Inserte la distancia:');
            readln(datos.distancia);

            write('Inserte la cantidad de ventas:');
            readln(datos.ventas);
        End;
End;

procedure CargarDestino (var A: arbol);

var
    datosDestino: dataDestino;

begin
    LeerDestino(datosDestino);

    while (datosDestino.nombre <> 'Fin') and (datosDestino.nombre <> 'fin') do begin
        InsertarIntegerArbol(A, datosDestino);
        LeerDestino(datosDestino);
    end;
end;

Procedure inicializar (Var A: arbol);
Begin
    A := Nil;
End;

procedure InfromarDestino(D: dataDestino);
begin
    writeln('Destino: ', D.nombre);
    writeln('Cantidad de pasajes vendidos: ', D.ventas);
    writeln('Distancia en kilometros: ', D.distancia);
end;

procedure Buscar(A: arbol; DestinoBuscado: string; var PtrD: arbol; var exito: boolean);

begin
    if (A = nil) then
        exito := False
    else if (A^.datos.nombre = DestinoBuscado)then begin
        exito := True;
        PtrD := A;
    end else if (A^.datos.nombre < DestinoBuscado) then
        Buscar(A^.HD, DestinoBuscado, PtrD, exito)
    else
        Buscar(A^.HI, DestinoBuscado, PtrD, exito)
end;

procedure BuscarDestino(A: arbol);

var
    DestinoBuscado: string;
    exito: boolean;
    PtrD: arbol;

begin
    writeln('Ingrese el nombre del destino que quiere buscar');
    readln(DestinoBuscado);

    Buscar(A, DestinoBuscado, PtrD, exito);

    if exito then begin
        writeln('Se encontro el destino. A continuacion se informara sus caracteristicas.');
        InfromarDestino(PtrD^.datos);
    end;
end;

procedure BuscarMasCercano(A: arbol);

var
    DestinoCercano: dataDestino;

begin
    verMinRecorrido(A, DestinoCercano);
    if (DestinoCercano.distancia <> -1) then begin
        writeln('El destino mas cercano es el siguiente');
        InfromarDestino(DestinoCercano);
    end;
end;

procedure SumarPasaje(var PtrD: arbol; P: longint);

begin
    PtrD^.datos.ventas := PtrD^.datos.ventas + P;
end;

procedure SumarPasajeADestino(var A: arbol);

var
    DestinoSumar: string;
    existe: boolean;
    PtrD: arbol;
    pasajes: longint;

begin
    writeln ('Ingrese el nombre del destino que quiere sumar');
    readln(DestinoSumar);
    if DestinoSumar <> 'Fin' then begin
        Buscar(A, DestinoSumar, PtrD, existe);
        if existe then begin
            writeln('Cuantos pasajes quieres sumar? ');
            readln(pasajes);
            SumarPasaje(PtrD, pasajes);
        end else
            writeln('El destino al que le queres sumar pasajes no existe');
    end;
end;

// |==============================================================|
// |====================> Programa Principal <====================|
// |==============================================================|

Var
    ArbolDestinos:   arbol;
    decision:   longint;

Begin
    writeln('Bienvenido Al Programa De Gestion De Viajes en autobus');
    Inicializar(ArbolDestinos);
    decision := 999;

    While (decision <> 0) Do
        Begin
            Separador();
            // Writelns
            writeln('Menu De Opciones:');
            writeln('1 -> Cargar Destinos');
            writeln('2 -> Imprimir Informacion Contenida');
            writeln('3 -> Buscar Destino Y Mostrar Su Informacion');
            writeln('4 -> Buscar Destino Mas Cercano');
            writeln('5 -> Sumar Pasajes A Un Destino');
            writeln('0 -> Terminar');

            Separador();

            write('Inserte Opcion: ');
            readln(decision);

            // Decisiones

            While Not (decision In [1, 2, 3, 4, 5, 6, 0]) Do
                Begin
                    writeln('Inserte Opcion Valida:');
                    readln(decision);
                End;
            Case decision Of
                1:   CargarDestino(ArbolDestinos);
                2:   InformarEnOrden(ArbolDestinos);
                3:   BuscarDestino(ArbolDestinos);
                4:   BuscarMasCercano(ArbolDestinos);
                5:   SumarPasajeADestino(ArbolDestinos);
                0:   exit();
            End;
        End;
End.
