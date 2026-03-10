Program potenciaN;

function CalcularPotencia(base, potencia: integer): integer;

begin
  if (potencia = 0) then
    CalcularPotencia := 1
  else begin
    if (potencia < 0) then
      CalcularPotencia := 0
    else
      CalcularPotencia := CalcularPotencia(base, potencia - 1) * base;
  end;
end;

var
  base, potencia: integer;

begin
  writeln('Se va a calcular a^b.');
  
  writeln('Ingresar "a" (la base): ');
  readln(base);

  writeln('Ingresar "b" (la potencia): ');
  readln(potencia);
  
  write(base, '^', potencia, ' = ');
  write(CalcularPotencia(base, potencia));
  writeln();
end.
