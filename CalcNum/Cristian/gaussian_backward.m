#! /usr/bin/octave -qf

# Hace la eliminacion gaussiana
# Devuelve ademas el vector de permutacion, y tanto L como U
function [x, idx] = gaussian_backward(A, b, parcial = false) 	
	
	n = size(A)(1);
	
	# Matriz extendida para abacar b
    Ab = [A b];
    
    # Debo llevar un indice para las permutaciones
    idx = [1 : n];
    
	
	# Se resuelve en n - 1 pasos
	for i = 1 : n - 1
	
	    # Si topamos con una columna de ceros del pivote para abajo
	    if ( max(abs(Ab(idx(i:n), i))) < eps )
	        disp "No existe solución única";
	        x = [];
	        return;
	    end
	    
	    # Si tenemos pivoteo parcial, cambiamos el vector de permutacion
	    if (parcial)
	    
	        # Ponemos la fila con maximo valor
	        [tr, p] = max(abs(Ab(idx(i:n), i)));
	        p = p + i - 1;
	        
	        if (idx(i) != idx(p))	        
	            tr = idx(p);
	            idx(p) = idx(i);
	            idx(i) = tr;
	        end
	        
	    end
	    
	    # Hace las operaciones elementales basicas de (E_i + K * E_j) => E_i
	    for k = i + 1 : n
	        m = Ab(idx(k), i) / Ab(idx(i), i);			
			
			# Al primer elemento de E_i lo hacemos cero
			Ab(idx(k), i) = 0;
				        
	        # Le aplicamos el valor de m a toda la fila
	        for j = i + 1 : n + 1
	            Ab(idx(k), j) -= m * Ab(idx(i), j);
	        end	        

        end
        
	end

    x = backwards(Ab(:, 1:n), Ab(:, n+1), idx); 

endfunction

# Inicializo

function [Ab, n, x] = inicializo(A, b)

    Ab = [A b];
    n = length(b);

    x = zeros(1, n)';

endfunction

# Le pasas una matriz triangular superior y te la resuelve sustitucion atras
function [x] = backwards(A, b, indx)

    [Ab, n, x] = inicializo(A, b);
    
    for j = n : -1 : 1
    
        sumatoria = 0;
        
        for i = j + 1 : n
            sumatoria += Ab(indx(j), i) * x(indx(i));
        end
        
        x(indx(j)) = (Ab(indx(j), n+1) - sumatoria) / Ab(indx(j), j);
    
    end

endfunction

# Lo mismo, pero con sustitucion hacia delante
function [x] = forwards(A, b, indx)

    [Ab, n, x] = inicializo(A, b);
    
    for j = 1 : n
    
        sumatoria = 0;
        
        for i = 1 : j - 1
            sumatoria += Ab(indx(j), i) * x(indx(i));
        end
        
        x(indx(j)) = (Ab(indx(j), n+1) - sumatoria) / Ab(indx(j), j);
    
    end

endfunction
