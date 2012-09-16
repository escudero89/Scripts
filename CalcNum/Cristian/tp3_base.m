#! /usr/bin/octave -qf

1;

function [A, b] = sistema(orden, alma, cuerpo)

    A = diag(ones(1, orden) * alma);

    A += diag(ones(1, orden - 1) * cuerpo, 1);
    A += diag(ones(1, orden - 1) * cuerpo, -1);

    b0 = [0.5 2];
    b = [];
    
    for i = 1 : orden/2
        b = [b ; b0(1)/i ; b0(2)/i];
    end
        
endfunction

function call_method(method)

    separador = "--------------------------------------------------------------------------------";

    disp(separador);
    
    disp(method);
    
    tic;

endfunction

function show_things(iteraciones, r_h, plot_properties, figura)

    figure(figura);
    
    hold on;
    iteraciones
    norma_del_residuo = norm(r_h, inf)
    plot(iteraciones, norma_del_residuo, ['o' plot_properties]);
    
    hold off;
    
endfunction

# SCRIPT #

ordenes = [4 8 16];
maxit = 300;
tol = 10e-3;
w = 1.25;

# Para un ploteo bueno
titulos = "Norma de Residuo en funcion de las iteraciones: Orden ";
x_label = "iteraciones";
y_label = "norma de residuo";

# Limpiamo todos los plots
for plots = 1 : 3
    figure(plots)
    
    clf;
    title([titulos num2str(ordenes(plots))]);    
    xlabel(x_label);
    ylabel(y_label);    
    
    xlim([3.5, 6.5]);
    grid;
    ylim([0, 0.02]);
end

for prueba = 1 : 3


    [A, b] = sistema(ordenes(prueba), 4, -1);
    x0 = zeros(length(b), 1);

    ############################################################################
    
    call_method("JACOBI:");
    [x, iteraciones, r_h] = jacobi(A, b, x0, maxit, tol);
    toc;

    show_things(iteraciones, r_h, 'r', prueba);
    
    ############################################################################
    
    call_method("GAUSS-SEIDEL:");
    [x, iteraciones, r_h] = gaussseidel(A, b, x0, maxit, tol);
    toc;
    
    show_things(iteraciones, r_h, 'g', prueba);

    ############################################################################
    
    call_method("SOR con w=1.25:");
    [x, iteraciones, r_h] = sor(A, b, x0, maxit, tol, w); 
    toc;
    
    show_things(iteraciones, r_h, 'b', prueba);
    
    ############################################################################
    
    # Elegimos un w en base al Teorema 7.26 del Burden (p449)
    
    D = diag(diag(A), 0);
    L_mas_U = A - D;
    
    # T_j es el T de Jacobi
    T_j = inv(D) * (L_mas_U);
    
    w = 2 / (1 + sqrt(1 - max(abs(eig(T_j)))^2));
    
    call_method("SOR:");
    [x, iteraciones, r_h] = sor(A, b, x0, maxit, tol, w); 
    toc;
    
    w
    show_things(iteraciones, r_h, 'c', prueba);
    
    ############################################################################
    
    call_method("GRADIENTE CONJUGADO:");
    [x, iteraciones, r_h] = cg(A, b, x0, maxit, tol);
    toc;
    
    show_things(iteraciones, r_h, 'm', prueba);

    ############################################################################
    
    hold off;
end

# Guardamos las imagenes
for plots = 1 : 3

    figure (plots)

    print(["plot_" num2str(plots) ".png"]);
end

