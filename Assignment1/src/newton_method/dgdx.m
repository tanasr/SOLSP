function out = dgdx(x,y)
%     out = 2*(1 - x)*(-1) + 2*100*x.*(y - x.^2).*(-2*x);
    out = 2*(200*x.^3 - 200*x.*y + x - 1);
end
