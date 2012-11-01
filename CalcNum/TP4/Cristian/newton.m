% Lo mejor seria que f y f_prima esten en una misma funcion, y la segunda tome 
% como segundo parametro el valor de verdadero
function [x, h] = newton(f, f_prima, x0, kmax, tol) 

	for k = 1 : kmax

		x = x0 - f(x0) / f_prima(x0, true);

		h(k) = f(x);

		if (abs(h(k)) < tol)
			disp 'f(x) < tolerancia.';
			return;
		end

		x0 = x;

	end

	disp 'Salio por maxit.';
	return;

end
