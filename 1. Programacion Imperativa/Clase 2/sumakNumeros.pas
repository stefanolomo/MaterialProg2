program SumaK_Numeros;

function SumaK_Numeros(k: integer): integer;

begin
  if (k = 1) then
    SumaK_Numeros := 1
  else begin
    SumaK_Numeros := SumaK_Numeros(k - 1) + k;
  end;
  
  if (k <= 0) then
    sumaK_Numeros := 0;
end;

var
  numero: integer;

begin
  writeln('Ingrese un numero para calcular la suma de naturales hasta k: ');
  
  readln(numero);
  
  write('La suma natural desde 0 hasta ', numero, ' es: ');
  write(SumaK_Numeros(numero));
  writeln();
end.
