%Solution and Optimisation methods for Large-scale problems
%Assignment 1 - Newton Method for the Himmelblau and Rosenbrock functions
%Author: Radenko Tanasic, MCS class
% --------------------------------
% Implement the Newton method 
% --------------------------------
clear; close all; clc;

%% Function F

x = linspace(-3,3); 
y = linspace(-4,4);
[X,Y] = meshgrid(x,y);
Z = funcf(X,Y);

newton_steps_g1 = newton_method(0.5,2.5,0.01,1e3,@funcf,@dfdx,@dfdy,@hessian_f); % flag 'f' or 'g'
newton_steps_g2 = newton_method(-1,-1,0.01,1e3,@funcf,@dfdx,@dfdy,@hessian_f);

% contour plot
subplot(1,3,1);
contour(X,Y,Z,50);
hold on;
plot(newton_steps_g1(:,1),newton_steps_g1(:,2),'ro-');
plot(newton_steps_g1(1,1),newton_steps_g1(1,2),'ko','linewidth',1.5); %starting point
plot(newton_steps_g2(:,1),newton_steps_g2(:,2),'bo-');
plot(newton_steps_g2(1,1),newton_steps_g2(1,2),'ko','linewidth',1.5); %starting point
colorbar;
title('Function F');


%% Function G

x = linspace(-3,3); 
y = linspace(-4,4);

newton_steps_g1 = newton_method(2,-1,0.01,1e4,@funcg,@dgdx,@dgdy,@hessian_g); % flag 'f' or 'g'
newton_steps_g2 = newton_method(-2,-2,0.01,1e4,@funcg,@dgdx,@dgdy,@hessian_g);

% contour plot
subplot(1,3,2);
[X,Y] = meshgrid(x,y);
Z = funcf(X,Y);

contour(X,Y,Z,50);
hold on;
plot(newton_steps_g1(:,1),newton_steps_g1(:,2),'ro-');
plot(newton_steps_g1(1,1),newton_steps_g1(1,2),'ko','linewidth',1.5); %starting point
plot(newton_steps_g2(:,1),newton_steps_g2(:,2),'bo-');
plot(newton_steps_g2(1,1),newton_steps_g2(1,2),'ko','linewidth',1.5); %starting point
colorbar;
title('Function G');
 


%% Symbolic differentiation
% !!!! something is wrong here ... !!!
syms x y;
func = @(x, y) (x+y).*sin(x-y^2).^2;
steps_sym = newton_symbolic(func,2,3,0.1,1e4);

x = linspace(-3.5, 3.5);
y = linspace(-4.5, 4.5);
[X, Y] = meshgrid(x,y);
Z = func(X, Y);

subplot(1,3,3);
contour(X,Y,Z,50);
hold on;
plot(steps_sym(:,1), steps_sym(:,2), "-o");
hold on;
plot(steps_sym(1,1),steps_sym(1,2),'ko','linewidth',1.5); %starting point
colorbar();


% adjust figure
x0=250;
y0=200;
width=1250;
height=450;
set(gcf,'position',[x0,y0,width,height])
exportgraphics(gcf,'plots/newton.png','Resolution',300)



