
Program Arreglos;

Const 
    dimF =   8;  {Dimensi�n f�sica del vector}

Type 

    vector =   array [1..dimF] Of LongInt;

    dim =   0..dimF;

Function Maximo(V: vector):   integer;

Begin

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

Procedure digitoMaximo(n: integer; Var max: integer);

Var 
    dig:   integer;
Begin
    dig := n Mod 10;

    If ( dig > max ) Then
        max := dig;

    n := n Div 10;
    
    If (n <> 0) Then
        digitoMaximo(n, max);
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

Begin

    cargarVector(v,dimL);

    writeln('Nros almacenados: ');
    imprimirVector(v, dimL);

    readln;
End.
