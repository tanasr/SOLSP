function [I] = restriction(N)
    % output dimension: 32x63 if N = 64
    o =  [1, 2, 1];
    I = zeros(floor((N-1)/2), N-1);
    for i = 1:floor((N-1)/2)
        j = 2 * i-1;
        I(i,j:j+2) = o;
    end
    I = 1/4 * I;
end
