#! /usr/bin/octave -qf

1;

# Sistema basico de sustitucion
A_0 = [1 -1 2 -1 ; 0 2 -1 1 ; 0 0 -1 -1 ; 0 0 0 2];
b_0 = [-8 6 -4 4]';

# Sistema con solucion unica x = [-7 3 2 2]'
A_1 = [1 -1 2 -1 ; 2 -2 3 -3 ; 1 1 1 0 ; 1 -1 4 3 ];
b_1 = [-8 -20 -2 4]';

# Sistema sin solucion
A_2 = [ 1 1 1 ; 2 2 1 ; 1 1 2 ];
b_2 = [ 4 6 6 ]';

# Mi prueba
A_3 = [ 1 3 ; 2 4 ];
b_3 = [ 1 1 ]';

# De los tps

A_4a = [ 8 4 1 ; 2 6 2 ; 2 4 8 ];
A_4b = [ 5e-2 5.57e2 -4e-2; 1.98 1.94e2 -3e-3 ; 2.74e2 3.11 7.5e-2 ];
A_4c = [ 1 2 -1 ; 2 4 0 ; 0 1 -1 ];

b_4 = [1 2 3]';

# Para los metodos iterativos
A_5 = [ 10 -1 2 0 ; -1 11 -1 3 ; 2 -1 10 -1 ; 0 3 -1 8 ];
b_5 = [6 25 -11 15]';

# TP3 Ejercicio 4
A_6 = [ 4 3 0 ; 3 4 -1 ; 0 -1 4 ];
b_6 = [ 24 30 -24 ]';

# De la diapositiva
A_7 = [ 0.2 0.1 1 1 0 ; 0.1 4 -1 1 -1 ; 1 -1 60 0 -2 ; 1 1 0 8 4 ; 0 -1 -2 4 700];
b_7 = [ 1 2 3 4 5 ]';

A = A_7;
b = b_7;

x0 = zeros(1, size(A)(1))';
maxit = 100;
tol = 10e-3;
w = 1.25;

#############
# OPERACIONES

gaussian = false;

if (gaussian)

    disp "Eliminación Gaussiana:";
    [x, indx] = gaussian_backward(A, b)

    disp "Eliminación Gaussiana con pivoteo parcial:";
    [x, indx] = gaussian_backward(A, b, true)

    disp "Octave resolution:";
    A\b
    
end

disp "Jacobi:"
[x, it, r_h] = jacobi(A, b, x0, maxit, tol)

disp "Gauss-Seidel:"
[x, it, r_h] = gaussseidel(A, b, x0, maxit, tol)

disp "Sor:"
[x, it, r_h] = gaussseidel(A, b, x0, maxit, tol, w)
