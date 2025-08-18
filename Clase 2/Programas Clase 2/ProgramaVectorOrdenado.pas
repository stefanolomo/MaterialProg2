program VectorOrdenado;

const
    dimF = 8;  {Dimensi�n f�sica del vector}

type
    vector = array [1..dimF] of integer;
    dim = 0..dimF;

function BuscarEnVector(V: vector; dimL: dim; izq, der, dato: integer): integer;

var
    medio: integer;

begin
    if (dimL = 0) then begin
        writeln('El vector esta vacio');
        BuscarEnVector := 0;

    end else if (izq > der) then begin
        writeln('El dato no esta en el vector');
        BuscarEnVector := 0;

    end else if (dimL > 0) then begin
        medio := (der + izq) div 2;

        if (V[medio] = dato) then begin
            BuscarEnVector := medio;
        end else begin
            if (V[medio] < dato) then
                BuscarEnVector := BuscarEnVector(V, dimL, medio + 1, der, dato)
            else
                BuscarEnVector := BuscarEnVector(V, dimL, izq, medio - 1, dato);
        end;
    end;
end;

{-----------------------------------------------------------------------------
CARGARVECTORORDENADO - Carga ordenadamente nros aleatorios entre 0 y 100 en el
vector hasta que llegue el nro 99 o hasta que se complete el vector}

Procedure cargarVectorOrdenado ( var vec: vector; var dimL: dim);
var
   d, pos, j: integer;
begin
    Randomize;  { Inicializa la secuencia de random a partir de una semilla}
    dimL := 0;
    d:= random(100);
    while (d <> 99)  and ( dimL < dimF ) do begin
       pos:= 1;
       while (pos <= dimL) and (vec[pos]< d) do pos:= pos + 1;
       for  j:= dimL downto pos do vec[j+1]:= vec[j] ;
       vec[pos]:= d;
       dimL := dimL + 1;
       d:= random(100)
     end;
end;

{-----------------------------------------------------------------------------
IMPRIMIRVECTOR - Imprime todos los nros del vector }

Procedure imprimirVector ( var vec: vector; var dimL: dim );
var
   i: dim;
begin
     for i:= 1 to dimL do
         write ('-----');
     writeln;
     write (' ');
     for i:= 1 to dimL do begin
        if(vec[i] < 9)then
            write ('0');
        write(vec[i], ' | ');
     end;
     writeln;
     for i:= 1 to dimL do
         write ('-----');
     writeln;
     writeln;
End;

{PROGRAMA PRINCIPAL}
var
   v: vector;
   dimL : dim;
   numero: integer;

begin
    cargarVectorOrdenado(v,dimL);
    writeln('Nros almacenados: ');
    imprimirVector(v, dimL);

    numero := BuscarEnVector(v, dimL, 1, dimL, 2);

    if numero <> 0 then
        writeln('Se encontro el numero 2 en el arreglo. Esta en la posicion ', numero);
end.
