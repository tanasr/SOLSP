%Solution and Optimisation methods for Large-scale problems
%Assignment 2 - Linear iterative solvers (Jacobi and Gauss-Seidel)
%Author: Radenko Tanasic, MCS class
% --------------------------------
% Implement the Jacobi and the Gauss-Seidel methods for solving a linear system 
% of equations (element-wise, without using the vectorial operator from Matlab).
% --------------------------------
%% Ex. 3.1: Jacobi iteration
clear; clc; close all;

% Lh = [8 2 3 1; ...
%       0 6 4 0; ...
%       2 3 9 3; ...
%       1 2 3 7];
% f = [25;24;47;42]; %--> solution: x1=1, x2=2, x3=3, x4=4;
% u0 = ones(4,1);
% max_steps = 100;

N = 100;
Lh = Laplace1D(N);
[f,x] = func(N);

u0 = zeros(N,1);
max_steps = 10000;

%fastest
tic;
[u1, norm_r1, u_err1, u_k1] = Jacobi_vec(Lh,f,u0,max_steps);
toc;

tic;
[u2, norm_r2, u_err2, u_k2] = Jacobi(Lh,f,u0,max_steps);
toc;

%slowest
tic;
[u3, u_k3, norm_r3] = Jacobi_sol(Lh,f,u0,max_steps);
toc;


%% Ex. 3.1: GaussSeidel iteration
clear; clc; close all;

% Lh = [8 2 3 1; ...
%       0 6 4 0; ...
%       2 3 9 3; ...
%       1 2 3 7];
% f = [25;24;47;42]; %--> solution: x1=1, x2=2, x3=3, x4=4;
% u0 = ones(4,1);
% max_steps = 1000;

N = 100;
[Lh, f] = Laplace1D(N);

u0 = zeros(N,1);
max_steps = 1000;

tic;
[u, norm_r, u_err, u_k] = GaussSeidel_vec(Lh,f,u0,max_steps);
toc;

% tic;
% [u, norm_r, u_err, u_k] = GaussSeidel(Lh,f,u0,max_steps);
% toc;

%% Ex. 3.3: Norm of residuals and error evolution for Jacobi
%note, the function is the same, the Jacobi_plot only hase one more
%input parameter for which type of plot to generate

close all; clear; clc;
for n = [10 50 100 500]
    [Lh, f] = Laplace1D(n);
    u0 = zeros(n,1);
    max_steps = 5000;
    
    [u, norm_r, u_err, u_k] = Jacobi_plot(Lh,f,u0,max_steps,2);
end

%% Ex. 3.3: Norm of residuals and error evolution for Gauss Seidel
%note, the function is the same, the GaussSeidel_plot only hase one more
%input parameter for which type of plot to generate

close all; clc; clear;
for n = [10 50 100 500]
    [Lh, f] = Laplace1D(n);
    u0 = zeros(n,1);
    max_steps = 5000;
    
    [u, norm_r, u_err, u_k] = GaussSeidel_plot(Lh,f,u0,max_steps,2);
end













%% Ex. 4.1: TwoLevelMultigrid
close all; clc; clear;

N = 512;
[Lh, f] = Laplace1D(N);
u0 = zeros(N,1);
max_steps = 200;
    
[u, norm_r, u_err] = TwoLevelSolver(Lh, f, u0, max_steps, @Jacobi);
% [u, norm_r, u_err] = TwoLevelSolver(Lh, f, u0, max_steps, @GaussSeidel);











