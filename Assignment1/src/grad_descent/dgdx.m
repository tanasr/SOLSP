function out = dgdx(x,y)
%     out = 2*(1 - x)*(-1) + 2*100*x.*(y - x.^2).*(-2*x);
    out = 2*x - 400*x*(- x^2 + y) - 2;
end
