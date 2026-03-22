Program ejercicio3;

Uses
     sysutils;
Type
     pedido= record
	      codSeg: longint;
	      fechaYhora: string;
	      dni: longint;
	      codArea: longint;
        domicilio: string;
        tel: string;
     end;

     listaPedidos = ^nodoLista;
     nodoLista = record
      dato: pedido;
      sig: listaPedidos;
     end;
    
  {--------------------}
     
  ListaDni = ^NodoListaDni;
  NodoListaDni = record
    dni: longint;
    sig: ListaDni;
  end;
     
  DatoNodoArbol = record
    area, pedidos: longint;
    clientes: ListaDni;
  end;
  
  Arbol = ^NodoArbol;
  NodoArbol = record
    dato: DatoNodoArbol;
    HI, HD: Arbol;
  end;

procedure agregarLista(var pri:listaPedidos; p:pedido);
var
  nuevo, anterior, actual: listaPedidos;
begin
    new (nuevo);
    nuevo^.dato:= p;
    nuevo^.sig := nil;
    if (pri = nil) then
         pri := nuevo
    else
    begin
         actual := pri;
         anterior := pri;
         while (actual<>nil) and (actual^.dato.dni < nuevo^.dato.dni) do begin
              anterior := actual;
              actual:= actual^.sig;
         end;
         if (anterior = actual) then
              pri := nuevo
         else
              anterior^.sig := nuevo;
         nuevo^.sig := actual;
    end;
end;


function cargarFecha(): string;{Genera una FECHA aleatoria}
var
  dia, mes, hora, seg: longint;
  s: string;
begin
  dia := random(30)+1;
  mes := random(12)+1;
  s := Concat(IntToStr(dia),'/',IntToStr(mes),'/2020 - ');
  hora := random(24);
  seg := random(60);
  if(hora < 10)then
	s := Concat(s, '0', IntToStr(hora))
  else
	s:= Concat(s, IntToStr(hora));
  if(seg < 10)then
	s := Concat(s, ':0', IntToStr(seg))
  else
	s:= Concat(s,':', IntToStr(seg));
  cargarFecha:= s;
end;

procedure crearLista(var l: listaPedidos);
var
   cant, cod: longint;
   p: pedido;
begin
     cant:= random(10); {genera hasta 100 elementos}
     cod:= 1;
     while (cant <> 0) do Begin
          p.codSeg:= cod;  {codigo de seguimiento}
          p.fechaYhora := cargarFecha();
          p.dni := random(60000000);  {dni}
          p.codArea := (random(4000)); {codigo de área}
          p.domicilio:= Concat('Domicilio', IntToStr(cod)); {domicilio}
          p.tel:= IntToStr(random(999999)+4000000); {telefono}
          agregarLista(l, p);
          cant:= cant-1;
          cod := cod+1;
     end;
end;

procedure imprimirPedido(p:pedido);
begin
    with(p)do
         writeln('El pedido ',codSeg, ' del cliente ', dni, ' sera atendido en la fecha ', fechaYhora, ' en el codigo de area ', codArea, ' y domicilio ', domicilio, ' con tel. de contacto ', tel);
end;

procedure imprimirLista(l:listaPedidos);
begin
    while(l<>nil)do
    begin
         imprimirPedido(l^.dato);
         l:=l^.sig;
    end;
end;

procedure InsertarEnArbol(var A: Arbol; D: pedido);

var
  aux: ListaDni;

begin
  if (A = nil) then begin
    new(A);
    A^.dato.pedidos := 1;
    A^.dato.area := D.codArea;
    A^.HI := nil;
    A^.HD := nil;
    
    new(A^.dato.clientes);
    with (A^.dato.clientes^) do begin
      dni := D.dni;
      sig := nil;
    end;
  end else if (A^.dato.area < D.codArea) then
    InsertarEnArbol(A^.HD, D)
  else if (A^.dato.area > D.codArea) then
    InsertarEnarbol(A^.HI, D)
  else if (A^.dato.area = D.codArea) then begin
    A^.dato.pedidos := A^.dato.pedidos + 1;
    if (A^.dato.clientes <> nil) then begin
      new(aux);
      aux^.sig := A^.dato.clientes;
      aux^.dni := D.dni;
      
      A^.dato.clientes := aux;
    end;
  end;
end;

function CargarArbol(L: listaPedidos): Arbol;

var
  aux: Arbol;

