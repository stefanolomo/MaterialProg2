Procedure InsertarIntegerNodoArbol(Var A: arbol; dato: encomienda);

Var
    aux:   arbol;

Begin
    new(aux);
    aux^.valor := dato.valor; {Info que se mantiene en el nodo}
    aux^.IDlista:=nil; {se pone la lista en nil}
    Agregar(aux^.lista,dato.codigo); {agrega el primer dato en la lista}
    aux^.HI := Nil;
    aux^.HD := Nil;

    A := aux;
End;
Procedure InsertarIntegerArbol(Var A: arbol; dato: encomienda);

Begin
    If (A = Nil) Then
        InsertarIntegerNodoArbol(A, dato)
    Else If (A^.peso > dato.peso) Then
             InsertarIntegerArbol(A^.HI, dato)
    Else if (A^.peso < dato.peso) then
        InsertarIntegerArbol(A^.HD, dato)
         else agregar(A^.lista,dato.codigo); {agrega mas datos a la lista (ya hay 1ero)}
End;

Procedure InsertarArbolDesdeLista(L: Lista; Var A: arbol);

Begin
    While (L <> Nil) Do
        Begin
            InsertarIntegerArbol(A, L^.dato);

            L := L^.sig;
        End;
End;