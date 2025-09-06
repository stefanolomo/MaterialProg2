Program juegos;
Uses
	sysutils;
Type
	sub = 1..4;

	disciplina = record
		cod: integer;
		codDisciplina: integer;
		nombreDisciplina: string;
		puesto: sub;
		nombreAtleta: string;
		pais: string;
	end;

	listaDisciplinas = ^nodoLista;
	nodoLista = record
		dato: disciplina;
		sig: listaDisciplinas;
	end;

        ListaPaises = ^nodoPaises;
        nodoPaises = record
                Pais:string;
                sig: ListaPaises;
        end;

        DisciplinaGeneral = record
                CodD: integer;
                NombreD: string;
                TotalParti: integer;
                Paises: ListaPaises;
        end;

        arbol =   ^nodoA;
        nodoA =   Record
              dato:   DisciplinaGeneral;
              HI:   arbol;
              HD:   arbol;
     End;

{-----------------------------------------------------------------------------
AgregarOrdenado - Agrega ordenado en l}
Procedure agregarOrdenado(var l: listaDisciplinas; d: disciplina);
var
   nuevo, anterior, actual: listaDisciplinas;
begin
	new (nuevo);
	nuevo^.dato:= d;
	nuevo^.sig := nil;

	actual := l;
	anterior := l;
	while (actual<>nil) and (actual^.dato.pais < nuevo^.dato.pais) do begin
	   anterior := actual;
	   actual:= actual^.sig;
	end;
	if (anterior = actual) then
	   l := nuevo
	else
	   anterior^.sig := nuevo;
	nuevo^.sig := actual;
end;

{-----------------------------------------------------------------------------
CREARLISTA - Genera una lista }
procedure crearLista(var l: listaDisciplinas);
var
  aux: integer;
  d: disciplina;
begin
  l:= nil;
  d.cod := random (100);

  while (d.cod <> 0) do Begin
        aux:=random(193)+1;
        if(aux<10)then
            d.pais:= Concat('Pais00',IntToStr(aux))
        else
            if(aux<100)then
                d.pais:= Concat('Pais0',IntToStr(aux))
	    else
                d.pais:= Concat('Pais',IntToStr(aux));
	d.codDisciplina:= random (299)+1;
	d.nombreDisciplina:= Concat('Disciplina', IntToStr(d.codDisciplina));
	d.puesto:= random (3)+1;
	d.nombreAtleta:= Concat('Atleta', IntToStr(random(5000)));
	agregarOrdenado(l,d);
	d.cod := random (100);
  end;
end;

procedure Separador();
begin
  writeln;
  writeln;
  writeln('----------------------------');
  writeln;
end;

Procedure Imprimir(dato: disciplina);
begin
  writeln('codigo de resultado: ',dato.cod);
  writeln('codigo de Disciplina: ',dato.codDisciplina);
  writeln('Nombre del Atleta: ',dato.nombreAtleta);
  writeln('Nombre De la Disciplina: ',dato.nombreDisciplina);
  writeln('Puesto: ',dato.puesto);
  writeln('Pais: ',dato.pais);
end;

{-----------------------------------------------------------------------------
IMPRIMIRLISTA - Muestra en pantalla la lista l }
procedure imprimirLista(l: listaDisciplinas);
begin
  while (l <> nil) do begin
   imprimir(l^.dato);
   l:= l^.sig;
   separador();
  end;
end;

Procedure agregarPais(Var l: ListaPaises; Pais:string);

Var
    aux:   listaPaises;
Begin
    new(aux);
    aux^.Pais := Pais;
    aux^.sig := l;
    l := aux;
End;

Procedure InsertarDisciplinaNodoArbol(Var A: arbol; dato: disciplina);

Var
    aux:   arbol;

Begin
    new(aux);

    aux^.dato.CodD:=dato.codDisciplina;
    aux^.dato.NombreD:=dato.nombreDisciplina;
    aux^.dato.TotalParti:=1;
    aux ^.dato.Paises:=nil;
    AgregarPais(aux^.dato.Paises,dato.pais);
    aux^.HI := Nil;
    aux^.HD := Nil;

    A := aux;
End;

