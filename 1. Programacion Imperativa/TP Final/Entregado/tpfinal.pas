
Program tpfinal;

Uses
sysutils;

Type
    str70 =   string[70];

    equipaje =   1..3;
    paises =   1..15;

    destino =   Record
        nombre:   str70;
        pais:   str70;
    End;

    lista =   ^nodoLista;
    nodoLista =   Record
        dato:   destino;
        sig:   lista;
    End;

    fecha =   Record
        dia:   1..31;
        mes:   1..12;
        anio:   integer;
    End;

    paquete =   Record
        identificador:   str70;
        fecha:   fecha;
        aerolinea:   str70;
        cant_equipaje:   equipaje;
        hotel:   boolean;
        destinos:   lista;
    End;

    listaPaquetes =   ^nodoPaquetes;
    nodoPaquetes =   Record
        dato:   paquete;
        sig:   listaPaquetes;
    End;

    nombres =   array [1..20] Of str70;

    numeros =   set Of paises;

    infoPaquetesArbol =   Record
        identificador:   str70;
        fecha:   fecha;
        aerolinea:   str70;
        cant_equipaje:   equipaje;
        hotel:   boolean;
    End;

    listaPaquetesArbol =   ^NodoPaquetesArbol;
    NodoPaquetesArbol =   Record
        datos:   infoPaquetesArbol;
        sig:   listaPaquetesArbol;
    End;

    datosArbol =   Record
        paquetes:   listaPaquetesArbol;
        nombre:   str70;
        pais:   str70;
    End;

    arbol =   ^NodoArbol;
    NodoArbol =   Record
        HI, HD:   arbol;
        datos:   datosArbol;
    End;

Procedure cargarFecha(Var f: fecha);

Var anio:   integer;
Begin
    f.dia := random(30)+1;
    f.mes := random(12)+1;
    anio := random(2)+1;
    Case anio Of
        1:   f.anio := 2025;
        2:   f.anio := 2026;
    End;
End;

Procedure agregar(Var l: listaPaquetes; p: paquete);

Var
    aux:   listaPaquetes;
Begin
    new(aux);
    aux^.dato := p;
    aux^.sig := l;
    l := aux;
End;

Procedure agregarDestino(Var l: lista; d: destino);

Var
    aux:   lista;
Begin
    new(aux);
    aux^.dato := d;
    aux^.sig := l;
    l := aux;
End;

Procedure cargarPaises(Var v:nombres );
Begin
    v[1] := 'Espa�a';
    v[2] := 'Francia';
    v[3] := 'Argentina';
    v[4] := 'Japon';
    v[5] := 'Turquia';
    v[6] := 'Estados Unidos';
    v[7] := 'Mexico';
    v[8] := 'Brasil';
    v[9] := 'Portugal';
    v[10] := 'Panama';
    v[11] := 'Ecuador';
    v[12] := 'Chile';
    v[13] := 'Colombia';
    v[14] := 'Inglaterra';
    v[15] := 'Italia';
End;

Procedure cargarNombres(Var v:nombres );
Begin
    v[1] := 'Madrid';
    v[2] := 'Paris';
    v[3] := 'Buenos Aires';
    v[4] := 'Tokio';
    v[5] := 'Estambul';
    v[6] := 'Miami';
    v[7] := 'Cancun';
    v[8] := 'Rio de Janeiro';
    v[9] := 'Lisboa';
    v[10] := 'Islas San Blas';
    v[11] := 'Islas Galapagos';
    v[12] := 'Santiago';
    v[13] := 'Cartagena';
    v[14] := 'Londres';
    v[15] := 'Roma';
End;

Procedure cargarAerolineas(Var v:nombres );
Begin
    v[1] := 'Aerolineas Argentinas';
    v[2] := 'Iberia';
    v[3] := 'American Airlines';
    v[4] := 'Emirates';
    v[5] := 'Air France';
    v[6] := 'Air Canada';
    v[7] := 'Qatar Airways';
    v[8] := 'LATAM';
    v[9] := 'Copa Airlines';
    v[10] := 'Lufthansa';
