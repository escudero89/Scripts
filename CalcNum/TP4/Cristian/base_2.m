#! /usr/bin/octave -qf
1;

x0 = 0.1;
kmax = 100;
tol = 10e-3;

[x, h] = newton(@caida_vertical, @caida_vertical, x0, kmax, tol)

[x, h] = secante(@caida_vertical, x0, 100, kmax, tol)
