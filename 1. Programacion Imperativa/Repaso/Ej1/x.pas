Program X;

Uses
sysutils;

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

 {Completar agregando aquí las estructuras de datos necesarias en el ejercicio}

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