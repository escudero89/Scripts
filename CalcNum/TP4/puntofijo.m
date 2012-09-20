function [x, h] = puntofijo(g, x0, kmax, tol) 

	x = x0;

	for k = 1 : kmax

		h(k) = g(x) - x;

		if (abs(h(k)) < tol)
			disp 'g(x) - x < tolerancia';
			return;
		end

		x = g(x);

	end

	disp 'Supero maxit';
	return;

end