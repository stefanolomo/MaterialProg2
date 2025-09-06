Procedure verMin(A: arbol; Var valor: integer);

Begin

// El minimo de un arbol binario ordenado siempre va a estar a la izquierda de todos los nodos, es decir, va a ser la hoja mas a la izquierda del arbol

    If (A = Nil) Then // El arbol esta vacio
        valor := -1
    Else If (A^.HI = Nil) Then // Estamos en la ultima hoja a la izquierda
             valor := A^.dato
    Else // Hay que seguir avanzando hacia la izquierda
        verMin(A^.HI, valor);
End;

procedure verMax(A: arbol; var valor: integer);

begin
    // El maximo de un arbol binario ordenado siempre va a estar a la derecha de todos los nodos, es decir, va a ser la hoja mas a la derecha del arbol

    if (A = nil) then // El arbol esta vacio
        valor := -1
    else if (A^.HD = nil) then // Estamos en la ultima hoja a la derecha
        valor := A^.dato
    else // Hay que seguir avanzando hacia la derecha
        verMax(A^.HD, valor);
end;      