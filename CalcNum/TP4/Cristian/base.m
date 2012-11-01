#! /usr/bin/octave -qf
1;

% Funciones derivadas para usarlas en Newton-Raphson

function [y] = f1_prima(x)
	y = sec(x)^2;
	return;
end

function [y] = f2_prima(x)
	y = 2 * x;
	return;
end

function [y] = f3_prima(x)
	y = -cos(1 / x) / x + sin(1 / x) + 1;
	return;
end

% Para el punto fijo, g(x) = f(x) + x

function [g] = f1_puntofijo(x)
	g = x - e5a_tan(x);
	return;
end

function [g] = f2_puntofijo(x)
	g = x - e5b_polinomio(x);
	return;
end

function [g] = f3_puntofijo(x)
	g = x - e5c_sin(x);
	return;
end

% Codigo base desde aca

function show_something(x, h, titlelabel = '', it = 1, fase = 1)

	x
	iteraciones = length(h)
	toc;
	
	disp('-------------------------------------------------------------------');
#{
	figure(1);
	show_something_helper(x, h, titlelabel, it);
	print(['img/' fase '/all_' fase '.png']);

	figure(it);
	show_something_helper(x, h, titlelabel, it);
	print(['img/' fase '/' titlelabel '_' fase '.png']); 
#}
end

function show_something_helper(x, h, titlelabel, it)
	color = ['r', 'g', 'b', 'm', 'c'];

	plot([1 : length(h)], log(h), color(it));

	grid on;
	xlabel('iteraciones');
	ylabel('log(h)');
end

% Mis funciones son: e5a_tan, e5b_polinomio, e5c_sin

% Para ploteo
clf;
close all;
hold on;

x_min_max = [-0.49 0.51 ];

kmax = 100;
tol = 10e-7;

f1 = @e5a_tan;
f2 = @e5b_polinomio;
f3 = @e5c_sin;

f1_puntofijo = @f1_puntofijo;
f2_puntofijo = @f2_puntofijo;
f3_puntofijo = @f3_puntofijo;

f1_prima = @f1_prima;
f2_prima = @f2_prima;
f3_prima = @f3_prima;

metodos = [
	'Biseccion'; 
	'Punto fijo'; 
	'Secante'; 
	'Posicion falsa'; 
	'Newton-Raphson'
];

metodos_length = [9, 10, 7, 14, 14];

% k varia entre 1 a 3
k = 3;

xmin = x_min_max(1);
xmax = x_min_max(2);

x0 = xmin;

f_prima = f1_prima;

switch k
	case {1}
		f = f1;
		f_prima = f1_prima;
		f_pf = f1_puntofijo;
	case {2}
		f = f2;
		f_prima = f2_prima;
		f_pf = f2_puntofijo;
	case {3}
		f = f3;
		f_prima = f3_prima;
		f_pf = f3_puntofijo;
	otherwise
		disp 'error.'
end

for met = 1 : 5
	tic;
	disp([metodos(met, 1:metodos_length(met)) ':']);

	switch met
		case {1}
			[x, h] = biseccion(f, xmin, xmax, kmax, tol);
		case {2}
			[x, h] = puntofijo(f_pf, x0, kmax, tol);
		case {3}
			[x, h] = secante(f, xmin, xmax, kmax, tol);
		case {4}
			[x, h] = posicionfalsa(f, xmin, xmax, kmax, tol);
		case {5}
			[x, h] = newton(f, f_prima, x0, kmax, tol);
		otherwise
			disp 'error2.'
	end

	show_something(x, h, metodos(met, 1:metodos_length(met)), met, num2str(k));

end


hold off;

close all;
