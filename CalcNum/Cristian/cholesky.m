#! /usr/bin/octave -qf

# Sin pivoteo
function [A] = cholesky(A)

    n = size(A)(1);
    
    # Limpiamos la parte triangular superior porque la matriz es simetrica
   
    for i = 1 : n
        for j = i + 1 : n
            A(i,j) = 0;
        end
    end

    A(1,1) = sqrt(A(1,1));
    
    # Llenamos la primera columna
    for i = 2 : n
        A(i, 1) = A(i, 1) / A(1, 1);
    end

    # Calculamos el resto
    
    for i = 2 : n - 1

        suma = 0;
        
        for s = 1 : i - 1
            suma += A(i, s)^2;
        end
    
        A(i, i) = sqrt(A(i, i) - suma);
        
        for j = i + 1 : n
            
            suma = 0;
            
            for s = 1 : i - 1
                suma += A(j, s) * A(i, s);                
            end
        
            A(j, i) = (A(j, i) - suma) / A(i, i);
        
        end 
    
    end
    
    suma = 0;
        
    for s = 1 : n - 1
        suma += A(n, s)^2;
    end
    
    A(n, n) = sqrt(A(n, n) - suma);
    
endfunction
