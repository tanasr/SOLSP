function [steps] = newton_method(x0, y0, alpha, N, func, grad_fx,grad_fy, H_fun)

    xk = [x0,y0];
    steps = [x0,y0,func(x0,y0)];
    for i = 1:N
        dx = grad_fx(xk(1),xk(2));
        dy = grad_fy(xk(1),xk(2));
        H = H_fun(xk(1), xk(2));
        xk1 = xk - alpha * inv(H) * [dx; dy];
        
        z = func(xk1(1), xk1(2));
%         steps(i,:) = [xk1(1),xk1(2)];
        steps = [steps; [xk1(1), xk1(2), z]];        
        xk = xk1;
    end
end