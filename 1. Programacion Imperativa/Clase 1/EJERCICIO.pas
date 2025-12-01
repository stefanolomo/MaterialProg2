Program productos;

Uses 
	sysutils;

Type 
    producto =   Record
        codigo:   integer;
        nombre:   string;
        marca:   string;
        anio:   2000..2022;
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
    v[1] := 'Abercom';
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
            For j:=random(5) Downto 1 Do {for de anio}
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

Var 
    l:   listaProductos;
Begin
    Randomize;

    l := Nil;
    crearLista(l);
    writeln ('Lista generada: ');
    imprimirLista(l);
    readln;
End.
