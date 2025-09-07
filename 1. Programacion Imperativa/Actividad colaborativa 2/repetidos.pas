Program Repetidos;

type
    paciente = record
        dni, codPostal: longint;
        ciudad: string;
    end;

    datosCiudad = record
        cantidad, codPostal: longint;
    end;

    arbol = ^Ciudad;
    Ciudad = record
        datos: datosCiudad;
        HI, HD: arbol;
    end;

procedure LeerPaciente(var P:paciente);

begin
    writeln('Ingrese el DNI del paciente (0 para terminar): ');
    readln(P.dni);

    while (P.dni < 0) do begin
        writeln('Ingrese un DNI valido (mayor a cero): ');
        readln(P.dni);
    end;

    if (P.dni <> 0) then begin
        writeln('Ingrese el codigo postal de la ciudad del paciente');
        readln(P.codPostal);

        writeln('Ingrese el nombre de la ciudad del paciente: ');
        readln(P.ciudad);
    end;

end;

Procedure InsertarPacienteAlArbolCiudad(Var A: arbol; P: paciente);

Begin
    If (A = Nil) Then // El arbol esta vacio, insertar al principio
        Begin
            new(A);
            A^.datos.codPostal := P.codPostal;
            A^.datos.cantidad := 1;

            A^.HI := Nil;
            A^.HD := Nil;
        End
    Else If (P.codPostal = A^.datos.codPostal) Then // El codigo es el mismo entonces se actualiza
        A^.datos.cantidad := A^.datos.cantidad + 1
    Else If (P.codPostal < A^.datos.codPostal) Then // Si se pasa, busca en la izquierda
        InsertarPacienteAlArbolCiudad(A^.HI, P)
    Else // Sino, busca en la derecha
        InsertarPacienteAlArbolCiudad(A^.HD, P)
End;

procedure cargarArbolCiudad(var A: arbol);

var
    pacienteLeido: paciente;

begin
    LeerPaciente(pacienteLeido);

    while (pacienteLeido.dni <> 0) do begin
        InsertarPacienteAlArbolCiudad(A, pacienteLeido);

        LeerPaciente(pacienteLeido);
    end;
end;

procedure imprimirArbol(A: arbol);

begin
    if (A <> nil) then begin
        imprimirArbol(A^.HI);

        writeln('Codigo postal: ', A^.datos.codPostal);
        writeln('Cantidad de infectados: ', A^.datos.cantidad);

        imprimirArbol(A^.HD);
    end;
end;

procedure ImprimirEnRango(a: arbol; inf, sup: longint);

begin
    if (a <> nil) then begin
        if (a^.datos.codPostal > inf) then
            ImprimirEnRango(a^.HI, inf, sup);  // Solo puede hacer menores a la izquierda

        if (a^.datos.codPostal >= inf) and (a^.datos.codPostal <= sup) then // Esta en el rango
            writeln('La localidad con codigo postal ', a^.datos.codPostal, ' tiene ', a^.datos.cantidad, ' infectados.');

        if (a^.datos.codPostal < sup) then
            ImprimirEnRango(a^.HD, inf, sup);  // Solo puede haber mayores a la derecha
    end;
end;


var
    ArbolPorCodPostal: arbol;

begin
    ArbolPorCodPostal := nil;

    cargarArbolCiudad(ArbolPorCodPostal);

    imprimirArbol(ArbolPorCodPostal);

    ImprimirEnRango(ArbolPorCodPostal, 1800, 1900);
end.