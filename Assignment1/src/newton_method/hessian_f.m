function [out] = hessian_f(x,y)
    
    dfxx = 12*x.^2 + 4*y - 2;
    dfxy = 4*(x + y);
    dfyx = 4*(x + y);
    dfyy = 4*x + 12*y.^2 - 26;

    out = [[dfxx, dfxy]; 
           [dfyx, dfyy]];
end