End;

Procedure cargarDestinos(Var l: lista);

Var
    d:   destino;
    cant, i, pos:   integer;
    p,n:   nombres;
    no_repetidos:   numeros;
Begin
    cargarPaises(p);
    cargarNombres(n);
    no_repetidos := [];
    cant := random(3)+1;
    For i:=1 To cant Do
        Begin
            With (d) Do
                Begin
                    pos := random(15)+1;
                    While (pos In no_repetidos) Do
                        pos := random(15)+1;
                    no_repetidos := no_repetidos+[pos];
                    nombre := n[pos];
                    pais := p[pos];
                    pos := random(15)+1;
                End;
            agregarDestino(l, d);
        End;
End;

Procedure crearLista(Var l: listaPaquetes);

Var
    p:   paquete;
    cant,i,pos,tiene_hotel:   integer;
    a:   nombres;
Begin
    cant := random(100)+1;
    cargarAerolineas(a);
    For i:=1 To cant Do
        Begin
            With (p) Do
                Begin
                    identificador := concat('PAQ-',IntToStr(random (1000000)+1))
                    ;
                    cargarFecha(fecha);
                    pos := random(10)+1;
                    aerolinea := a[pos];
                    cant_equipaje := random(3)+1;
                    tiene_hotel := random(8);
                    If (tiene_hotel Mod 2 <> 0)Then
                        hotel := false
                    Else
                        hotel := true;
                    destinos := Nil;
                    cargarDestinos(destinos);
                End;
            agregar(l, p);
        End;
End;


Procedure imprimirDestino(d: destino);
Begin
    With (d) Do
        Begin
            writeln('DESTINO: ', nombre, ' | PAIS: ',pais);
        End;
End;

Procedure imprimirDestinos(l: lista);
Begin
    While (l <> Nil) Do
        Begin
            imprimirDestino(l^.dato);
            l := l^.sig;
        End;
End;

Procedure imprimir(p: paquete);

Var tiene_hotel:   str70;
Begin
    With (p) Do
        Begin
            If (hotel)Then
                tiene_hotel := 'Si'
            Else
                tiene_hotel := 'No';
            writeln('');
            writeln('PAQUETE: ', identificador, ' | FECHA: ', fecha.dia,'/',
                    fecha.mes,'/',fecha.anio,' | AEROLINEA: ', aerolinea,
                    ' | EQUIPAJE: ', cant_equipaje, ' | TIENE HOTEL?: ',
                    tiene_hotel);
            imprimirDestinos(destinos);
        End;
End;

Procedure imprimirLista(l: listaPaquetes);
Begin
    While (l <> Nil) Do
        Begin
            imprimir(l^.dato);
            l := l^.sig;
        End;
End;


Procedure InsertarEnListaPaqueteArbol(Var L: listaPaquetesArbol; P: paquete);

Var
    aux:   listaPaquetesArbol;

Begin
    new(aux);

    aux^.datos.aerolinea := P.aerolinea;
    aux^.datos.cant_equipaje := P.cant_equipaje;
    aux^.datos.fecha := P.fecha;
    aux^.datos.hotel := P.hotel;
    aux^.datos.identificador := P.identificador;

    aux^.sig := L;
    L := aux;
End;

Procedure InsertarNodoArbol(Var A: arbol; P: paquete; Ptr: lista);

Var
    aux:   arbol;

Begin
    new(aux);
    aux^.datos.nombre := Ptr^.dato.nombre;
    aux^.datos.pais := Ptr^.dato.pais;

    aux^.HI := Nil;
    aux^.HD := Nil;

    InsertarEnListaPaqueteArbol(aux^.datos.paquetes, P);
End;

Procedure insertarDestinoAlArbol(Var A: arbol; P: paquete; Ptr: lista);

