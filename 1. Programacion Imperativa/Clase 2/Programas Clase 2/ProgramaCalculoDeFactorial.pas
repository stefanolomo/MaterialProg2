Program CalculoDeFactorial;

Function Factorial(n: Integer):   Int64;

Var 
    i:   Integer;
    result:   Int64;
Begin
    If n < 0 Then
        writeln('No hay factorial de nros negativos');
    result := 1;
    For i := 2 To n Do
        result := result * i;
    Factorial := result;
End;


{PROGRAMA PRINCIPAL}

Var 
    num:   integer;
Begin

    writeln( 'Ingrese un entero no negativo:');
    readln (num);

    writeln ( num, '! = ', factorial(num));
End.
