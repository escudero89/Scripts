function [x, h] = puntofijo(g, x0, kmax, tol) 

	for k = 1 : kmax

		x = g(x0);
		h(k) = x;

		if (abs(x - x0) < tol)
			disp 'g(x) - x < tolerancia';
			return;
		end

		x0 = x;

	end

	disp 'Supero maxit';
	return;

end
