function [u, norm_r, u_err, u_k] = Jacobi(A, f, u0, max_steps)

    % set up
    solution = A\f; %compute solution

    norm_r = zeros(max_steps,1);
    u_err = zeros(max_steps,length(A));
    u_k = zeros(max_steps,length(A));

    %decompose
    D = diag(diag(A)); %diagonal matrix
    D = inv(D); %calc. inverse
    D = diag(D); %transform back to column vector
    U = triu(A,+1);
    L = tril(A,-1);
    ALU = L + U; %deleted the diagonal

    % iterate
    u = u0.*ones(length(ALU),1);
    for step = 1:max_steps
        Au = zeros(length(ALU),1);
        for row = 1:length(ALU)
            for col = 1:length(ALU)
                Au(row) = Au(row) + ALU(row,col) * u0(col);
            end
        end
        u = f - Au;
        u = D.*u; %elementwise multiplication
        
        % compute the error
%         u_err(i,:) = u0 - u; %gradient, if zero, we have a stationary point
        u_err(step,:) = solution - u;        
        u0 = u;
        
        %compute the norm of the residual r = f - Au
        norm_r(step,1) = norm((f - A*u));
        
        %store the iterations in a matrix
        u_k(step,:) = u;
        
%         if norm_r(step,1) <= 1e-4
%             break
%         end
        if norm_r(step,1) <= 1e-4
            disp(['Iteration converged. Stopped after ' num2str(step)...
                ' iterations']);
            disp('GaussSeidel method yields the residual of the norm: ')
            disp(norm_r(step,:));
            break
        end

        if step == max_steps
            disp('Max. steps achieved, iteration yields the residual of the norm ');
            disp(norm_r(step,:));
        end
    end
end
