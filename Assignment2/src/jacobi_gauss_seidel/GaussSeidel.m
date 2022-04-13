function [u, norm_r, u_err, u_k] = GaussSeidel(A, f, u0, max_steps)

    % set up
    solution = A\f; %compute solution

    norm_r = zeros(max_steps,1);
    u_err = zeros(max_steps,length(A));
    u_k = zeros(max_steps,length(A));

    %decompose
    D = diag(diag(A)); %matrix
    D = inv(D);
    D = diag(D);
    U = triu(A,+1);
    L = tril(A,-1);
    LD = L+U;

    % iterate
    u = zeros(length(LD),1);
    u_new = zeros(length(LD),1);
    for i = 1:max_steps
        Au = zeros(length(LD),1);
        for row = 1:length(LD)
            for col = 1:length(LD)
                Au(row) = Au(row) + U(row,col) * u0(col) + L(row,col)*u_new(col);
                %u = (L + D)\(-U*u + f) %GaussSeidel
            end
            u(row) = D(row) * (f(row) - Au(row));
            u_new(row) = u(row);
        end

        % compute the error
%         u_err(i,:) = u0 - u; %gradient, if zero, we have a stationary point
        u_err(i,:) = solution - u;        
        u0 = u;
        
        %compute the norm of the residual r = f - Au
        norm_r(i,1) = norm((f - A*u));
        %store the iterations in a matrix
        u_k(i,:) = u;
        
        if norm_r(i,1) <= 1e-4
            disp(['Iteration converged. Stopped after ' num2str(i)...
                ' iterations']);
            disp('GaussSeidel method yields the residual of the norm: ')
            disp(norm_r(i,:));
            break
        end

        if i == max_steps
            disp('Max. steps achieved, iteration yields the residual of the norm ');
            disp(norm_r(i,:));
        end
    end
end
