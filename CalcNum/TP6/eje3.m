1;

% Error en tres puntos tiene esa forma porque:
%	Cuando usamos la formula de dos puntos, miramos el punto donde estamos
% parados y luego un punto adelante. En tres puntos, el error va a depender 
% de gran medida de lo que va a haber atras. 
function [f_prima] = tres_puntos_centrada(f, x0, h)
	f_prima = 1/(2*h) * (f(x0 + h) - f(x0 - h));
	return;
end

function [f_prima] = dos_puntos(f, x0, h)
	f_prima = (f(x0 + h) - f(x0))/h;
	return;
end


function [f] = fsin(x)
	f = sin(1/x);
	return;
end

function [f] = fsin_prima(x)
	f = -1/x^2 * cos(1/x);
	return;
end

function [f] = fsin_segunda(x)
	f = (2*cos(1./x))./x.^3-sin(1./x)/x.^4;
	return;
end

% COMIENZO DEL SCRIPT
x0 = 0.2;
k = 1;

% Queremos ver que a medida que achicamos h, el error va disminuyendo
paso = 0.0001;
h_range = paso : paso : 0.1;
fsin_prima = fsin_prima(x0);

% Como esta cota da positiva, el error esta acotado correctamente de forma teorica
error_segunda = max(fsin_segunda(x0 : paso : h))/2 * 0.1 \ 
		- abs(fsin_prima - dos_puntos(@fsin, x0, 0.1)) 

pause;

for h = h_range
	error(k, 1) = abs(dos_puntos(@fsin, x0, h) - fsin_prima);
	error(k, 2) = abs(tres_puntos_centrada(@fsin, x0, h) - fsin_prima);
	k++;
end 

clf;
hold on;
plot(h_range, error(:, 1)/abs(fsin_prima), 'b');
plot(h_range, error(:, 2)/abs(fsin_prima), 'r');
xlabel('h');
hold off;