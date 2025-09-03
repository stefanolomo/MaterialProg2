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

procedure CargarArbol(var A: arbol);

var
    E: empleado;
    salarioLeido: real;

begin
    leerEmpleado(E, salarioLeido);

    while (salarioLeido <> 0) do begin
        // InsertarEmpleadoEnArbol(A, E, salarioLeido);

        leerEmpleado(E, salarioLeido);
    end;
end;

begin

end.