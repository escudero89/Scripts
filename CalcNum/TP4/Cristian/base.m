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
	y = -cos(1 / x) / x + sin(1 / x) + 1
	return;
end

% Codigo base d esde aca

function show_something(x, h)
	x
	iteraciones = length(h)
	toc;
	
	disp("-------------------------------------------------------------------");
end

% Mis funciones son: e5a_tan, e5b_polinomio, e5c_sin

x_min_max = [-0.49 0.51 ];

kmax = 10000;
tol = 10e-7;

f1 = @e5a_tan;
f2 = @e5b_polinomio;
f3 = @e5c_sin;

f1_prima = @f1_prima;
f2_prima = @f2_prima;
f3_prima = @f3_prima;

for k = 1 : 3

	xmin = x_min_max(1);
	xmax = x_min_max(2);
	
	x0 = xmin;
	
	f_prima = f1_prima;

	switch k
		case {1}
			f = f1;
			f_prima = f1_prima;
		case {2}
			f = f2;
			f_prima = f2_prima;
		case {3}
			f = f3;
			f_prima = f3_prima;
		otherwise
			disp "error."
	end

	tic;
	disp "Biseccion: "
	[x, h] = biseccion(f, xmin, xmax, kmax, tol);
	show_something(x, h);

	tic;
	disp "Punto fijo: "
	[x, h] = puntofijo(f, x0, kmax, tol);
	show_something(x, h);
	
	tic;
	disp "Secante: "	
	[x, h] = secante(f, xmin, xmax, kmax, tol);
	show_something(x, h);
	
	tic;
	disp "Posicion falsa: "
	[x, h] = posicionfalsa(f, xmin, xmax, kmax, tol);
	show_something(x, h);
	
	tic;
	disp "Newton-Raphson: "
	[x, h] = newton(f, f_prima, x0, kmax, tol);
	show_something(x, h);
	
end
