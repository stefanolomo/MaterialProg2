procedure Buscar(A: arbol; var ptr: arbol; valor: integer);{DEVUELVE UN PUNTERO}

begin
    ptr := nil;

    if (A = nil) then
        ptr := nil
    else if (A^.dato = valor) then
        ptr := A
    else if (A^.dato < valor) then
        Buscar(A^.HD, ptr, valor)
    else
        Buscar(A^.HI, ptr, valor)
end;
