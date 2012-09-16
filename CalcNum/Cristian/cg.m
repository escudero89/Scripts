#! /usr/bin/octave -qf

# Funcion que aplica el metodo de gradiente conjugado basado en las formulas del Burden
function [x, it, r_h] = cg(A, b, x0, maxit, tol, mensaje = false)
    
    # Valores iniciales
    
    r0 = b - A * x0;
    
    # Direccion de busqueda
    v = r0;
    
    for k = 1 : maxit
    
        # Paso de avance en la direccion de busqueda
        # t = <r^(k-1), r^(k-1)> / <v^(k), A v^(k)>
        t = r0' * r0 / ( v' * A * v);
        
        # Solucion aproximada x a A·x* = b 
        x = x0 + t * v;
        
        # Vector residual
        r = r0 - t * A * v;
        
        # Elegimos un s de modo que <v^(k-1), A v^(k)> = 0
        # <r^(k), r^(k)> / <r^(k-1), r^(k-1)>
        rho = r' * r;
        rho_old = r0' * r0;
        
        s = rho / (rho_old);
        
        # Creamos una nueva direccion de busqueda
        v = r + s * v;
    
        # Prueba de convergencia igual al resto de los metodos
        error = criterio_error(x, x0);
        
        if (error < tol)
            if (mensaje)
                disp "Salio por error < tolerancia.";
            end
            
            it = k;
            r_h = b - A * x;
            return;
        end
    
        # Actualizamos variables x0 y r0
        x0 = x;
        r0 = r;
    
    end
    
    it = k;    
    
    r_h = b - A * x;
    
    if (mensaje)
        disp "Salio por maxit.";
    end
    
    return;

endfunction
