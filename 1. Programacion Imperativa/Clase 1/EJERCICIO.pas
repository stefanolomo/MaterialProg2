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
     while (l <> nil) do begin
         marcaAct := l^.dato.marca;
         totalMarca := 0;
        while (l^.dato.marca = marcaAct) do begin
              writeln('Para la marca ', marcaAct, ': ');
              anioActual:=l^.dato.anio;
              totalAnio := 0;
              while (l^.dato.anio = anioActual) do begin
                  writeln('Para el año ', anioActual, ': ');
                  imprimirAnio(l^.dato);
                  totalAnio := totalAnio + 1;

              end;
              totalMarca := totalMarca + totalAnio;
              writeln('Para el anio ', anioActual, ' hay, ', totalAnio, ' productos');
              l := l^.sig;
        end;
        writeln('Para la marca ', marcaAct, ' hay, ', totalMarca, ' productos');
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
