function [out] = hessian_g(x,y)
    
    dgxx = 1200*x^2 - 400*y + 2;
    dgxy = -400*x;
    dgyx = -400*x;
    dgyy = 200;

    out = [[dgxx, dgxy]; 
           [dgyx, dgyy]];
end