function [f, x] = func(N)
    x = linspace(0, 1, N+1)';
    f = sin(2 * pi * x);

    % boundary values
    f(1) = 0; %u0
    f(end) = 0; %uN
    
    f(2) = f(2) + f(1);
    f(end-1) = f(end-1) + f(end);
    
    f = f(2:end-1);
    x = x(2:end-1);
end

    % Right-hand side
%     f = zeros(N,1);
%     f(1) = f(1)-u0;
%     for n = 1:N % x_n = i*h
%         f(n) = sin(2*pi*(n*h));
%     end
%     f(N) = f(N)-uN;