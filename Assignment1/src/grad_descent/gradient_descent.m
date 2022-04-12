function [steps] = gradient_descent(x0, y0, alpha, N, func)

    steps = zeros(N+1,2);
    x = x0; y = y0;
    steps(1,:) = [x,y]; %include starting point
    
    if func == 'f'
        pkx = @(x,y) -alpha*dfdx(x,y);
        pky = @(x,y) -alpha*dfdy(x,y);
    elseif func == 'g'
        pkx = @(x,y) -alpha*dgdx(x,y);
        pky = @(x,y) -alpha*dgdy(x,y);
    end

    for i = 1:N
        x = x + pkx(x,y);
        y = y + pky(x,y);
        steps(i+1,:) = [x,y];
    end

    xopt = x;
    yopt = y;
    if func == 'f'
        disp('======== Func F ========');
        fopt = funcf(xopt,yopt);
        fprintf('Starting point:  \n(%f,%f)\n', x0,y0);
        fprintf('The minimiser located at:      \n(%f,%f)\n', xopt,yopt);
        fprintf('Value of func F at local minimum:  \n%f\n', fopt);
    elseif func == 'g'
        disp('======== Func G ========');
        gopt = funcg(xopt,yopt);
        fprintf('Starting point:  \n(%f,%f)\n', x0,y0);
        fprintf('The minimiser located at:      \n(%f,%f)\n', xopt,yopt);
        fprintf('Value of func G at local minimum:  \n%f\n', gopt);
    end
       
end