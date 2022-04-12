function [Lh] = Laplace1D(N)
    
%     u0 = 0;
%     uN = 0;
    h = 1/(N);
    
    % Laplace operator
    Lh = zeros(N-1);
    stencil = [1 -2 1];
    Lh(1,1:2) = stencil(2:3);
    for i = 2:N-2
        Lh(i, [i-1 i i+1]) = [1 -2 1];
    end
    Lh(end,end-1:end) = stencil(1:2);
    Lh = Lh*(-1/h^2);
    
    % Right-hand side
%     f = zeros(N,1);
%     f(1) = f(1)-u0;
%     for n = 1:N % x_n = i*h
%         f(n) = sin(2*pi*(n*h));
%     end
%     f(N) = f(N)-uN;
end