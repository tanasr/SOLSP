function [steps] = gradient_descent_symbolic(fun, x0, y0, alpha)
    
    syms x y;
    grad = matlabFunction(gradient(fun(x,y), [x y]), 'Vars', [x y]);
%     dfdx = @(x,y) grad(1);
%     dfdy = @(x,y) grad(2);
    
    N = 1000;
%     steps = zeros(N,2);
    
    xk = x0;
    yk = y0;
    z = fun(x0, y0);
    steps = [x0, y0, z];
    
    for i = 1:N
        g = grad(xk, yk);
        xk1 = xk - alpha*g(1);
        yk1 = yk - alpha*g(2);
        
        z = fun(xk1,yk1);
        steps(i+1,:) = [xk1,yk1,z];
        xk = xk1;
        yk = yk1;
    end
end