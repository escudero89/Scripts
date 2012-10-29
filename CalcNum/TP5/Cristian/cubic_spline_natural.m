% x = [0.9 1.3 1.9 2.1 2.6 3.0 3.9 4.4 4.7 5.0 6.0 7.0 8.0 9.2 10.5 11.3 11.6 12.0 12.6 13.0 13.3 ]
% f = [1.3 1.5 1.85 2.1 2.6 2.7 2.4 2.15 2.05 2.1 2.25 2.3 2.25 1.95 1.4 0.9 0.7 0.6 0.5 0.4 0.25]
function [a, b, c , d] = cubic_spline_natural(x, f, natural = true, f_prima_a = 0.0, f_prima_b = 0.0)

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
	c = get_c(h, a, natural, f_prima_a, f_prima_b);

	for j = 1 : n - 1

		b(j) = 1 / h(j) * (a(j + 1) - a(j)) - h(j) / 3 * (2 * c(j) + c(j + 1));
		d(j) = (c(j + 1) - c(j)) / (h(j) * 3);

	end

end

% Determinamos los valores de c para resolver el sistema de ecuaciones 
% para un trazador natural, o sujeto, segun parametro
function [c, A] = get_c(h, a, natural = true, f_prima_a = 0.0, f_prima_b = 0.0)

	n = length(a);

	A = zeros(n, n);
	b = zeros(n, 1);

	if (natural)
		% En los extremos valdra 1
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

% Para un trazador sujeto, determinamos c
function [c] = get_c(h, a, f_prima_a, f_prima_b)

	n = length(a);

	% Llamo a mi otra funcion para obtener la matriz A
	[trash, A] = get_c(h, a);

	% En mi primer y ultimo elemento de la diagonal de A, hacemos cambios
	A(1, 1) = 2 * h(1);
	A(n, n) = 2 * h(n - 1);



end