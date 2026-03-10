Program Fibonacchi;

function CalcularFibo(k: integer): integer;

begin
  if (k <= 1) then
    CalcularFibo := k
  else begin
    CalcularFibo := CalcularFibo(k - 1) + CalcularFibo(k - 2);
  end
end;

var
  numero: integer;

begin
  writeln('Se va a calcular la secuencia de fibonacchi desde 0 hasta "k".');
  
  writeln('Ingresar "k": ');
  readln(numero);
  
  write('La serie de fibonacchi hasta ', numero, ' es igual a ');
  write(CalcularFibo(numero));
  writeln();
end.
