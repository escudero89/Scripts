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
	x_sort = sort(x);
	P = a1 * x_sort + a0;

	plot(x_sort, P, 'b');

	grid; xlabel('l'); ylabel('F(l)');
	xlim([6 16]); ylim([0 10]);

	hold off;

	% Calculamos el error
	error = sum((y - (a1 * x + a0)).^2)/length(x);
	
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

ybase = [7.0 9.4 12.3];
xbase = [2 4 6];

figure(1);
[a0 a1 error] = minimos_cuadrados(ybase, xbase)

% Le agregamos datos adicionales
ybase = [ybase 8.3 11.3 14.4 15.9];
xbase = [xbase 3 5 8 10];

figure(2);
pause;
[a0 a1 error] = minimos_cuadrados(ybase, xbase)
