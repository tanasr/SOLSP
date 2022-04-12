clear, clc, close all;

%% Ex. 1.3: Laplace FD
% clear, clc, close all;

N = 60;
[Lh, f] = Laplace1D(N);

u = Lh\f;
plot(u);
% display(Lh);




%% Some plots for the FD approximation to visualise convergence
% clear, close all;

figure();
for N = 100%[10 50 100 200 500]
    [Lh, f] = Laplace1D(N);

    %solve the system
    u = Lh\f; %second derivative via direct solver

    %plot the functions
    x = linspace(0,1);
    f_true = (1/(4*pi^2))*sin(2*pi*x); %analytical second derivative
    plot(x,f_true);
    hold on;

    xh = linspace(0,1,N); %equivalent to setting h = 1/N
    plot(xh,u,'o');
    legend('analytical','2nd order FD approx.');
end



%% Ex. 1.5: Plot the Eigenvectors of Lh
clear, close all;

figure('position',[100 100 1300 600])
fig = tiledlayout(2,4,'TileSpacing','loose','Padding','Compact');
for n = 50:50:200 
    [Lh] = Laplace1D(n);
    [eigvec_first, eigval_first] = eigs(Lh,1,'smallestreal');
    [eigvec_last, eigval_last] = eigs(Lh,1,'largestreal');
    
%     subplot(2,5,n/5)
    nexttile
    plot(eigvec_first,'Linewidth',2);
    hold on;
    plot(eigvec_last);
    legend('First', 'Last','FontSize',14);
    title("Eigenvect. of $$L_h$$ for N = " + n,'Interpreter','latex','FontSize',20);
end
% exportgraphics(fig,'Eigenvectors.pdf','Resolution',300) 



%% Ex. 1.5: Plot the Eigenvectors of Lh^-1
% clear, close all;

% figure('position',[100 100 1200 300])
% fig = tiledlayout(1,4,'TileSpacing','loose','Padding','Compact');
for n = 50:50:200 
    [Lh] = Laplace1D(n);
    Lh = inv(Lh);
    [eigvec.inv_first, eigvals.inv_first] = eigs(Lh,1,'smallestreal');
    [eigvec.inv_last, eigvals.inv_last] = eigs(Lh,1,'largestreal');

    nexttile
    plot(eigvec.inv_first);
    hold on;
    plot(eigvec.inv_last,'Linewidth',2);
    legend('First', 'Last','FontSize',14);
    title("Eigenvect. of $$L_h^{-1}$$ for N = " + n,'Interpreter','latex','FontSize',20);
end
% exportgraphics(fig,'Eigenvectors_inv.pdf','Resolution',300);




%% Ex. 1.8: Gershgorin circle theorem
clear, close all; clc;

% it even works for arbitray matrices and with complex valued eigenvalues
% comment Laplace1D out, and include the random matrix Lh instead to test
N = 10;
Lh = Laplace1D(N);
% Lh = rand(5,5);
[V,D] = eig(Lh);
rad = zeros(length(Lh),1);
centre = diag(Lh);
figure('position',[100 100 600 500])

for i = 1:length(D)
    %plot the eigenvalues
    scatter(real(D(i,i)),imag(D(i,i)),'filled');

    % calc. coordinates for disc
    rad(i) = sumabs(Lh(i,:)) - Lh(i,i);
    x0(i) = real(centre(i)) - rad(i); %bottom left corner of rectangle
    y0(i) = imag(centre(i)) - rad(i); %imaginary offset
    dx(i) = 2*rad(i);
    dy(i) = 2*rad(i);

    %plot the gershgorin disc
    hold on;
    pos = [x0(i) y0(i) dx(i) dx(i)];
    rectangle('Position',pos,'Curvature',[1 1]);
    hold on;
    plot(real(centre(i)),imag(centre(i)),'+','LineWidth',1,'Color','k'); %plot the centres
    axis equal;
end
grid on;
% xlim([]);
% ylim([(-min(centre)-) (centre(1)+2)]);
xlabel('Real','FontSize',16);
ylabel('Imaginary','FontSize',16);
title('Gershgorin Discs','FontSize',20);
% exportgraphics(fig,'Gershgorin_discs.pdf','Resolution',300);













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
[Lh, f] = Laplace1D(N);

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











