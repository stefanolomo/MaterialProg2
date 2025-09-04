
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
    v :   array [1..10] Of string;

Begin
    v[1] := 'juan';
    v[2] := 'pedro';
    v[3] := 'carlos';
    v[4] := 'julia';
    v[5] := 'mariana';
    v[6] := 'gonzalo';
    v[7] := 'alejandro';
    v[8] := 'silvana';
    v[9] := 'federico';
    v[10] := 'ruth';

    t.codigoUsuario := random(11);
    While (t.codigoUsuario <> 0) Do
        Begin
            texto := Concat(v[t.codigoUsuario], '-mensaje-', IntToStr(random (
                     200)));
            t.nombreUsuario := v[t.codigoUsuario];
            t.mensaje := texto;
            t.esRetweet := (random(2)=0);
            agregarAdelante(l, t);
            t.codigoUsuario := random(11);
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


{agregarElemento - Resuelve la inserción de la estructura ordenada}
Procedure agregarOrdenado(Var pri:listaTweets; t:tweet);

Var 
    nuevo, anterior, actual:   listaTweets;

Begin
    new (nuevo);
    nuevo^.dato := t;
    nuevo^.sig := Nil;
    If (pri = Nil) Then
        pri := nuevo
    Else
        Begin
            actual := pri;
            anterior := pri;

            While (actual <> Nil) And (actual^.dato.nombreUsuario < nuevo^.dato.
                  nombreUsuario) Do
                Begin
                    anterior := actual;
                    actual := actual^.sig;
                End;

            If (anterior = actual) Then
                pri := nuevo
            Else
                anterior^.sig := nuevo;

            nuevo^.sig := actual;
        End;
End;


{generarNuevaEstructura - Resuelve la generación estructura ordenada}
Procedure generarNuevaEstructura (lT: listaTweets; Var listaOrdenada:
                                  listaTweets);

Begin
    listaOrdenada := Nil;

    While (lT <> Nil) Do
        Begin
            agregarOrdenado(listaOrdenada, lT^.dato);
            lT := lT^.sig;
        End;
End;

Var 
    l, l_ordenada:   listaTweets;
Begin
    Randomize;

    l := Nil;
    crearLista(l);
    writeln ('Lista generada: ');
    imprimirLista(l);

     {Se crea la estructura ordenada}
    l_ordenada := Nil;
    generarNuevaEstructura(l,l_ordenada);
    writeln ('Lista ordenada: ');
    imprimirLista(l_ordenada);

     {Completar el programa}

    writeln('Fin del programa');
    readln;
End.
