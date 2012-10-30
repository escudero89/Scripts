#! /usr/bin/octave -qf
1;

% Te plotea la linea de tendencia con los puntos
function [a0 a1 error] = minimos_cuadrados(x, y)

	[a0 a1] = get_coeff(x, y);

	clf;
	hold on;
	% Ploteamos los puntos
	plot(x, y, 'ro');

	% Y ahora la linea de tendencia P(x) = a_1 * x + a_0
	P = a1 * x + a0;

	plot(x, P, 'b');
	hold off;

	% Calculamos el error
	error = sum((y - (a1 * x + a0)).^2);
	
end

% Devuelve la solucion de las ecuaciones normales
function [a0 a1] = get_coeff(x, y)

	m = length(x);

	x_sum = x_cuad = 0;
	y_sum = xy = 0;

	for i = 1 : m
		x_sum += x(i);
		x_cuad += x(i)^2;

		y_sum += y(i);
		
		xy += x(i) * y(i);
	end

	a0 = ( x_cuad * y_sum - xy * x_sum ) / ( m * x_cuad - (x_sum)^2);
	a1 = ( m * xy - y_sum * x_sum ) / ( m * x_cuad - (x_sum)^2);

end

xbase = [1 : 10];
ybase = [1.3 3.5 4.2 5.0 7 8.8 10.1 12.5 13 15.6];

ybase = [7.0 9.4 12.3];
xbase = [2 4 6];

[a0 a1 error] = minimos_cuadrados(ybase, xbase)

ybase = [8.3 11.3 14.4 15.9];
xbase = [3 5 8 10];

pause;
[a0 a1 error] = minimos_cuadrados(ybase, xbase)
