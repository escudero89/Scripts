function [x, it, r_h] = sor(A, b, x0, maxit, tol, w)

    N = length(x0);
    x = x0;
    
    for k = 1 : maxit
        
        x0 = x;
           
        for i = 1 : N
            
            suma = 0;
            
            for j = 1 : i - 1
                suma += -A(i, j) * x(j);
            endfor
            
            for j = i + 1 : N
                suma += -A(i, j) * x0(j);
            endfor

            x(i) = x0(i) * (1 - w) + w * (suma + b(i)) / A(i, i);

        endfor
        
        error = norm(x - x0, 2);
        
        % Usamos error absoluto porque nos marca mejor la diferencia entre dos valores
        
        if ( error < tol )
            disp "El error es menor que la tolerancia.";
            it = k;
            r_h = b - A * x;
            return;
        endif 
    
    endfor
    
    it = maxit;
    r_h = b - A * x;
    
    disp "Salio por superar maxima cantidad de iteraciones.";
    return;
    
endfunction
