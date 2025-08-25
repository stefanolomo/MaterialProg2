
Program ActColaborativa;

Uses crt;

Type
    dataDestino =   Record
        nombre:   string;
        distancia:   real;
        ventas:   integer;
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
    If datos.nombre <> 'Fin' Then
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

    if (datosDestino.nombre <> 'Fin') then
        InsertarIntegerArbol(A, datosDestino);
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

procedure Buscar(A: arbol; DestinoBuscado: dataDestino; var exito: boolean);

begin
    if (A = nil) then
        exito := False
    else if (A^.datos.nombre = DestinoBuscado.nombre) and (A^.datos.distancia = DestinoBuscado.distancia) and (A^.datos.ventas = DestinoBuscado.ventas) then
        exito := True
    else if (A^.datos.nombre < DestinoBuscado.nombre) then
        Buscar(A^.HD, DestinoBuscado, exito)
    else
        Buscar(A^.HI, DestinoBuscado, exito)
end;

procedure BuscarDestino(A: arbol);

var
    DestinoBuscado: dataDestino;
    exito: boolean;

begin
    writeln('Ingrese las caracteristicas del destino que quiere buscar');

    LeerDestino(DestinoBuscado);

    Buscar(A, DestinoBuscado, exito);

    if exito then begin
        writeln('Se encontro el destino. A continuacion se informara sus caracteristicas.');
        InfromarDestino(DestinoBuscado);
    end;
end;

procedure BuscarMasCercano(A: arbol);

var
    DestinoCercano: dataDestino;

begin
    verMinRecorrido(A, DestinoCercano);
    if (DestinoCercano.ventas <> -1) then begin
        writeln('El destino mas cercano es el siguiente');
        InfromarDestino(DestinoCercano);
    end;
end;

procedure SumarPasajeADestino(var A: arbol);

var
    DestinoSumar: dataDestino;
    existe: boolean;

begin
    writeln ('Ingrese las caracteristicas del destino que quiere sumar');
    LeerDestino(DestinoSumar);
    if DestinoSumar.nombre <> 'Fin' then begin
        Buscar(A, DestinoSumar, existe);
        if existe then
            SumarPasaje(A, DestinoSumar);
    end
end;

// |==============================================================|
// |====================> Programa Principal <====================|
// |==============================================================|

Var
    ArbolDestinos:   arbol;
    decision:   integer;
    valor:real;

Begin
    writeln('Bienvenido Al Programa De Gestion De Viajes en autobus');
    Inicializar(ArbolDestinos);
    decision := 999;

    While (decision <> 0) Do
        Begin
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
                1:   writeln(); // Falta Implementar
                2:   InformarEnOrden(ArbolDestinos);
                3:   BuscarDestino(ArbolDestinos);
                4:   BuscarMasCercano(ArbolDestinos);
                5:   SumarPasajeADestino(ArbolDestinos);
                0:   exit();
            End;
        End;
End.
