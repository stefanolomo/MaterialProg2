
Program Recursion;

Var 
    num, maximo:   integer;

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

Begin
    maximo := -1;
    writeln( 'Ingrese un entero no negativo:');
    readln (num);
    digitoMaximo (num, maximo);
    writeln ( 'El digito maximo del numero ', num, ' es: ', maximo);
End.
