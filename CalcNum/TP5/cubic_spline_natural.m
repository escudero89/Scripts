% x = [0.9 1.3 1.9 2.1 2.6 3.0 3.9 4.4 4.7 5.0 6.0 7.0 8.0 9.2 10.5 11.3 11.6 12.0 12.6 13.0 13.3 ]
% f = [1.3 1.5 1.85 2.1 2.6 2.7 2.4 2.15 2.05 2.1 2.25 2.3 2.25 1.95 1.4 0.9 0.7 0.6 0.5 0.4 0.25]
% Pagina 143-144 Burden
function [a, b, c, d] = cubic_spline_natural(x, f)

	N = length(x);

	a = f;
	b_indep = zeros(N, 1);
	A = zeros(N, N);
	A(1, 1) = A(N,N) = 1;

	% Calculamos los h primero
	for j = 1 : N - 1
		h(j) = x(j + 1) - x(j);
	end

	for j = 2 : N - 1

		A(j, j) = 2 * (h(j - 1) + h(j));
		A(j, j - 1) = h(j - 1); 
		A(j, j + 1) = h(j);

	b_indep(j) = 3/h(j) * (a(j + 1) - a(j)) \
			- 3/h(j - 1) * (a(j) - a(j - 1));

	end

	c = A \ b_indep;
	c = c';

	for j = 1 : N - 1

		b(j) = 1/h(j) * (a(j+1) - a(j)) \ 
			- h(j)/3 * (2 * c(j) + c(j+1));

		d(j) = (c(j + 1) - c(j)) / (3 * h(j));

	end
	
	paso = 0.01;

	color = ['r', 'g', 'b', 'c', 'm', 'y'];

	clf;
	hold on;
	for k = 1 : N - 1
		equises = [ x(k) : paso : x(k + 1) ];

		dif = (equises - x(k));

		funciones = a(k) + b(k) .* dif + c(k) .* dif.^2 + d(k) .* dif.^3; 
		
		plot(equises, funciones, color(mod(k, length(color)) + 1));
	end
	hold off;

end