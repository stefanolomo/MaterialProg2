Program ejercicio3;

Uses sysutils;

Type
     pedido =   Record
          codSeg:   longint;
          fechaYhora:   string;
          dni:   longint;
          codArea:   longint;
          domicilio:   string;
          tel:   string;
     End;

    listaPedidos =   ^nodoLista;
    nodoLista =   Record
        dato:   pedido;
        sig:   listaPedidos;
    End;

Procedure agregarLista(Var pri:listaPedidos;p:pedido);

Var
    nuevo,anterior,actual:   listaPedidos;
Begin
    new(nuevo);
    nuevo^.dato := p;
    nuevo^.sig := Nil;
    If (pri=Nil)Then
        pri := nuevo
    Else
        Begin
            actual := pri;
            anterior := pri;
            While (actual<>Nil)And(actual^.dato.dni<nuevo^.dato.dni) Do
                Begin
                    anterior := actual;
                    actual := actual^.sig;
                End;
            If (anterior=actual)Then
                pri := nuevo
            Else
                anterior^.sig := nuevo;
            nuevo^.sig := actual;
        End;
End;


Function cargarFecha():   string;{GeneraunaFECHAaleatoria}

Var
    dia,mes,hora,seg:   longint;
    s:   string;
Begin
    dia := random(30)+1;
    mes := random(12)+1;
    s := Concat(IntToStr(dia),'/',IntToStr(mes),'/2020-');
    hora := random(24);
    seg := random(60);
    If (hora<10)Then
        s := Concat(s,'0',IntToStr(hora))
    Else
        s := Concat(s,IntToStr(hora));
    If (seg<10)Then
        s := Concat(s,':0',IntToStr(seg))
    Else
        s := Concat(s,':',IntToStr(seg));
    cargarFecha := s;
End;

Procedure crearLista(Var l:listaPedidos);

Var
    cant,cod:   longint;
    p:   pedido;
Begin
    cant := random(10);{generahasta100elementos}
    cod := 1;
    While (cant<>0) Do
        Begin
            p.codSeg := cod;{codigodeseguimiento}
            p.fechaYhora := cargarFecha();
            p.dni := random(60000000);{dni}
            p.codArea := (random(4000));{codigodeárea}
            p.domicilio := Concat('Domicilio',IntToStr(cod));{domicilio}
            p.tel := IntToStr(random(999999)+4000000);{telefono}
            agregarLista(l,p);
            cant := cant-1;
            cod := cod+1;
        End;
End;

Procedure imprimirPedido(p:pedido);
Begin
    With (p) Do
        writeln('El pedido: ',codSeg,', del cliente ',dni,
                ' sera atendido en la fecha ',fechaYhora,
                ' en el codigo de area ',codArea,' y domicilio ',domicilio,
                ' con telefono de contacto ',tel);
End;

Procedure imprimirLista(l:listaPedidos);
Begin
    While (l<>Nil) Do
        Begin
            imprimirPedido(l^.dato);
            l := l^.sig;
        End;
End;

Var
    l_inicial:   listaPedidos;

Begin
    Randomize;
{Secrealaestructurainicial}
    l_inicial := Nil;
    crearLista(l_inicial);
    writeln('Lista:');
    imprimirLista(l_inicial);

{Completarelprograma}

    writeln('Fin del programa');
    readln;
End.
