function [x, it, r_h] = grad_conjugado(A, b, x0, maxit, tol)

    for k = 1 : maxit
        
        alpha_old = dot(p_old, r_old) / dot(p_old, A * p_old);
        
        x = x_old + alpha_old * p_old;
       
        r = b - A * x;
        
        gamma_old = -dot(A * p_old, r) / dot(A * p_old, p_old);
        
        p = r + gamma_old * p_old;
        
        
        if ( error < tol )
            disp "El error es menor que la tolerancia.";
            it = k;
            %r_h = b - A * x;
            return;
        endif 
    
    endfor
    
    it = maxit;
    %r_h = b - A * x;
    
    disp "Salio por superar maxima cantidad de iteraciones.";
    return;
    
    
endfunction
