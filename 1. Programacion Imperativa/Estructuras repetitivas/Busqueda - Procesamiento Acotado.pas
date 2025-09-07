Procedure busquedaAcotada(a: arbol; inf:integer; sup:integer);

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