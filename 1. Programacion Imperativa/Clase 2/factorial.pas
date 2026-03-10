program factorialPascal;

function funcionfactorial(n: integer): integer;

begin
  if (n = 1) then
    funcionfactorial := 1
  else begin
    funcionfactorial := n * funcionfactorial(n - 1);
  end;
end;

var
  numero: integer;

begin
  writeln('Ingrese un numero para tomar el factorial');
  
  readln(numero);
  
  write('El factorial de ', numero, ' es: ');
  write(FuncionFactorial(numero));
  writeln();
end.
