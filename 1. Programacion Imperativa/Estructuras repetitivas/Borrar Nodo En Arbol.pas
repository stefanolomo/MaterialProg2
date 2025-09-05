Procedure BorrarElemento(Var a:arbol; dato:integer; Var resultado:boolean);

Var borrar:   arbol;
    numero:   integer;
Begin
    If (a=Nil) Then resultado := false // Si el arbol esta vacio
    Else
        If (a^.dato>dato)Then // Seguir por la rama izquierda
            BorrarElemento(a^.HI,dato,resultado)
    Else If (a^.dato<dato) Then // Seguir por la rama derechas
            BorrarElemento(a^.HD,dato,resultado)
    Else // Hay que borrar a
        Begin
            resultado := true; // Se borró con exito

            If (a^.HI=Nil) And (a^.HD=Nil)Then // Si es una hoja se borra directamente
                Begin
                    borrar := a;
                    a := Nil;
                    dispose(borrar);
                End
            Else // Si tiene un hijo a la derecha, pasar el hijo al nodo y despues eliminarlo
                If (a^.HI=Nil) And (a^.HD<>Nil)Then
                    Begin
                        borrar := a;
                        a := a^.HD;
                        dispose(borrar);
                    End
            Else If (a^.HI<>Nil) And (a^.HD=Nil)Then // Si tiene hijo a la izquierda ...
                     Begin
                         borrar := a;
                         a := a^.HI;
                         dispose(borrar);
                     End
            Else // Si tiene hijos en los dos sentidos
                Begin
                    verMin(a^.HD,numero); // Encontrar el dato menor en la rama derecha

                    a^.dato := numero; // Sobreecribe el que queres eliminar

                    BorrarElemento(a^.HD,numero,resultado); // Elimina el reacomodado
                End;
        End;
End;