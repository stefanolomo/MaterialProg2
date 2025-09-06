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
        codigoUsuario:   integer;
        nombreUsuario:   string;
        mensaje:   string;
        esRetweet:   boolean;
    End;

    listaTweets =   ^nodoLista;
    nodoLista =   Record
        dato:   tweet;
        sig:   listaTweets;
    End;



{agregarAdelante - Agrega nro adelante de l}
Procedure agregarAdelante(Var l: listaTweets; t: tweet);

Var
    aux:   listaTweets;
Begin
    new(aux);
    aux^.dato := t;
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
Procedure imprimir(t: tweet);
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
            imprimir(l^.dato);
            l := l^.sig;
        End;
End;

Var
    l:   listaTweets;
Begin
    Randomize;

    l := Nil;
    crearLista(l);
    writeln ('Lista generada: ');
    imprimirLista(l);

    {Completar el programa}

    writeln('Fin del programa');
    readln;
End.