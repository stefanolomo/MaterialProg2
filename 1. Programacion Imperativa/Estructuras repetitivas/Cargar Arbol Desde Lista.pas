Procedure InsertarPorArea(Var A: arbol; codArea, dni: longint);

Begin
    If (A = Nil) Then // El arbol esta vacio, insertar al principio
        Begin
            new(A);
            A^.datos.codigo := codArea;
            A^.datos.pedidos := 1;
            A^.datos.solicitantes := Nil;

            AgregarDNI(A^.datos.solicitantes, dni);

            A^.HI := Nil;
            A^.HD := Nil;

        End
    Else If (codArea = A^.datos.codigo) Then // El codigo es el mismo entonces se actualiza
        Begin
            A^.datos.pedidos := A^.datos.pedidos + 1; // Se suma un pedido
            AgregarDNI(A^.datos.solicitantes, dni); // Se suma el DNI a la lista
        End
    Else If (codArea < A^.datos.codigo) Then // Si se pasa, busca en la izquierda
        InsertarPorArea(A^.HI, codArea, dni)
    Else // Sino, busca en la derecha
        InsertarPorArea(A^.HD, codArea, dni);

End;

Procedure CargarArbolDesdeLista(Var A: arbol; Var L: listaPedidos);

Var
    aux:   listaPedidos;

Begin
    A := Nil;
    aux := L;

    While (aux <> Nil) Do
        Begin
            InsertarPorArea(A, aux^.dato.codArea, aux^.dato.dni);
            aux := aux^.sig;
        End;
End;