1;

maxit = 100;
tol = 10^-3;

A = [ 4 3 0 ; 3 4 -1 ; 0 -1 4];
b = [ 24 30 -24 ]';
x0 = [ 0 0 0 ]';

w = 1.25;

A = [ 4 3 1 ; 3 4 -1 ; 1 -1 4 ];
b = [ 24 30 -24 ]';

A = [ 0.2 0.1 1 1 0 ; 0.1 4 -1 1 -1 ; 1 -1 60 0 -2 ; 1 1 0 8 4 ; 0 -1 -2 4 700];
b = [ 1 2 3 4 5 ]';
x0 = [ 0 0 0 0 0 ]';
tol = 0.01;

[x, it, r_h] = jacobi(A, b, x0, maxit, tol)

[x, it, r_h] = gauss_seidel(A, b, x0, maxit, tol)

[x, it, r_h] = sor(A, b, x0, maxit, tol, w)
