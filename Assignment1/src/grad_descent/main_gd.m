%Solution and Optimisation methods for Large-scale problems
%Assignment 1 - Gradient descent for the Himmelblau and Rosenbrock functions
%Author: Radenko Tanasic, MCS class
% --------------------------------
% Implement the gradient descent algorithm with analytic gradients
% and compare with matlabs syms gradients
% --------------------------------
clear; close all; clc;

%% Function F

x = linspace(-3,3); 
y = linspace(-4,4);

grad_steps_g1 = gradient_descent(1,1,0.01,1e4,'f'); % flag 'f' or 'g'
grad_steps_g2 = gradient_descent(-1,-1,0.01,1e4,'f');

% contour plot
subplot(1,3,1);

[X,Y] = meshgrid(x,y);
z = funcf(X,Y);
contour(X,Y,z,50);
hold on;
plot(grad_steps_g1(:,1),grad_steps_g1(:,2),'ro-');
plot(grad_steps_g1(1,1),grad_steps_g1(1,2),'ko','linewidth',1.5); %starting point
plot(grad_steps_g2(:,1),grad_steps_g2(:,2),'bo-');
plot(grad_steps_g2(1,1),grad_steps_g2(1,2),'ko','linewidth',1.5); %starting point
colorbar;
title('Function F');

% plot meshgrid
% subplot(1,2,2);
% mesh(X,Y,z)
% Plot the steps onto contour plot
% hold on;
% plot(grad_steps_f1(:,1),grad_steps_f1(:,2),'ro-');
% plot(grad_steps_f2(:,1),grad_steps_f2(:,2),'bo-');
% Plot the steps onto the function plot
% hold on;
% points1 = funcf(grad_steps_f1(:,1),grad_steps_f1(:,2));
% plot3(grad_steps_f1(:,1),grad_steps_f1(:,2),points1,'kx-');
% points2 = funcf(grad_steps_f2(:,1),grad_steps_f2(:,2));
% plot3(grad_steps_f2(:,1),grad_steps_f2(:,2),points2,'kx-');


%% Function G

x = linspace(-3,3); 
y = linspace(-3,3);

grad_steps_g1 = gradient_descent(2,-1,0.0001,1e5,'g'); % flag 'f' or 'g'
grad_steps_g2 = gradient_descent(-2,-2,0.0001,1e5,'g');

% contour plot
subplot(1,3,2);
[X,Y] = meshgrid(x,y);
z = funcf(X,Y);

contour(X,Y,z,50);
hold on;
plot(grad_steps_g1(:,1),grad_steps_g1(:,2),'ro-');
plot(grad_steps_g1(1,1),grad_steps_g1(1,2),'ko','linewidth',1.5); %starting point
plot(grad_steps_g2(:,1),grad_steps_g2(:,2),'bo-');
plot(grad_steps_g2(1,1),grad_steps_g2(1,2),'ko','linewidth',1.5); %starting point
colorbar;
title('Function G');
 


%% Symbolic differentiation
syms x y;
func = @(x, y) sin(x.^2+y).*cos(x-y.^2);
steps_sym = gradient_descent_symbolic(func,0.8,1,0.01);

x = linspace(-3, 3);
y = linspace(-4, 4);
[X, Y] = meshgrid(x,y);

Z = func(X, Y);
subplot(1,3,3);
contour(X,Y,Z,20);
hold on;
plot(steps_sym(:,1), steps_sym(:,2), "-o");hold on;
plot(steps_sym(1,1),steps_sym(1,2),'ko','linewidth',1.5); %starting point
colorbar();
title('Function H');


% adjust figure
x0=250;
y0=200;
width=1250;
height=450;
set(gcf,'position',[x0,y0,width,height])
exportgraphics(gcf,'plots/grad_descent.png','Resolution',300)