begin
  if (L = nil) then
    CargarArbol := nil
  else begin
    aux := nil;
    while (L <> nil) do begin
      InsertarEnArbol(aux, L^.dato);
      
      L := L^.sig;
    end;
    
    CargarArbol := aux;
  end;
end;

procedure AreaMenosPedida(A: arbol; var minPedidos, areaMin: longint);

begin
  if (A <> nil) then begin
    // Busca el area con menos pedidos en la izquierda
    AreaMenosPedida(A^.HI, minPedidos, areaMin);
    
    // Busca el area con menos pedidos en la derecha (Si encuentra menor, sobreescribe)
    AreaMenosPedida(A^.HD, minPedidos, areaMin);
  
    // Si el nodo actual tiene menos, es el menor
    if (A^.dato.pedidos < minPedidos) then begin
      minPedidos := A^.dato.pedidos;
      areaMin := A^.dato.area;
    end;
  end;
end;

procedure ImprimirAcotadoDnis(A: Arbol; sup, inf: longint);

var
  aux: ListaDni;

begin
  if (A <> nil) then begin
    if (A^.dato.area > sup) then
      ImprimirAcotadoDnis(A^.HI, sup, inf)
    else begin
      if (A^.dato.area >= inf) then begin
        ImprimirAcotadoDnis(A^.HI, sup, inf);
        
        // Esta en rango
        aux := A^.dato.clientes; // Imprimir los Dnis
        while (aux <> nil) do begin
          writeln('Cliente en rango para el codigo ', A^.dato.area, '. Dni: ', aux^.dni);
          aux := aux^.sig;
        end;
        
        ImprimirAcotadoDnis(A^.HD, sup, inf);
      end else
        ImprimirAcotadoDnis(A^.HD, sup, inf);
    end;
  end;
end;

procedure ImprimirAcotadoDnis2(A: Arbol; sup, inf: longint);

var
  aux: ListaDni;

begin
  if (A <> nil) then begin
    if (A^.dato.area > inf) then // El rango esta hacia la izquierda
      ImprimirAcotadoDnis(A^.HI, sup, inf);
      
    if (A^.dato.area >= inf) and (A^.dato.area <= sup) then begin // Esta en rango
      aux := A^.dato.clientes;
      while (aux <> nil) do begin
        writeln('Cliente en rango para el codigo ', A^.dato.area, '. Dni: ', aux^.dni);
        aux := aux^.sig;
      end;
    end;
    
    if (A^.dato.area < sup) then // El rango esta hacia la derecha
      ImprimirAcotadoDnis(A^.HD, sup, inf);
  end;
end;

procedure ImprimirDnisArea(A: Arbol; area: longint);

var
  aux: ListaDni;

begin
  if (A <> nil) then begin
    if (A^.dato.area < area) then
      ImprimirDnisArea(A^.HD, area)
    else if (A^.dato.area > area) then
      ImprimirDnisArea(A^.HI, area)
    else begin // Es el codigo buscado
      aux := A^.dato.clientes;
      writeln('Clientes en el area ', A^.dato.area, ':');
      while (aux <> nil) do begin
        writeln('| Dni: ', aux^.dni);
        aux := aux^.sig;
      end;
    end;
  end;
end;

var
  ListaInicial: listaPedidos;
  ArbolNuevo: Arbol;
  minPedidos, minArea, areaClientes: longint;

begin
     Randomize;
     {Se crea la estructura inicial}
     ListaInicial := nil;
     crearLista(ListaInicial);
     writeln ('Lista: ');
     imprimirLista(ListaInicial);

  {Completar el programa}

  writeln('Se va a cargar la lista a la nueva estructura (Arbol, ordenado por codigo de area)...');
  ArbolNuevo := nil;
  ArbolNuevo := CargarArbol(ListaInicial);
  
  writeln('Se va a buscar el area con menor cantidad de pedidos');
  minPedidos := 9999;
  minArea := 0;
  AreaMenosPedida(ArbolNuevo, minPedidos, minArea);
  writeln('El area con menos pedidos es la ', minArea, ' que cuenta con ', minPedidos, ' pedidos.');
  
  writeln('Se va a imprimir los clientes ordenados por codigo de area que esten entre 1000 y 2000...');
  ImprimirAcotadoDnis(ArbolNuevo, 2000, 1000);
  
  writeln('Ingrese un numero de area para imprimir sus clientes: ');
  readln(areaClientes);
  ImprimirDnisArea(ArbolNuevo, areaClientes);
end.
