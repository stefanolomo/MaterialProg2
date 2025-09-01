Program ejercicio3;

Uses sysutils;

// Una empresa de telecomunicaciones procesa los datos de varios pedidos de conexión que llegan telefónicamente. Se dispone de una lista con los datos cargados y listos para ser procesados. Cada pedido posee un código único de seguimiento, fecha y hora del turno de conexión, DNI del cliente, código de área, domicilio del cliente y su número telefónico. Posteriormente al ingreso y almacenamiento de la información, se pide:

// A. Crear una nueva estructura que almacene para cada código de área, el total de pedidos de dicha área y los DNI de los clientes que solicitaron el servicio. Esta estructura debe estar ordenada por código de área y debe ser eficiente para la búsqueda por dicho criterio.

// Al finalizar el procesamiento de A. elija las estructuras adecuadas para:

// B. Implementar un módulo que retorne el código de área con menor cantidad de pedidos de servicio.

// C. Implementar un módulo que imprima los DNI de clientes cuyo código de área se encuentre entre 1000 y 2000, ordenados por código de área.

// D. Implementar un módulo que, dado un código de área, imprima los DNI de los clientes que solicitan conexión.

// E. Implementar un programa principal que utilice los módulos implementados

Type
    pedido =   Record
        codSeg:   longint;
        fechaYhora:   string;
        dni:   longint;
        codArea:   longint;
        domicilio:   string;
        tel:   string;
    End;

    // Lista de pedidos generada automaticamente
    listaPedidos =   ^nodoLista;
    nodoLista =   Record
        dato:   pedido;
        sig:   listaPedidos;
    End;

    // Lista de DNIs de los solicitantes del servicio
    listaDni = ^NodoDni;
    NodoDni = record
        dni: longint;
        sig: listaDni;
    end;

    // Arbol ordenado por codigo de area
    datosArbol = record
        codigo: longint;
        pedidos: longint;
        solicitantes: listaDni;
    end;
    arbol = ^Nodo;
    Nodo = record
        datos: datosArbol;
        HI: arbol;
        HD: arbol;
    end;


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

Function cargarFecha():   string; {GeneraunaFECHAaleatoria}

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
    cant := random(15); {genera hasta 100 elementos}
    cod := 1;
    While (cant<>0) Do
        Begin
            p.codSeg := cod; {codigodeseguimiento}
            p.fechaYhora := cargarFecha();
            p.dni := random(60000000); {dni}
            p.codArea := (random(4000)); {codigodeárea}
            p.domicilio := Concat('Domicilio ',IntToStr(cod)); {domicilio}
            p.tel := IntToStr(random(999999)+4000000); {telefono}
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

Procedure HallarMenorDemanda(a: arbol; Var minCant, minCod: longint);

Begin
    If (a <> Nil) Then
        Begin
            // Busca el mejor cliente de la rama izquierda
            HallarMenorDemanda(a^.HI, minCant, minCod);

            // Si es un minimo actualiza
            If (a^.datos.pedidos < minCant) Then
                Begin
                    minCant := a^.datos.pedidos;
                    minCod := a^.datos.codigo;
                End;

            // Busca el mejor cliente de la rama derecha
            HallarMenorDemanda(a^.HD, minCant, minCod);

            // Recorre: Izquierda - Raiz - Derecha (Similar a enOrden)
        End;
End;

Procedure AgregarDNI(Var L: listaDni; d: longint);

Var
    nue:   listaDni;
Begin
    new(nue);
    nue^.dni := d;
    nue^.sig := L;
    L := nue;
End;

Procedure CargarArbolDesdeLista(Var A: arbol; Var L: listaPedidos);

Begin

End;

Var
    l_inicial:   listaPedidos;

Begin
    Randomize;

    {Se crea la estructura inicial}
    l_inicial := Nil;
    crearLista(l_inicial);
    writeln('Lista:');
    imprimirLista(l_inicial);

    {Completarelprograma}

    HallarMenorDemanda()

    writeln('Fin del programa');
End.
