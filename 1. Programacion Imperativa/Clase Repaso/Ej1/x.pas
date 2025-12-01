Program X;

Uses
sysutils;

// X dispone de una lista simple con los tweets realizados durante los últimos 5 segundos. De cada tweet se conoce: el código y nombre de usuario que lo generó, el contenido del mensaje y si el mismo es o no un retweet. Esta información no tiene ningún orden y se debe tener en cuenta que podrían existir en la lista varios tweets del mismo usuario. Se pide:

// A. Realice un módulo que reciba la lista con los tweets y genere una nueva estructura donde para cada usuario se almacene la cantidad de mensajes publicados. Esta estructura debe estar ordenada por código de usuario y debe ser eficiente para la búsqueda por dicho criterio. Una vez generado el árbol:

// B. Informar la cantidad de tweets de los usuarios con código entre 100 y 700.
// C. Informar el nombre del usuario con mayor cantidad de tweets.
// D. ¿Qué cambiaría del ejercicio implementado si la lista inicial fuera una lista de listas? (Del usuario y sus tweets)

Type
    tweet =   Record
        codigoUsuario:   longint;
        nombreUsuario:   string;
        mensaje:   string;
        esRetweet:   boolean;
    End;

    listaTweets =   ^nodoLista;
    nodoLista =   Record
        datos:   tweet;
        sig:   listaTweets;
    End;

    arbol = ^Usuario;
    Usuario = record
        codigoUsuario: longint;
        tweets: listaTweets;
        HI: arbol;
        HD: arbol;
    end;



{agregarAdelante - Agrega nro adelante de l}
Procedure agregarAdelante(Var l: listaTweets; t: tweet);

Var
    aux:   listaTweets;
Begin
    new(aux);
    aux^.datos := t;
    aux^.sig := l;
    l := aux;
End;


{crearLista - Genera una lista con tweets aleatorios}
Procedure crearLista(Var l: listaTweets);

Var
    t:   tweet;
    texto:   string;
Begin
    t.codigoUsuario := random(2000);
    While (t.codigoUsuario <> 0) Do
        Begin
            texto := Concat(IntToStr(t.codigoUsuario), '-mensaje-', IntToStr(random (200)));
            t.nombreUsuario := Concat('Usuario-',IntToStr(t.codigoUsuario));
            t.mensaje := texto;
            t.esRetweet := (random(2)=0);
            agregarAdelante(l, t);
            t.codigoUsuario := random(2000);
        End;
End;

{imprimir - Muestra en pantalla el tweet}
Procedure imprimirTweet(t: tweet);
Begin
    With (t) Do
        Begin
            write('Tweet del usuario @', nombreUsuario, ' con codigo ',
                codigoUsuario, ': ', mensaje, ' RT:');
            If (esRetweet)Then
                writeln(' Si')
            Else
                writeln('No ');
        End;
End;

{imprimirLista - Muestra en pantalla la lista l}
Procedure imprimirLista(l: listaTweets);
Begin
    While (l <> Nil) Do
        Begin
            imprimirTweet(l^.datos);
            l := l^.sig;
        End;
End;

Procedure InsertarPublicacionAlArbol(Var A: arbol; T: tweet);

Begin
    If (A = Nil) Then // El arbol esta vacio, insertar al principio
        Begin
            new(A);
            A^.tweets := nil;
            agregarAdelante(A^.tweets, T);
            A^.codigoUsuario := T.codigoUsuario;

            A^.HI := Nil;
            A^.HD := Nil;
        End
    Else If (T.codigoUsuario = A^.codigoUsuario) Then // El codigo es el mismo entonces se agrega el tweet
        agregarAdelante(A^.tweets, T)
    Else If (T.codigoUsuario < A^.codigoUsuario) Then // Si se pasa, busca en la izquierda
        InsertarPublicacionAlArbol(A^.HI, T)
    Else // Sino, busca en la derecha
        InsertarPublicacionAlArbol(A^.HD, T);

End;

Procedure CargarArbolDesdeLista(Var A: arbol; L: listaTweets);

Begin
    While (L <> Nil) Do
        Begin
            InsertarPublicacionAlArbol(A, L^.datos);
            L := L^.sig;
        End;
End;

function contarTweets(L: listaTweets): longint;

var
    aux: longint;

begin
    aux := 0;

    while (L <> nil) do begin
        aux := aux + 1;
        L := L^.sig;
    end;

    contarTweets := aux;
end;

Procedure imprimirEnRango(a: arbol; inf:longint; sup:longint);

var
    cantidad: longint;

Begin
    If (a <> Nil) Then
        If (a^.codigoUsuario >= inf) Then // Si el dato es mayor o igual a la cota inferior
            If (a^.codigoUsuario <= sup) Then Begin // Y también menor o igual a la cota superior
                cantidad := contarTweets(a^.tweets); // Contar

                writeln('El usuario de codigo ', a^.codigoUsuario, ' que esta en el rango ingresado; tiene ', cantidad, ' tweets.');

                imprimirEnRango(a^.hi, inf, sup); // Seguir en su rama derecha
                imprimirEnRango(a^.hd, inf, sup); // y seguir en su rama izquierda
            End Else
                // El dato es mayor o igual la cota menor pero se pasa de la cota superior, entonces seguir a la izquierda donde hay datos menores a el
                imprimirEnRango(a^.hi, inf, sup)
        Else
        // El dato es menor a la cota inferior (a ambas) entonces seguir a la derecha donde hay datos mayores a el
        imprimirEnRango(a^.hd, inf, sup);
End;

procedure verMaxTweetsUser(A: arbol; var maxCant: longint; var maxUser: string);

var
    cantAct: longint;

begin
    if (A <> nil) then begin // Si no esta vacia
        // Procesar el usuario actual
        cantAct := contarTweets(A^.tweets);
        // Si es maximo actualiza
        if (cantAct > maxCant) then begin
            maxCant := cantAct;
            maxUser := A^.tweets^.datos.nombreUsuario;
        end;

        // Seguir en sus ramas
        verMaxTweetsUser(A^.HI, maxCant, maxUser);
        verMaxTweetsUser(A^.HD, maxCant, maxUser);
    end;

end;

Var
    listaPublicaciones:   listaTweets;
    arbolUsers: arbol;
    sup, inf: longint;
    usuarioMasParlante: string;

Begin
    Randomize;

    listaPublicaciones := Nil;
    crearLista(listaPublicaciones);

    writeln ('Lista generada: ');
    imprimirLista(listaPublicaciones);

    arbolUsers := nil;
    CargarArbolDesdeLista(arbolUsers, listaPublicaciones);

    writeln('Ingrese la cota inferior para imprimir tweets: ');
    readln(inf);

    writeln('Ingrese la cota superior para imprimir tweets: ');
    readln(sup);

    imprimirEnRango(arbolUsers, inf, sup);

    sup := -1;

    verMaxTweetsUser(arbolUsers, sup, usuarioMasParlante);
    writeln('El usuario ', usuarioMasParlante, ' es el que mas tweets tiene, con ', sup, ' tweets totales' );
End.