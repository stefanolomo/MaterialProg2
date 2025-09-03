Program ProblemaTeoria;

// La empresa de tecnología "Nexus" está desarrollando un nuevo sistema de gestión de personal. Actualmente, tienen un organigrama que se actualiza manualmente y quieren automatizar este proceso. El desafío principal es que la jerarquía de la empresa no es estricta; es decir, un mánager puede tener múltiples reportes directos, y en ocasiones, diferentes personas en el mismo nivel jerárquico tienen el mismo puesto o salario. Por ejemplo, puede haber varios "Ingenieros de Software Senior" o varias personas ganando 80,000 dólares al año. El sistema debe permitir lo siguiente:

// - Ingresar nuevos empleados: Cada empleado tiene los siguientes datos:
// - ID del empleado: Un número entero único.
// - Nombre completo: Una cadena de texto.
// - Puesto: Una cadena de texto.
// - Salario: Un número decimal.
// - ID del mánager: El ID del empleado de su mánager directo (podría ser nulo si es el CEO).
// - Buscar empleados por salario: el sistema debe ser capaz de encontrar a todos los empleados que ganan un salario específico en el menor tiempo posible.
// - Actualizar salarios: es necesario poder modificar el salario de un empleado existente y que el sistema se reestructure automáticamente para mantener la eficiencia de las búsquedas.
// - Generar un informe de salarios: se debe poder imprimir una lista de todos los salarios en la empresa, ordenados de menor a mayor.

Type
    empleado = record
        id, manager: longint;
        nombre, puesto: string;
    end;

    listaEmpleados = ^NodoEmpleados;
    NodoEmpleados = record
        datos: empleado;
        sig: listaEmpleados;
    end;

    arbol = ^Nodo;
    Nodo = record
        salario: real;
        empleados: listaEmpleados;
        HI: arbol;
        HD: arbol;
    end;

procedure Separador();
begin
    writeln('');
    writeln('--------------------');
    writeln('');
end;

procedure leerEmpleado(var E: empleado; var salario: real);

begin
    writeln('Ingrese el salario del empleado (cero para terminar): ');
    readln(salario);
    while (salario < 0) do begin
        writeln('Ingrese un salario valido (mayor a 0, cero para terminar):');
        readln(salario);
    end;

If (salario <> 0) Then
    Begin
        writeln('Ingrese el ID del empleado');
        readln(E.id);

        writeln('Ingrese el ID del manager');
        readln(E.manager);

        writeln('Ingrese el nombre del empleado');
        readln(E.nombre);

        writeln('Ingrese el puesto del empleado');
        readln(E.puesto);
    End;
end;

procedure InsertarEmpleadoEnListaEmpleado(var L: listaEmpleados; E: empleado);

var
    nuevo: listaEmpleados;

begin
    new(nuevo);
    nuevo^.datos := E;
    nuevo^.sig := L;

    L := nuevo;
end;

procedure InsertarEmpleadoEnArbol(var A: arbol; E: empleado; salario: real);

Begin
    If (A = Nil) Then // El arbol esta vacio, insertar al principio
        Begin
            new(A);
            A^.salario := salario;
            InsertarEmpleadoEnListaEmpleado(A^.empleados, E);

            A^.HI := Nil;
            A^.HD := Nil;
        End
    Else If (salario = A^.salario) Then // El salario es el mismo entonces se suma un empleado
        InsertarEmpleadoEnListaEmpleado(A^.empleados, E)
    Else If (salario < A^.salario) Then // Si se pasa, busca en la izquierda
        InsertarEmpleadoEnArbol(A^.HI, E, salario)
    Else // Sino, busca en la derecha
        InsertarEmpleadoEnArbol(A^.HD, E, salario);

End;

Procedure CargarArbol(Var A: arbol);

Var
    E:   empleado;
    salarioLeido:   real;

Begin
    salarioLeido := 0;
    leerEmpleado(E, salarioLeido);

    While (salarioLeido <> 0) Do
        Begin
            InsertarEmpleadoEnArbol(A, E, salarioLeido);

            Separador();

            leerEmpleado(E, salarioLeido);
        End;
End;

Procedure ImprimirEmpleado(datos:empleado);
Begin
    writeln('Datos Empleado ',datos.nombre);
    writeln('ID: ',datos.id);
    writeln('Puesto: ',datos.Puesto);
    writeln('Id de Manager: ',datos.manager);
End;

Procedure imprimirListaEmpleados(l: listaEmpleados);

Begin
    While (l <> Nil) Do
        Begin
            writeln;
            imprimirEmpleado(l^.datos);
            l := l^.sig;
            writeln;
        End;
End;

Procedure EncontrarSegunSalario(a:arbol; salario:real; Var Puntero:
                                ListaEmpleados);
Begin
    If (a<>Nil)Then
        Begin
            If (a^.salario>salario)Then
                EncontrarSegunSalario(a^.HI, salario, Puntero)
            Else If (a^.salario<salario) Then
                EncontrarSegunSalario(a^.HD, salario, Puntero)
            Else Puntero := a^.empleados;
        End
    Else Puntero := Nil;
End;

procedure BuscarSalario(A: arbol);

var
    salarioABuscar: real;
    ptrEmpleados: listaEmpleados;

begin
    writeln('Que salario quiere consultar?');
    readln(salarioABuscar);

    EncontrarSegunSalario(A, salarioABuscar, ptrEmpleados);
    imprimirListaEmpleados(ptrEmpleados);
end;

var
    ArbolSalarios: arbol;

begin
    CargarArbol(ArbolSalarios);


end.