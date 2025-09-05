Procedure busquedaAcotada(a: arbol; inf:integer; sup:integer);

Begin
    If (a <> Nil) Then
        If (a^.dato >= inf) Then // Si el dato es mayor o igual a la cota inferior
            If (a^.dato <= sup) Then Begin // Y también menor o igual a la cota superior
                write(a^.dato,' - '); // Imprimirlo
                busquedaAcotada(a^.hi, inf, sup); // Seguir en su rama derecha
                busquedaAcotada (a^.hd, inf, sup); // y seguir en su rama izquierda
            End Else
                // El dato es mayor o igual la cota menor pero se pasa de la cota superior, entonces seguir a la izquierda donde hay datos menores a el
                busquedaAcotada(a^.hi, inf, sup)
        Else
        // El dato es menor a la cota inferior (a ambas) entonces seguir a la derecha donde hay datos mayores a el
        busquedaAcotada(a^.hd, inf, sup);
End;