#! /usr/bin/octave -qf

# Cree una funcion aparte que utilizan tnto sor, gaussseidel, jacobi, cg

function [ret] = criterio_error(x, x0, relativo = false, norma = inf)

    ret = norm(x - x0, norma);
    
    if (relativo)
        ret /= norm(x);
    end

endfunction
