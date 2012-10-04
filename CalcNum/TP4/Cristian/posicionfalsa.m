% Bastante similar a secante, solo que comprobamos una cosa antes
function [x, h] = posicionfalsa(f, xmin, xmax, kmax, tol)

	p0 = xmin;
	p1 = xmax;

	for k = 1 : kmax

		p = p1 - (p1 - p0)/(f(p1) - f(p0)) * f(p1);
		h(k) = f(p);

		if (abs(h(k)) < tol)
			x = p;
			disp 'Error < tolerancia.';
			return;
		end

		if (f(p) * f(p1) < 0)
			p0 = p;
		else
			p1 = p;
		end	

	end

	disp 'Superado maxit';
	return;

end
