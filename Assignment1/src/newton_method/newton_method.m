function [steps] = newton_method(x0, y0, alpha, N, grad_fx,grad_fy, H_fun)
    steps = zeros(N,2);
    
    xk = [x0,y0];

    for i = 1:N
        H = H_fun(xk(1), xk(2));
        xk1 = xk - alpha*inv(H) * [grad_fx(xk(1),xk(2)); grad_fy(xk(1),xk(2))];
        steps(i,:) = [xk1(1),xk1(2)];
        xk = xk1;
    end
end