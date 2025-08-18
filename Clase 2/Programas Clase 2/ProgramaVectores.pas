
Program Arreglos;

Const
    dimF =   8;

Type

    vector =   array [1..dimF] Of LongInt;

    dim =   0..dimF;

Procedure Maximo(V: vector; dimL: dim; Var max: integer; var i: integer);

begin
    if (dimL = 0) then // Esta vacio
        writeln('El vector esta vacio');

    else If (V[i] > max) Then // Se halló un nuevo maximo
        max := V[i];

    If (i < dimL) Then begin // ¿Quedan posiciones para procesar?
        i := i + 1;
        Maximo(V, dimL, max, i); // Entonces seguir procesando en la posicion siguente (i + 1)
    end;
End;

Procedure Maximo(V: vector; dimL: dim; Var max: integer; var i: integer);

begin
    if (dimL = 0) then
        writeln('El vector esta vacio');
    else If (V[i] > max) Then
        max := V[i];

    If (i < dimL) Then begin
        i := i + 1;
        Maximo(V, dimL, max, i);
    end;
End;

{-----------------------------------------------------------------------------
CARGARVECTOR - Carga nros aleatorios entre 0 y 100 en el vector hasta que
llegue el nro 99 o hasta que se complete el vector}
Procedure cargarVector ( Var vec: vector; Var dimL: dim);

Var
    d:   integer;
Begin
    Randomize;  { Inicializa la secuencia de random a partir de una semilla}
    dimL := 0;
    d := random(100);
    While (d <> 99)  And ( dimL < dimF ) Do
        Begin
            dimL := dimL + 1;
            vec[dimL] := d;
            d := random(100);
        End;
End;

{-----------------------------------------------------------------------------
IMPRIMIRVECTOR - Imprime todos los nros del vector }
Procedure imprimirVector ( Var vec: vector; Var dimL: dim );

Var
    i:   dim;
Begin
    For i:= 1 To dimL Do
        write ('-----');
    writeln;
    write (' ');
    For i:= 1 To dimL Do
        Begin
            If (vec[i] < 9)Then
                write ('0');
            write(vec[i], ' | ');
        End;
    writeln;
    For i:= 1 To dimL Do
        write ('-----');
    writeln;
    writeln;
End;

{PROGRAMA PRINCIPAL}

Var
    v:   vector;
    dimL :   dim;
    max, i: integer;

Begin
    cargarVector(v, dimL);

    writeln('Nros almacenados: ');
    imprimirVector(v, dimL);

    max := -1;
    i := 1;
    Maximo(v, dimL, max, i);
    if (max <> -1) then
        writeln(max);
End.
