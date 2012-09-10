#! /usr/bin/octave -qf

# Hace la factorizacion de Crout sin o con pivoteo
# Bastante parecido al gaussian
# La matriz la devuelve en otro orden, ya que PA = LU, P matriz de permutacion
function [l, u] = crout(A, parcial = false)
    
    n = size(A)(1);
    
    U = A;
    L = zeros(n, n);
    
    idx = [1 : n];
    
    for i = 1 : n - 1
    	    
	    # Si tenemos pivoteo parcial, cambiamos el vector de permutacion
	    if (parcial)
	    
	        # Ponemos la fila con maximo valor
	        [tr, p] = max(abs(U(idx(i:n), i)));
	        p = p + i - 1;
	        
	        if (idx(i) != idx(p))	        
	            tr = idx(p);
	            idx(p) = idx(i);
	            idx(i) = tr;
	        end
	        
	    end

	    # Hace las operaciones elementales basicas de (E_i + K * E_j) => E_i
	    for k = i + 1 : n
	        m = U(idx(k), i) / U(idx(i), i);			

			# Le asignamos el m a la matriz L
			L(idx(k), i) = m;
			
			# Y hacemos cero el elemento como el gaussian
			U(idx(k), i) = 0;
				        
	        # Le aplicamos el valor de m a toda la fila
	        for j = i + 1 : n
	            U(idx(k), j) -= m * U(idx(i), j);
	        end	        

        end
    
    end

    for i = 1 : n
        l(i, :) = L(idx(i), :);
        u(i, :) = U(idx(i), :);   
    end
    
    l += diag(ones(1,n));

endfunction
