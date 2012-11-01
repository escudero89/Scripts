function [x, h] = puntofijo(g, x0, kmax, tol) 

	for k = 1 : kmax

		x = g(x0);
		h(k) = x + x0;

		if (abs(h(k)) < tol)
			disp 'g(x) < tolerancia';
			return;
		end

		x0 = x;

	end

	disp 'Supero maxit';
	return;

end
