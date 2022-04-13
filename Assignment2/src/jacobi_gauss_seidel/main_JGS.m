%Solution and Optimisation methods for Large-scale problems
%Assignment 2 - Linear iterative solvers (Jacobi and Gauss-Seidel)
%Author: Radenko Tanasic, MCS class
% --------------------------------
% Implement the Jacobi and the Gauss-Seidel methods for solving a linear system 
% of equations (element-wise, without using the vectorial operator from Matlab).
% --------------------------------
%% Ex. 3.1: Jacobi iteration
clear; clc; close all;


N = 60;
Lh = Laplace1D(N);
[f,x] = func(N);
u0 = zeros(N-1,1);
max_steps = 5000;


format long;
[u, norm_r, u_err, u_k] = Jacobi(Lh,f,u0,max_steps);
disp(norm(f-u));

direct = Lh\f;
disp(norm(f-direct));



%% Ex. 3.1: GaussSeidel iteration
clear; clc; close all;


N = 60;
Lh = Laplace1D(N);
[f,x] = func(N);
u0 = zeros(N-1,1);
max_steps = 5000;

format long;
[u, norm_r, u_err, u_k] = GaussSeidel(Lh,f,u0,max_steps);
disp(norm(f-u));

direct = Lh\f;
disp(norm(f-direct));



%% Ex. 3.3/3.4: Norm of residuals and error evolution for Jacobi and Gauss-Seidel
close all; clear; clc;
max_steps = 6000;

% Jacobi
subplot(1,2,1);
for N = [10 50 100 500]
    Lh = Laplace1D(N);
    [f,x] = func(N);
    u0 = zeros(N-1,1);
    
    [u, norm_r, u_err, u_k] = Jacobi(Lh,f,u0,max_steps);
    plot(1:max_steps,norm_r,'LineWidth',2);
    hold on;
end
% title(["$$l_2$$-norm of $$||\mathbf{f - Au}||$$ for Jacobi"],'Interpreter','latex','FontSize',20);
title(["Convergence for Jacobi"],'Interpreter','latex','FontSize',16);
legend('N=10','N=50','N=100','N=500','FontSize',12)
hold off;


% Gauss-Seidel
subplot(1,2,2);
for N = [10 50 100 500]
    Lh = Laplace1D(N);
    [f,x] = func(N);
    u0 = zeros(N-1,1);
    
    [u, norm_r, u_err, u_k] = GaussSeidel(Lh,f,u0,max_steps);
    plot(1:max_steps,norm_r,'LineWidth',2);
    hold on;
end
% title(["$$l_2$$-norm of $$||\mathbf{f - Au}||$$ for Gauss-Seidel"],'Interpreter','latex','FontSize',20);
title(["Convergence for Gauss-Seidel"],'Interpreter','latex','FontSize',16);
legend('N=10','N=50','N=100','N=500','FontSize',12)
hold off;


% adjust figure
x0=250;
y0=200;
width=1150;
height=400;
set(gcf,'position',[x0,y0,width,height])
% exportgraphics(gcf,'plots/jacobi_vs_gauss.png','Resolution',300)
