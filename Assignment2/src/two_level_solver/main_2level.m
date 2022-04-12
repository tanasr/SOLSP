%Solution and Optimisation methods for Large-scale problems
%Assignment 2 - Two-level multi-grid solver
%Author: Radenko Tanasic, MCS class
% --------------------------------
% Implement a two-level mutli-grid solver with Jacobi and Gauss-Seidel as smoother
% --------------------------------
%% Ex. 4.1: TwoLevelMultigrid
close all; clc; clear;

N = 512;
[Lh, f] = Laplace1D(N);
u0 = zeros(N,1);
max_steps = 200;
    
[u, norm_r, u_err] = TwoLevelSolver(Lh, f, u0, max_steps, @Jacobi);
% [u, norm_r, u_err] = TwoLevelSolver(Lh, f, u0, max_steps, @GaussSeidel);