Begin
    If (A = Nil) Then
        InsertarNodoArbol(A, P, Ptr)
    Else If (A^.datos.nombre > Ptr^.dato.nombre) Then
        insertarDestinoAlArbol(A^.HI, P, Ptr)
    Else If (A^.datos.nombre < Ptr^.dato.nombre) Then
        insertarDestinoAlArbol(A^.HD, P, Ptr)
    Else InsertarEnListaPaqueteArbol(A^.datos.paquetes, P);
    {agrega mas datos a la lista (ya hay 1ero)}
End;

Procedure IterarListaDestinos(Var A: arbol; P: paquete; L: lista);

Begin
    While (L <> Nil) Do
        Begin
            insertarDestinoAlArbol(A, P, L);

            L := L^.sig;
        End;

End;


Procedure InsertarArbolDesdeLista(L: listaPaquetes; Var A: arbol);

Begin
    While (L <> Nil) Do
        Begin
            IterarListaDestinos(A, L^.dato, L^.dato.destinos);

            L := L^.sig;
        End;
End;

Procedure contarListaPaquetesArbol(L: listaPaquetesArbol; Var cant: integer);

Begin
    While (L <> Nil) Do
        Begin
            cant := cant + 1;
            L := L^.sig;
        End;
End;

Procedure imprimirAcotadoDestino(a: arbol; inf, sup: str70);

Begin
    If (a <> Nil) Then
        Begin
            If (a^.datos.nombre > inf) Then
                imprimirAcotadoDestino(a^.HI, inf, sup);
            // Solo puede haber menores a la izquierda

            If (a^.datos.nombre >= inf) And (a^.datos.nombre <= sup) Then
                // Esta en el rango
                writeln('El destino que esta en el rango tiene como nombre ', a^
                        .datos.nombre, ' y como pais', a^.datos.pais);

            If (a^.datos.nombre < inf) Then
                imprimirAcotadoDestino(a^.HD, inf, sup);
            // Solo puede haber mayores a la derecha
        End;
End;

Procedure iterarContarPaquete(L: listaPaquetesArbol; inf, sup: fecha; Var exito:
                              boolean);

Begin
    While (L <> Nil) And Not exito Do
        Begin
            exito := (L^.datos.fecha.mes >= inf.mes) And (L^.datos.fecha.mes <=
                     sup.mes) And (L^.datos.fecha.dia >= inf.dia) And (L^.datos.
                     fecha.dia <= sup.dia) And (L^.datos.fecha.anio >= inf.anio)
                     And (L^.datos.fecha.anio <= sup.anio);
            L := L^.sig;
        End;

End;

Procedure contarAcotadoPorFecha(a: arbol; inf, sup: fecha; Var cant: integer);

Var
    exito :   boolean;

Begin
    exito := False;
    If (a <> Nil) Then
        Begin
            contarAcotadoPorFecha(a^.HI, inf, sup, cant);
            iterarContarPaquete(a^.datos.paquetes, inf, sup, exito);
            If exito Then
                cant := cant + 1;
            contarAcotadoPorFecha(a^.HD, inf, sup, cant);
        End;
End;

Procedure contarNodosListaPaquetes(L: listaPaquetesArbol; Var cant: integer);

Begin
    While (L <> Nil) Do
        Begin
            cant := cant + 1;

            L := L^.sig;
        End;
End;

Procedure verMin(A: arbol; Var ListaReacomodar: listaPaquetesArbol);

Begin
// El minimo de un arbol binario ordenado siempre va a estar a la izquierda de todos los nodos, es decir, va a ser la hoja mas a la izquierda del arbol

    If (A = Nil) Then // El arbol esta vacio
        ListaReacomodar := Nil
    Else If (A^.HI = Nil) Then // Estamos en la ultima hoja a la izquierda
             ListaReacomodar := A^.datos.paquetes
    Else // Hay que seguir avanzando hacia la izquierda
        verMin(A^.HI, ListaReacomodar);
End;

Procedure EliminarNodo(Var PtrEliminar: arbol);

Var
    borrar:   arbol;
    listaReacomodar:   listaPaquetesArbol;

