Program pas;

Const
    dimF =   8;

Type
    vector =   array [1..dimF] Of LongInt;
    dim =   0..dimF;

Procedure Suma2(V: vector; dimL: dim; i: longint; Var suma: longint);

Begin
    If (dimL = 0) Then // Esta vacio
        writeln('El vector esta vacio')

    Else if (i <= dimL) then Begin // ¿Quedan posiciones para procesar?
        // Si no esta vacio, le sumamos el valor a suma
        suma := suma + V[i];

        Suma2(V, dimL, i, suma);
    End;
End;

Begin

End.
