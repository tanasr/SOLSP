function out = dfdx(x,y)
%     out = 2*(y^2 + x - 7) + 4*x*(x.^2 + y - 11);
    out = 2*x + 4*x*(x^2 + y - 1) + 2*y^2 - 14;
end