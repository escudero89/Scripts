#{

Metodo de Horner
P(x) = a_n x^n + a_{n-1} x^{n-1} + ... + a_1 x + a_0
b_n =  a_n
b_k = a_k + b_{k+1} x_0
b_0 = P(x_0) <= polinomio en x0
=> P(x) = (x-x0) * Q(x) + b_0
con Q(x) = b_n x^{n-1} + b_{n-1} x^{n-2} + ... + b_2 x + b_1

ejemplo:
a_3 x^3 + a_2 x^2 + a_1 x + a0
x(x(a_3 x + a_2) + a_1) + a_0 <= Horner es una formula para calcular esto 
   (b_3)
   (    b_2    )
  (        b_1        )
(            b_0             )

Nuestra tarea:
P(x) = 2x^4 - 3x^2 + 3x - 4
 Newton: x_1 = x0 - P(x0) / P'(x0)
Para evaluar P y P' usamos el metodo de Horner.

P(x0)     
        |	x^4		x^3 	x^2 	x 	   c
        |    2      0    	-3 		3 	  -4
x0 = -2 |        b_4*x0  b_3*x0  b_2*x0 b_1*x0
        |		   =-4   	=8     =10    =14
        ----------------------------------------
           b_4=2   b_3=-4  b_2=5   b_1=-7  [b_0=10] => P(x0) = b0    

P'(x) = Q(x) + (x-x0) * Q'(x)
P'(x0) = Q(x0) <= vamos a llegar a esto
Q(x) = 2x^3 -4x^2 + 5x - 7

        |   x^3 	x^2 	x 	   c
        |    2       -4     5     -7
x0 = -2 |             
        |            -4     16    -42
        ------------------------------
           b_3=2  b_2=-8  b_1=21  b_0=-49

x_1 = -2 + 10 / 49 

#}

% Los coeficientes van en orden descendente x^2 x 1
function [y,z] = horner(coef, x0)

	N = length(coef);
	b = zeros(1, N);
	q = zeros(1, N - 1);

	% Lo damos vuelta
	coef = coef(N:-1:1);

	b(N) = coef(N);

	for k = N - 1 : -1 : 1
		b(k) = coef(k) + b(k + 1) * x0;
		
		% Debo incrementar en uno el indice porque linkea mal
		if k < N - 1
			q(k) = b(k + 1) + q(k + 1) * x0; 
		else
			q(N - 1) = b(N);
		end
	end

	% Mi b0 es mi P(x0), y el resto es mi polinomio Q(x)
	y = b(1);
	z = q(1);

end