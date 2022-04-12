function out = dfdy(x,y)
    out = 4*y.*(y.^2 + x - 7) + 2*(x.^2 + y - 11);
end