% x = [0.9 1.3 1.9 2.1 2.6 3.0 3.9 4.4 4.7 5.0 6.0 7.0 8.0 9.2 10.5 11.3 11.6 12.0 12.6 13.0 13.3 ]
% f = [1.3 1.5 1.85 2.1 2.6 2.7 2.4 2.15 2.05 2.1 2.25 2.3 2.25 1.95 1.4 0.9 0.7 0.6 0.5 0.4 0.25]

% Entre una trazadora natural y cubica solo cambia la forma que se obtiene c
function [a, b, c , d] = cubic_spline(x, f, sujeto = false, f_prima_a = 0.0, f_prima_b = 0.0)

	n = length(x);

	a = zeros(n, 1);
	b = zeros(n, 1);
	c = zeros(n, 1);
	d = zeros(n, 1);

	% Condicion (1), obtenemos los n coeficientes de a_i
	for i = 1 : n - 1
		a(i) = f(i);
		h(i) = x(i + 1) - x(i);
	end

	a(n) = f(n);

	% Obtengo mis valores de c
	c = get_c(h, a, sujeto, f_prima_a, f_prima_b);

	for j = 1 : n - 1

		b(j) = 1 / h(j) * (a(j + 1) - a(j)) - h(j) / 3 * (2 * c(j) + c(j + 1));
		d(j) = (c(j + 1) - c(j)) / (h(j) * 3);

	end

	% Esto es un extra, para plotear directamente los splines

	paso = 0.01;

	color = ['r', 'g', 'b', 'c', 'm', 'y'];

	clf;
	hold on;
	for k = 1 : n - 1
		equises = [ x(k) : paso : x(k + 1) ];

		dif = (equises - x(k));

		funciones = a(k) + b(k) .* dif + c(k) .* dif.^2 + d(k) .* dif.^3; 
		
		plot(equises, funciones, color(mod(k, length(color)) + 1));
	end
	hold off;

end

% Determinamos los valores de c para resolver el sistema de ecuaciones 
% para un trazador natural, o sujeto, segun parametro
function [c, A] = get_c(h, a, sujeto = true, f_prima_a = 0.0, f_prima_b = 0.0)

	n = length(a);

	A = zeros(n, n);
	b = zeros(n, 1);

	if (!sujeto)
		% En los extremos valdra 1 si es el natural
		A(1, 1) = A(n, n) = 1;
	else
		% En mi primer y ultimo elemento de la diagonal de A, hacemos cambios
		A(1, 1) = 2 * h(1);
		A(n, n) = 2 * h(n - 1);

		% Tambien cambian los valores de b en los extremos
		b(1) = 3 / h(1) * (a(2) - a(1)) - 3 * f_prima_a;
		b(n) = 3 * f_prima_b - 3 / h(n - 1) * (a(n) - a(n - 1));
	end

	% El resto del algoritmo es igual para ambos
	for j = 2 : n - 1

		A(j, j - 1) = h(j - 1);
		A(j, j) = 2 * (h(j - 1) + h(j));
		A(j, j + 1) = h(j);

		b(j) = 3/h(j) * (a(j + 1) - a(j)) \
			 - 3/h(j - 1) * (a(j) - a(j - 1));
	end

	c = A \ b;

end