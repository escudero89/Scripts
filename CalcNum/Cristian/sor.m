#! /usr/bin/octave -qf

# Con w e (0, 1) => metodo sub-relajacion
# Con w e (1, 2) => metodo sobre-relajacion

function [x, it, r_h] = sor(A, b, x0, maxit, tol, w)

   n = size(A)(1);
    x = zeros(1, n)';

    for it = 1 : maxit
        
        for i = 1 : n
        
            suma = 0;

            for j = 1 : i - 1
                suma -= A(i, j) * x(j);
            end
            
            for j = i + 1 : n
                suma -= A(i, j) * x0(j);
            end
        
            # Algoritmo 7.3 y diapositiva
            x(i) = w * ( suma + b(i) ) / A(i, i) + (1 - w) * x0;
                    
        end

        # Criterio de comparacion del Burden (pag 439)
        error = norm(x - x0, inf) / norm(x);
        r_h = b - A * x;
        
        if (error < tol)
            disp "Salio por error < tolerancia";
            return;            
        end
                    
        # Actualizamos x0 con el valor de x, => x0 = x^(k-1)
        x0 = x;
    
    end
    
    disp "Salio por maxit";
    return;
    
endfunction
