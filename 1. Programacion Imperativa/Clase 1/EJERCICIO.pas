Program productos;

Uses 
	sysutils;

Type 
    producto =   Record
        codigo:   integer;
        nombre:   string;
        marca:   string;
        anio:   integer;
        precio:   real;
    End;

    listaProductos =   ^nodoLista;
    nodoLista =   Record
        dato:   producto;
        sig:   listaProductos;
    End;

Procedure agregarAdelante(Var l: listaProductos; p: producto);

Var 
    aux:   listaProductos;
Begin
    new(aux);
    aux^.dato := p;
    aux^.sig := l;
    l := aux;
End;

{crearLista - Genera una lista con productos aleatorios}
Procedure crearLista(Var l: listaProductos);

Var 
    i,j:   integer;
    p:   producto;

    v :   array [1..10] Of string;
Begin
    v[1] := 'AberCom';
    v[2] := 'Aluminium';
    v[3] := 'ClearWindows';
    v[4] := 'IndArg';
    v[5] := 'La Foret';
    v[6] := 'Open';
    v[7] := 'Portal';
    v[8] := 'Puertamania';
    v[9] := 'PVCPremium';
    v[10] := 'Ventalum';

    For i:=random(10) Downto 1 Do {for de marca}
        Begin
            p.marca := v[i];
            For j:=random(10) Downto 1 Do {for de anio}
                Begin
                    p.anio := 2016+j;
                    p.codigo := random(10);
                    While (p.codigo <> 0) Do
                        Begin
                            p.nombre := Concat('Producto-', IntToStr(random (200
                                        )));
                            p.precio := random(1000000);
                            agregarAdelante(l, p);
                            p.codigo := random(10);
                        End;
                End;
        End;
End;


{imprimir - Muestra en pantalla el producto}
Procedure imprimir(p: producto);
Begin
    With (p) Do
        Begin
            writeln('Producto', nombre, ' con codigo ',codigo, ': ', marca,
                    ' Anio:', anio, ' Precio: ', precio:2:2);
        End;
End;


{imprimirLista - Muestra en pantalla la lista l}
Procedure imprimirLista(l: listaProductos);
Begin
    While (l <> Nil) Do
        Begin
            imprimir(l^.dato);
            l := l^.sig;
        End;
End;

Function contarAberCom(l: listaProductos): integer;

var
   count: integer;

begin
    count := 0;
    while (l <> nil) and (l^.dato.marca <= 'AberCom') do begin
        if (l^.dato.marca = 'AberCom') then begin
          if (l^.dato.anio <= 2023) and (l^.dato.anio >= 2020) then
             if (l^.dato.precio > 100000) then
                count := count + 1;
        end;
        l := l^.sig;
    end;

    contarAberCom := count;
end;

Procedure imprimirAnio(p: producto);
Begin
    With (p) Do
        Begin
            writeln('Producto', nombre, ' con codigo ',codigo, ' Precio: ', precio:2:2);
        End;
End;

Procedure ImprimirReporte(l: listaProductos);

var
   totalAnio, anioActual, totalMarca: integer;
   marcaAct: string;

begin
    while (l <> nil) do begin // Si la lista no esta vacia...
        marcaAct := l^.dato.marca; // Guarda la marca
        totalMarca := 0; // Setea el total en 0
        writeln('Para la marca ', marcaAct, ': '); // Imprime el nombre de la marca

        while (l <> nil) and (l^.dato.marca = marcaAct) do begin // si no esta vacia y ademas la marca es la misma que venia procesando...
            anioActual := l^.dato.anio; // Guarda el año
            totalAnio := 0; // Setea el total de ese año en 0
            writeln('  Para el año ', anioActual, ': '); // Imprime el año

            while (l <> nil) and (l^.dato.marca = marcaAct) and (l^.dato.anio = anioActual) do begin
                  // Si la lista:
                  // - No esta vacia
                  // - Es de la misma marca que veniamos procesando
                  // - Es del mismo año que veniamos procesando
                imprimirAnio(l^.dato); // Imprime los datos del producto
                totalAnio := totalAnio + 1; // Le suma a el total de productos de ese año

                l := l^.sig; // Pasamos al siguiente producto (Avanza el puntero)
            end;
            // Cuando terminó, estamos en un nuevo año
            totalMarca := totalMarca + totalAnio; // Se guarda el total del año que ya procesó en el total de la marca
            writeln('  Para el año ', anioActual, ' hay ', totalAnio, ' productos.'); // Imprime el total para el año procesado
        end;
        // Cuando terminó, estamos en una nueva marca
        writeln('Para la marca ', marcaAct, ' en total hay ', totalMarca, ' productos.');
        // Imprime el total de la la marca que fuimos actualizando cada año.
        writeln('------------------------------------------------');
    end;
end;

Var 
    l:   listaProductos;
    cantidad: integer;
Begin
    Randomize;

    l := Nil;
    crearLista(l);
    writeln ('Lista generada: ');
    imprimirLista(l);

    writeln('La cantidad de productos de aber com pedidos es:');

    cantidad := 0;
    cantidad := contarAberCom(l);
    writeln(cantidad);

    writeln('--------');

    ImprimirReporte(l);
End.
