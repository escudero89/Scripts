% Devuelve tanto la funcion como su derivada
function [h] = caida_vertical(t, derivada = false, h0 = 300, m = 0.25, g = 32.17, k = 0.1)

	a = m / k;
	e_term = e^(-k * t / m);

	if (!derivada)
		h = h0 - a * g * t + a^2 * g * (1 - e_term);
	else
		h = a * g * (e_term - 1);
	end

end
