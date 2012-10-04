% La idea de diferencias divididas es encontrar los a_k

% Primer ejemplo:
% P(x) = a_0 + a_1 (x - x_0)
% P(x_0) = a_0 = f(x_0)

% P(x_1) = f(x_0) + a_1 (x_1 - x_0) = f(x_1)
% a_1 = (f(x_1) - f(x_0)) / (x_1 - x_0)

% P(x) = f(x_0) + (f(x_1) - f(x_2))/(x_1 - x_0) (x - x_0)
%        <||||>   <|||||||||||||||>
%        f[x_0]      f[x_0, x_1]

% TEOREMA:
%                          f[x_0, x_1, ..., x_n] - f[x_0, x_1, ..., x_{n-1}]
% f[x_0, x_1, ..., x_n] =  ------------------------------------------------
%                                            x_n - x_0

% P_n (x) = f[x_0] + f[x_0, x_1] (x - x_0) + f[x_0, x_1, x_2] (x - x_0) (x_x_1) + ... 

#{ TABLA
x 		f(x) 	f[x_i] 			f[x_i, x_i+1] 		f[x_i, x_i+1, x_i+2]	f[x_i, x_i+1, x_i+2, x_i+3]
0 		3 		f[x_0]= 3 		f[x0,x1]= 0 		f[x0,x1,x2]= 1/3  		f[x0,x1,x2,x3]= -2
1 		3 		f[x_1]= 3 		f[x1,x2]= 1/2 		f[x1,x2,x3]= -11/3
3/2 	13/4 	f[x_2]= 13/4 	f[x2,x3]= -19/6
2   	5/3 	f[x_3]= 5/3
#}

% P(x) = 3 + 0 d0 + 1/3 d0 d1 - 2 d0 d1 d2

function [d] = dif_div(f, x)

	N = length(f);
	A = zeros(f, f);

	A(:, 1) = f(1);

	for j = 2 : N

		for i = 1 : N - j + 1
			
			A(i, j) = (A(i, j - 1) - A(i + 1, j - 1)) / (x(i) - x(j + i - 1));

		end

	end

end