Begin
    If (PtrEliminar^.HI = Nil) And (PtrEliminar^.HD = Nil) Then
        // Si es una hoja se borra directamente
        Begin
            borrar := PtrEliminar;
            PtrEliminar := Nil;
            dispose(borrar);
        End
    Else
    // Si tiene un hijo a la derecha, pasar el hijo al nodo y despues eliminarlo
        If (PtrEliminar^.HI=Nil) And (PtrEliminar^.HD<>Nil)Then
            Begin
                borrar := PtrEliminar;
                PtrEliminar := PtrEliminar^.HD;
                dispose(borrar);
            End
    Else If (PtrEliminar^.HI<>Nil) And (PtrEliminar^.HD=Nil)Then
             // Si tiene hijo a la izquierda ...
             Begin
                 borrar := PtrEliminar;
                 PtrEliminar := PtrEliminar^.HI;
                 dispose(borrar);
             End
    Else // Si tiene hijos en los dos sentidos
        Begin
            verMin(PtrEliminar^.HD, listaReacomodar);
            // Encontrar el dato menor en la rama derecha

            PtrEliminar^.datos.paquetes := listaReacomodar;
            // Sobreecribe el que queres eliminar

            EliminarNodo(PtrEliminar^.HD);
            // Elimina el reacomodado
        End;
End;

Procedure verMinPaquete(A: arbol; Var cant: integer; min: integer);

Var
    ptrEliminar :   arbol;

Begin
    If (A <> Nil) Then
        Begin
            verMinPaquete(A^.HI, cant, min);

            contarNodosListaPaquetes(A^.datos.paquetes, cant);

            If (cant < min) Then
                Begin
                    ptrEliminar := A;
                    min := cant;
                End;

            verMinPaquete(A^.HD, cant, min);
        End;

    EliminarNodo(ptrEliminar);
End;

Procedure ImprimirArbol(A: arbol);

Begin
    If (A <> Nil) Then
        Begin
            ImprimirArbol(A^.HI);

            writeln(A^.datos.pais);
            writeln(A^.datos.nombre);
            While (A^.datos.paquetes <> Nil) Do
                Begin
                    writeln('El paquete del destino es: ');
                    writeln(A^.datos.paquetes^.datos.identificador);
                    writeln(A^.datos.paquetes^.datos.hotel);
                    writeln(A^.datos.paquetes^.datos.cant_equipaje);
                    writeln(A^.datos.paquetes^.datos.aerolinea);

                    writeln('Fecha del paquete: ');
                    writeln(A^.datos.paquetes^.datos.fecha.anio);
                    writeln(A^.datos.paquetes^.datos.fecha.mes);
                    writeln(A^.datos.paquetes^.datos.fecha.dia);



                    A^.datos.paquetes := A^.datos.paquetes^.sig;
                End;

            ImprimirArbol(A^.HD);
        End;
End;

Var
    l:   listaPaquetes;
    ArbolPrincipal:   arbol;
    sup, inf:   fecha;
    cantidad, min:   integer;

Begin
    Randomize;

    l := Nil;
    crearLista(l); {carga automatica de la estructura disponible}
    writeln ('LISTA GENERADA: ');
    imprimirLista(l);

    InsertarArbolDesdeLista(l, ArbolPrincipal);
    ImprimirArbol(ArbolPrincipal);

    sup.dia := 20;
    sup.mes := 3;
    sup.anio := 2026;

    sup.dia := 1;
    sup.mes := 12;
    sup.anio := 2025;

    cantidad := 0;

    imprimirAcotadoDestino(ArbolPrincipal, 'Estambul', 'Madrid');
    contarAcotadoPorFecha(ArbolPrincipal, inf, sup, cantidad);
    writeln('La cantidad de destinos filtrados por fecha son ', cantidad);


    cantidad := 0;
    min := 9999;
    verMinPaquete(ArbolPrincipal, cantidad, min);


    writeln('El arbol final quedo como');
    ImprimirArbol(ArbolPrincipal);

    writeln('Fin del programa');
    readln;
End.
