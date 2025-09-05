Procedure preOrden( A:
                   arbol );
Begin
    If ( A <> Nil ) Then
        Begin
            write (a^.dato, ' ');
            preOrden (a^.HI);
            preOrden (a^.HD)
        End;
End;

Procedure enOrden( A:
                   arbol );
Begin
    If ( A <> Nil ) Then
        Begin
            enOrden (a^.HI);
            write (a^.dato, ' ');
            enOrden (a^.HD)
        End;
End;

Procedure postOrden( A:
                   arbol );
Begin
    If ( A <> Nil ) Then
        Begin
            postOrden (a^.HI);
            postOrden (a^.HD);
            write (a^.dato, ' ');
        End;
End;