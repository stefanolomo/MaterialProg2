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