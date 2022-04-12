clear, clc, close all;

%% Ex. 1.3: Laplace FD
N = 10;
Lh = Laplace1D(N); %operator
[f, x] = func(N);

u = Lh\f;
figure(1);
plot(x,u); %sin(2*pi)


%% Ex. 1.5: Plot the Eigenvectors of Lh and its inverse
clear, close all;
figure('position',[100 100 1300 600])
fig = tiledlayout(4,2,'TileSpacing','loose','Padding','Compact');

for n = 50:50:200 
    Lh = Laplace1D(n);
%     [eigvec_first, eigval_first] = eigs(Lh,1,'smallestreal');
%     [eigvec_last, eigval_last] = eigs(Lh,1,'largestreal');
    [V,D,W] = eig(Lh);
    [V,D,Winv] = eig(inv(Lh));
    
    nexttile
    plot(W(:,1),'Linewidth',2); %smallest
    hold on;
    plot(W(:,2),'Linewidth',2); %second
    hold on;
    plot(W(:,end)); %last
    legend('First', 'Second','Last','FontSize',10);
    title("Eigenvect. of $$L_h$$ for N = " + n,'Interpreter','latex','FontSize',20);
    
    nexttile
    plot(Winv(:,1),'Linewidth',2); %smallest
    hold on;
    plot(Winv(:,2),'Linewidth',2); %second
    hold on;
    plot(Winv(:,end)); %last
    legend('First', 'Second','Last','FontSize',10);
    title("Eigenvect. of $$L_h^{-1}$$ for N = " + n,'Interpreter','latex','FontSize',20);
end
% exportgraphics(fig,'plots/Eigenvectors.png','Resolution',300) 




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
figure('position',[100 100 450 350])

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
xlabel('Real','FontSize',16);
ylabel('Imaginary','FontSize',16);
title('Gershgorin Discs','FontSize',20);
exportgraphics(gca,'plots/Gershgorin_discs.png','Resolution',300);







