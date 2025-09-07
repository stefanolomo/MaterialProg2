program Ejercicio2;

type
    paciente = record
        dni, codPostal: longint;
        ciudad: string;
    end;

    listaDni = ^NodoDNI;
    NodoDNI = record
        dni: longint;
        sig: listaDni;
    end;

    arbol = ^Ciudad;
    Ciudad = record
        codPostal: longint;
        infectados: listaDni;
        HI, HD: arbol;
    end;

procedure insertarAlPrincipioListaDNI(var L: listaDni; P: paciente);

var
    aux: listaDni;

begin
    new(aux);
    aux^.dni := P.dni;
    aux^.sig := L;
    L := aux;
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

Procedure InsertarDniAlArbol(Var A: arbol; P: paciente);

Begin
    If (A = Nil) Then // El arbol esta vacio, insertar al principio
        Begin
            new(A);
            A^.codPostal := P.codPostal;
            A^.infectados := nil;
            insertarAlPrincipioListaDNI(A^.infectados, P);

            A^.HI := Nil;
            A^.HD := Nil;
        End
    Else If (P.codPostal = A^.codPostal) Then // El codigo es el mismo entonces se actualiza
        insertarAlPrincipioListaDNI(A^.infectados, P)
    Else If (P.codPostal < A^.codPostal) Then // Si se pasa, busca en la izquierda
        InsertarDniAlArbol(A^.HI, P)
    Else // Sino, busca en la derecha
        InsertarDniAlArbol(A^.HD, P)
End;

procedure cargarArbolCiudad(var A: arbol);

var
    pacienteLeido: paciente;

begin
    LeerPaciente(pacienteLeido);

    while (pacienteLeido.dni <> 0) do begin
        InsertarDniAlArbol(A, pacienteLeido);

        LeerPaciente(pacienteLeido);
    end;
end;

procedure imprimirListaDni(L: listaDni);

var
    i: longint;

begin
    i := 1;

    while (L <> nil) do begin
        writeln('[', i, '] ', L^.dni);

        L := L^.sig;
        i := i + 1;
    end;
end;

procedure imprimirArbol(A: arbol);

begin
    if (A <> nil) then begin
        imprimirArbol(A^.HI);

        writeln('Codigo postal: ', A^.codPostal);
        writeln('Lista de DNIs de personas infectadas: ');
        imprimirListaDni(A^.infectados);

        imprimirArbol(A^.HD);
    end;
end;

procedure Separador();

begin
    writeln('');
    writeln('--------------------');
    writeln('');
end;

var
    ArbolPorCodPostal: arbol;
    cantidadInfectadosEnRango: longint;

begin
end.