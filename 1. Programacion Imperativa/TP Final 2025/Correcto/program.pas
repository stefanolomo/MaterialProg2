
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
    cant := random(10)+1;
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
    aux^.datos.paquetes := Nil;

    aux^.HI := Nil;
    aux^.HD := Nil;

    InsertarEnListaPaqueteArbol(aux^.datos.paquetes, P);

    { IMPORTANT: enlazar el nuevo nodo al árbol }
    A := aux;
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

function FechaAInt(f: fecha): LongInt;
begin
  FechaAInt := (f.anio * 10000) + (f.mes * 100) + f.dia;
end;


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
                        .datos.nombre, ' y como pais ', a^.datos.pais);

            If (a^.datos.nombre < sup) Then
                imprimirAcotadoDestino(a^.HD, inf, sup);
            // Solo puede haber mayores a la derecha
        End;
End;

Procedure iterarContarPaquete(L: listaPaquetesArbol; inf, sup: fecha; Var exito: boolean);
var val: LongInt;
begin
  while (L <> Nil) and not exito do
  begin
    val := FechaAInt(L^.datos.fecha);
    exito := (val >= FechaAInt(inf)) and (val <= FechaAInt(sup));
    L := L^.sig;
  end;
end;


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

Function verMinNodo(A: arbol): arbol;
Begin
    If (A = Nil) Then
        verMinNodo := Nil
    Else If (A^.HI = Nil) Then
        verMinNodo := A
    Else
        verMinNodo := verMinNodo(A^.HI);
End;

{ Libera todos los nodos de la lista de paquetes (listaPaquetesArbol) }
procedure LiberarListaPaquetesArbol(var L: listaPaquetesArbol);
var
  tmp: listaPaquetesArbol;
begin
  while L <> Nil do
  begin
    tmp := L;
    L := L^.sig;
    dispose(tmp);
  end;
end;

{ Elimina del árbol el nodo cuya clave (nombre) coincide con 'nombre' }
procedure EliminarPorNombre(var A: arbol; nombre: str70);
var
  nodoAEliminar, succ, succParent: arbol;
begin
  if A = Nil then
    Exit;

  if nombre < A^.datos.nombre then
  begin
    EliminarPorNombre(A^.HI, nombre);
    Exit;
  end
  else if nombre > A^.datos.nombre then
  begin
    EliminarPorNombre(A^.HD, nombre);
    Exit;
  end;

  { Aquí A apunta al nodo a eliminar }
  nodoAEliminar := A;

  { Caso 1: hoja (sin hijos) }
  if (A^.HI = Nil) and (A^.HD = Nil) then
  begin
    LiberarListaPaquetesArbol(A^.datos.paquetes);
    dispose(A);
    A := Nil;
    Exit;
  end;

  { Caso 2: solo hijo derecho }
  if (A^.HI = Nil) and (A^.HD <> Nil) then
  begin
    A := A^.HD;
    LiberarListaPaquetesArbol(nodoAEliminar^.datos.paquetes);
    dispose(nodoAEliminar);
    Exit;
  end;

  { Caso 3: solo hijo izquierdo }
  if (A^.HI <> Nil) and (A^.HD = Nil) then
  begin
    A := A^.HI;
    LiberarListaPaquetesArbol(nodoAEliminar^.datos.paquetes);
    dispose(nodoAEliminar);
    Exit;
  end;

  { Caso 4: dos hijos -> sucesor inorder (mínimo en subárbol derecho) }
  succParent := A;
  succ := A^.HD;
  while succ^.HI <> Nil do
  begin
    succParent := succ;
    succ := succ^.HI;
  end;

  { Liberar la lista de paquetes actual del nodo A (vamos a sobrescribir datos) }
  LiberarListaPaquetesArbol(A^.datos.paquetes);

  { Copiamos el registro 'datos' del sucesor al nodo A }
  A^.datos := succ^.datos;

  { Evitamos doble-free: el sucesor ya no "posee" la lista de paquetes }
  succ^.datos.paquetes := Nil;

  { Ahora eliminamos físicamente el nodo 'succ' del árbol }
  if succParent = A then
    succParent^.HD := succ^.HD
  else
    succParent^.HI := succ^.HD;

  dispose(succ);
