#! /usr/bin/octave -qf

# El Gauss-Seidel es bastante similar al Jacobi, solo que aprovecha los 
# valores precalculados de x
function [x, it, r_h] = gaussseidel(A, b, x0, maxit, tol)

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
        
            # Formula 7.7
            x(i) = ( suma + b(i) ) / A(i, i);
                    
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
