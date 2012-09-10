#! /usr/bin/octave -qf

1;

function [A, b] = sistema(orden, alma, cuerpo)

    A = diag(ones(1, orden) * alma);

    A += diag(ones(1, orden - 1) * cuerpo, 1);
    A += diag(ones(1, orden - 1) * cuerpo, -1);

    b = [1 : orden]';
    
endfunction

[A, b] = sistema(4, 2, -1);
