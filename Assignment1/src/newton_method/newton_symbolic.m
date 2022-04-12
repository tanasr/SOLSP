function [steps] = newton_symbolic(fun, x0, y0, alpha)
    
    syms x y;
    grad = matlabFunction(gradient(fun(x,y), [x y]), 'Vars', [x y]);
    H = matlabFunction(hessian(fun(x, y), [x y]), "Vars", [x y]);
    
    N = 1000;
    steps = zeros(N,2);
    
    xk = [x0,y0];

    for i = 1:N
        xk1 = xk - alpha*inv(H(xk(1),xk(2))) * grad(xk(1),xk(2));
        steps(i,:) = [xk1(1),xk1(2)];
        xk = xk1;
    end
end