Function ExistenciaPais(l:ListaPaises; Pais:string):boolean;
var existe:boolean;
begin
  existe:=false;
  while (l <> nil)and(existe=false) do begin
   if (l^.Pais=Pais)then existe:=true;
   l:= l^.sig;
  end;
  ExistenciaPais:=existe;
end;

Procedure InsertarDisciplinaArbol(Var A: arbol; dato: disciplina);

Begin
    If (A = Nil) Then
        InsertarDisciplinaNodoArbol(A, dato)
    Else If (A^.dato.CodD > dato.codDisciplina) Then
             InsertarDisciplinaArbol(A^.HI, dato)
    Else if (A^.dato.CodD < dato.codDisciplina) then
        InsertarDisciplinaArbol(A^.HD, dato)
         else begin
              if(not ExistenciaPais(a^.dato.Paises,dato.pais))then
              AgregarPais(A^.dato.Paises,dato.pais);
              A^.dato.TotalParti:=A^.dato.TotalParti+1;
         end;
End;

Procedure InsertarArbolDesdeLista(L: ListaDisciplinas; Var A: arbol);
Begin
    While (L <> Nil) Do
        Begin
            InsertarDisciplinaArbol(A, L^.dato);
            L:=L^.sig;
        End;
End;

Procedure SumaAcotada(a: arbol; inf:integer; sup:integer;var suma:integer);

Begin
    If (a <> Nil) Then
        If (a^.dato.CodD >= inf) Then // Si el dato es mayor o igual a la cota inferior
            If (a^.dato.CodD <= sup) Then Begin // Y también menor o igual a la cota superior
                suma:=suma+a^.dato.TotalParti; // Imprimirlo
                SumaAcotada(a^.hi, inf, sup,suma); // Seguir en su rama derecha
                SumaAcotada(a^.hd, inf, sup,suma); // y seguir en su rama izquierda
            End Else
                // El dato es mayor o igual la cota menor pero se pasa de la cota superior, entonces seguir a la izquierda donde hay datos menores a el
                SumaAcotada(a^.hi, inf, sup,suma)
        Else
        // El dato es menor a la cota inferior (a ambas) entonces seguir a la derecha donde hay datos mayores a el
        SumaAcotada(a^.hd, inf, sup,suma);
End;

Procedure ImprimirPaises(L: ListaPaises);
begin
  writeln('Lista de Paises: ');
  while (l<>nil)do
      begin
       write(l^.Pais,' - ');
       l:=l^.sig;
      end;
end;


Procedure ImprimirDisciplina(dato:DisciplinaGeneral);
begin
  writeln('Codigo de la Disciplina: ',dato.CodD);
  writeln('Nombre de la Disciplina: ',dato.NombreD);
  writeln('Total de Participantes: ',dato.TotalParti);
  ImprimirPaises(dato.Paises);
  separador();
end;

Procedure enOrden( A:
                   arbol );
Begin
    If ( A <> Nil ) Then
        Begin
            enOrden (a^.HI);
            ImprimirDisciplina(a^.dato);
            enOrden (a^.HD)
        End;
End;

procedure disciplinascontanto(a:arbol; inf:integer; sup:integer);
begin
    If ( A <> Nil ) Then
        Begin
            disciplinascontanto (a^.HI,inf,sup);
            if (a^.dato.TotalParti>=inf)and(a^.dato.TotalParti<=sup)then
            write(a^.dato.NombreD,' - ');
            disciplinascontanto (a^.HD,inf,sup)
        End;
end;

Var

 l: listaDisciplinas;
 A: arbol;
 suma:integer;

begin
 Randomize;
 A:=nil;
 crearLista(l);
 writeln ('Lista generada: ');
 separador();
 imprimirLista(l);
 separador();
 InsertarArbolDesdeLista(L,A);
 EnOrden(a);
 separador();
 SumaAcotada(a,100,200,suma);
 writeln('Hay ',suma, ' atletas con codigo de disciplina entre 100 y 200');
 separador();
 writeln('Paises con entre 100 y 200 atletas: ');
 DisciplinasConTanto(a,100,200);
 writeln('Fin del programa');
 readln;
end.