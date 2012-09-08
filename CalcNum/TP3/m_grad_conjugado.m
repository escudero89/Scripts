function [x, it, r_h] = m_grad_conjugado(A, b, x_old, maxit, tol)
	x = x_old;
	r_old = b - A*x;
	v = r_old;
	for it=1:maxit
		t = dot(r_old, r_old)/dot(v,A*v);
		x = x_old + t * v;
		r = r_old - t * A*v;
		s = dot(r,r)/dot(r_old , r_old);
		v_new = r + s*v;

		error = norm(x - x_old, 2); % no estoy seguro si es una buena forma de medir el error
		r_h = b - A*x;
		
		r_old = r;
		v = v_new;
		x_old = x;
		
		if(error<tol)
			disp('Salio porque error menor a tolerancia')
			return;
		endif
			
	endfor
	disp('Salio por maximo de iteraciones')
	return
endfunction
