% Se le pasa el argumento de la funcion con un @ adelante
function [x,h] = biseccion(f, xmin, xmax, kmax, tol) 

	h = [];

	for k = 1 : kmax

		if f(xmin)*f(xmax) > 0
			disp 'No hay ceros en el intervalo.';
			return;
		end

		P = xmin + (xmax - xmin) / 2;
		h(k) = f(P);

		if (abs(h(k)) < tol)
			x = P;
			disp 'Error < tolerancia.';
			return;
		end

		if (h(k) < 0)
			xmin = P;
		else 
			xmax = P;
		end
	end

	disp 'Superado maxit';
	return;
end
