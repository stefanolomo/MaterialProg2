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
        nombre, Puesto: string;
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
Procedure ImprimirEmpleado(datos:empleado);
begin
    writeln('Datos Empleado ',datos.nombre);
    writeln('ID: ',datos.id);
    writeln('Puesto: ',datos.Puesto);
    writeln('Id de Manager: ',datos.manager);
end;

procedure imprimirListaEmpleados(l: listaEmpleados;salario:real);
begin
     writeln('Lista de los Empleados con Salario ',salario,' : ');
     while (l <> nil) do begin
          writeln;
          imprimirEmpleado(l^.datos);
          l:= l^.sig;
          writeln;
     end;
end;
Procedure EncontrarSegunSalario(a:arbol; salario:real);
begin
    if (a<>nil)then
       begin
       if (a^.salario>salario)then
         EncontrarSegunSalario(a^.HI,salario)
       else if (a^.salario<salario) then
              EncontrarSegunSalario(a^.HD,salario)
            else ImprimirListaEmpleados(a^.empleados,salario);
       end
    else writeln('No se encontro el Salario');


end;

begin
end.