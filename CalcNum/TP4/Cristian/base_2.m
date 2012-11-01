#! /usr/bin/octave -qf
1;

function show_something(x, h, titlelabel = '', it = 1, fase = 1)

	x
	iteraciones = length(h)
	toc;
	
	disp('-------------------------------------------------------------------');
	show_something_helper(x, h, titlelabel, it);
	
end


function show_something_helper(x, h, titlelabel, it)
	color = ['r', 'g', 'b', 'm', 'c'];

	plot([1 : length(h)], log(h), color(it));

	grid on;
	xlabel('iteraciones');
	ylabel('log(h)');
end


x0 = 0.1;
kmax = 100;
tol = 10e-7;

[x, h] = newton(@caida_vertical, @caida_vertical, x0, kmax, tol)

clf;
hold on;

tic;
show_something(x, h, "Newton", 1, num2str(1));

[x, h] = secante(@caida_vertical, x0, 100, kmax, tol)
tic;
show_something(x, h, "Secante", 2, num2str(2));

hold off;
