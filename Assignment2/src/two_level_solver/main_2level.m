%Solution and Optimisation methods for Large-scale problems
%Assignment 2 - Two-level multi-grid solver
%Author: Radenko Tanasic, MCS class
% --------------------------------
% Implement a two-level mutli-grid solver with Jacobi and Gauss-Seidel as smoother
% --------------------------------
close all; clc; clear;
%% Ex. 4.1: TwoLevelMultigrid
N = 64;
Lh = Laplace1D(N);
[f,x] = func(N);
% u0 = zeros(N-1,1);
u0 = (rand(size(f)) - 0.5) * 0.01; %generate random init. cond.
max_steps = 200;
    
[u, u_k, norm_r] = TwoLevelSolver(Lh, f, u0, max_steps, @Jacobi);
% TODO: fix bug with Gauss-Seidel
% [u, u_k, norm_r] = TwoLevelSolver(Lh, f, u0, max_steps, @GaussSeidel);


%% Plot
subplot(2, 1, 1);
semilogy(norm_r, "-o");
ylabel("Norm of the residual");
xlabel("Steps");
title("Jacobi as a Smoother");
ue = Lh\f;


subplot(2, 1, 2);
for i = 1:size(u_k, 1)
    plot(x, u_k(i, :), ".");
    hold on;
end

plot(x, u, 'LineWidth', 2);
plot(x, ue,'LineWidth', 2);

exportgraphics(gcf,'plots/two_level_mutligrid.png','Resolution',300)








