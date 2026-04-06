program tpfinal2019;

type
  puesto = 1..4;

  dato = record
    codResultado, codDisciplina: longint;
    disciplina, nombre, pais: String;
    puesto: puesto;
  end;

  lista = ^NodoLista;
  NodoLista = record
    dato: dato;
    sig: lista;
  end;
  
  {------------------------}
  
  listaPaises = ^NodoListaPaises;
  NodoListaPaises = record
    pais: String;
    sig: listaPaises
  end;
  
  datoNodoArbol = record
    disciplina: String;
    codDisciplina, total: longint;
    paises: listaPaises;
  end;
  Arbol = ^NodoArbol;
  NodoArbol = record
    dato: datoNodoArbol;
    HI, HD: Arbol;
  end;

procedure Separador();

begin
  writeln(' ');
  writeln('--------------------');
  writeln(' ');
end;

function LeerDato(): dato;

var
  DatoLeido: dato;

begin

  writeln('Ingrese el codigo de disciplina');
  readln(DatoLeido.codDisciplina);

  if (DatoLeido.codDisciplina <> -1) then begin
    writeln('Ingrese el codigo de resultado');
    readln(DatoLeido.codResultado);
  
    writeln('Ingrese el nombre del atleta');
    readln(DatoLeido.nombre);
  
    writeln('Ingrese el nombre del pais');
    readln(DatoLeido.pais);
  
    writeln('Ingrese el nombre de la disciplina');
    readln(DatoLeido.disciplina);
  
    writeln('Ingrese el puesto del atleta');
    readln(DatoLeido.puesto);
  end;
  Separador();
  LeerDato := DatoLeido;
end;

procedure InsertarEnListaDato(var L: lista; D: dato);

var
  act: lista;

begin
  if (L = nil) then begin
    new(L);
    L^.sig := nil;
    L^.dato := D;
  end else begin
    new(act);
    act^.sig := L;
    act^.dato := D;
    
    L := act;
  end;
end;

procedure CargarLista(var L: lista);

var
  DatoLeido: dato;

begin
  repeat
    DatoLeido := LeerDato();
    if (DatoLeido.codDisciplina <> -1) then
      InsertarEnListaDato(L, DatoLeido);
  until (DatoLeido.codDisciplina = -1); // Corta cuando el codDisciplina = -1
end;

procedure InsertarEnListaPaises(var L: listaPaises; P: String);

var
  act: listaPaises;

begin
  if (L = nil) then begin
    new(L);
    L^.sig := nil;
    L^.pais := P;
  end else begin
    new(act);
    act^.sig := L;
    act^.pais := P;
    
    L := act;
  end;
end;

procedure InsertarNodoEnArbol(var A: Arbol; L: lista);

begin
  if (A = nil) then begin
    new(A);
    A^.HI := nil;
    A^.HD := nil;
    A^.dato.disciplina := L^.dato.disciplina;
    A^.dato.codDisciplina := L^.dato.codDisciplina;
    A^.dato.total := 0;
    A^.dato.total := A^.dato.total + 1;
    InsertarEnListaPaises(A^.dato.paises, L^.dato.pais) 
    
  end else if (A^.dato.codDisciplina < L^.dato.codDisciplina) then // Si el valor era mayor, sigue por la rama derecha
    InsertarNodoEnArbol(A^.HD, L)
  else if (A^.dato.codDisciplina > L^.dato.codDisciplina) then // Si el valor era menor, sigue por la rama izquierda
    InsertarNodoEnArbol(A^.HI, L)
  else if (A^.dato.codDisciplina = L^.dato.codDisciplina) then begin
    A^.dato.total := A^.dato.total + 1;
    InsertarEnListaPaises(A^.dato.paises, L^.dato.pais);
  end;
end;


procedure CargarArbol(var A: Arbol; L: lista);

begin
  while (L <> nil) do begin
    InsertarNodoEnArbol(A, L);
    
    L := L^.sig;
  end;
end;

Procedure ImprimirData(D: datoNodoArbol);

begin
  writeln('Disciplina: ', D.disciplina, ', ', 'Codigo de disciplina: ', D.codDisciplina, ', ', 'Total de atletas: ', D.total);
end;

Procedure ImprimirArbol(A: Arbol);

begin
  if (A <> nil) then begin
    ImprimirArbol(A^.HI);
    ImprimirData(A^.dato);
    ImprimirArbol(A^.HD);
  end;
end;

function ImprimirCantidad(A: Arbol; sup, inf: longint): longint;
// punto b
begin
  ImprimirCantidad := 0;
  if (A <> nil) then begin
    if (A^.dato.codDisciplina <= sup) and (A^.dato.codDisciplina >= inf) then
      ImprimirCantidad := A^.dato.total + ImprimirCantidad(A^.HI, sup, inf) + ImprimirCantidad(A^.HD, sup, inf)
    else if (A^.dato.codDisciplina < sup) then
      ImprimirCantidad := ImprimirCantidad(A^.HD, sup, inf)
    else
      ImprimirCantidad := ImprimirCantidad(A^.HI, sup, inf);
  end;
end;

procedure ImprimirNombres(A: Arbol; inf, sup: longint);
// punto c
begin
  if (A <> nil) then begin
    // Si el actual esta dentro del rango
    if (A^.dato.total <= sup) and (A^.dato.total >= inf) then begin // Esta en rango
      ImprimirNombres(A^.HI, inf, sup);
      writeln('> Nombre de la disciplina en rango: ', A^.dato.disciplina);
      ImprimirNombres(A^.HD, inf, sup);
    end else
      ImprimirNombres(A^.HI, inf, sup);
      ImprimirNombres(A^.HD, inf, sup);
  end;
end;


var
  ListaInicial: lista;
  ArbolDis: Arbol;
  cantidadDeAtletas: longint;

begin
  ListaInicial := nil;
  CargarLista(ListaInicial);
  writeln('Ya se cargo la lista incial.');
  
  Separador();
  
  CargarArbol(ArbolDis, ListaInicial);
  writeln('Se cargo el arbol');
  
  Separador();
  writeln('Se va a imprimir el arbol carcado');
  ImprimirArbol(ArbolDis);
  
  Separador();
  writeln('Se va a imprimir la cantidad de atletas de las disciplinas con codigo entre 100 y 200.');
  cantidadDeAtletas := ImprimirCantidad(ArbolDis, 200, 100);
  
  if cantidadDeAtletas > 0 then writeln('La cantidad de atletas de las disciplinas con codigo entre 100 y 200 es de', cantidadDeAtletas, ' atletas')
  else writeln('No hay atletas que cumplan');
  
  Separador();
  writeln('Se va a imprimir los nombres de las disciplinas que tengan entre 100 y 200 atletas');
  ImprimirNombres(ArbolDis, 1, 3);
end.