end;

{ Cuenta localmente los nodos de la lista de paquetes y devuelve el resultado en 'cant' }
procedure contarNodosListaPaquetesLocal(L: listaPaquetesArbol; Var cant: integer);
begin
  cant := 0;
  while L <> Nil do
  begin
    cant := cant + 1;
    L := L^.sig;
  end;
end;

{ Recorre el árbol y devuelve en minCnt la menor cantidad encontrada
  y en minNombre el nombre del destino correspondiente. }
procedure BuscarMinimo(A: arbol; Var minCnt: integer; Var minNombre: str70);
var
  cnt: integer;
begin
  if A = Nil then Exit;

  { recorrer izquierda }
  BuscarMinimo(A^.HI, minCnt, minNombre);

  { contar paquetes en este nodo (sin modificar la lista original) }
  contarNodosListaPaquetesLocal(A^.datos.paquetes, cnt);

  if cnt < minCnt then
  begin
    minCnt := cnt;
    minNombre := A^.datos.nombre;
  end;

  { recorrer derecha }
  BuscarMinimo(A^.HD, minCnt, minNombre);
end;



Procedure ImprimirArbol(A: arbol);

var
    aux: listaPaquetesArbol;

Begin
    If (A <> Nil) Then
        Begin
            ImprimirArbol(A^.HI);

            aux := A^.datos.paquetes;
writeln('PAIS: ', A^.datos.pais);
writeln('DESTINO: ', A^.datos.nombre);
while aux <> Nil do
begin
  writeln('El paquete del destino es: ');
  writeln('  ID: ', aux^.datos.identificador);

  { imprimir hotel como Si/No en vez de TRUE/FALSE }
  if aux^.datos.hotel then
    writeln('  Hotel: Si')
  else
    writeln('  Hotel: No');

  writeln('  Equipaje: ', aux^.datos.cant_equipaje);
  writeln('  Aerolinea: ', aux^.datos.aerolinea);

  writeln('  Fecha del paquete: ', aux^.datos.fecha.dia, '/', aux^.datos.fecha.mes, '/', aux^.datos.fecha.anio);

  aux := aux^.sig;
end;


            ImprimirArbol(A^.HD);
        End;
End;

Var
    l:   listaPaquetes;
    ArbolPrincipal:   arbol;
    sup, inf:   fecha;
    cantidad, min, minCnt:   integer;
    minNombre: str70;

Begin
    Randomize;

    l := Nil;
    crearLista(l); {carga automatica de la estructura disponible}
    writeln ('LISTA GENERADA: ');
    imprimirLista(l);

    ArbolPrincipal := Nil;

    InsertarArbolDesdeLista(l, ArbolPrincipal);
    ImprimirArbol(ArbolPrincipal);

    sup.dia := 20;
    sup.mes := 3;
    sup.anio := 2026;

    inf.dia := 1;
    inf.mes := 12;
    inf.anio := 2025;

    cantidad := 0;

    imprimirAcotadoDestino(ArbolPrincipal, 'Estambul', 'Madrid');
    contarAcotadoPorFecha(ArbolPrincipal, inf, sup, cantidad);
    writeln('La cantidad de destinos filtrados por fecha son ', cantidad);

    cantidad := 0;

  { Inicializar para la búsqueda del mínimo }
    minCnt := MaxInt;   { o 999999, lo que prefieras }
    minNombre := '';    { cadena vacía }

    BuscarMinimo(ArbolPrincipal, minCnt, minNombre);

    If minNombre <> '' Then
        Begin
            writeln('Destino con menos paquetes: ', minNombre, ' (', minCnt,
                    ' paquetes).');
            EliminarPorNombre(ArbolPrincipal, minNombre);
        End
    Else
        writeln('No se encontró ningún destino (árbol vacío).');


    writeln('El arbol final quedo como');

    writeln('===== ARBOL (in-order) =====');

    ImprimirArbol(ArbolPrincipal);
End.
