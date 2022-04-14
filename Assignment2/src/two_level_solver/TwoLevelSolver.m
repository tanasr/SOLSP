function [u, u_k, norm_r] = TwoLevelSolver(A, f, u0, max_steps, smoother)
    
    %init
    N = size(A, 1);
    smoother_steps = 5;
    
    % create restricted matrix A
    A_2h = restriction(N+1) * A * prolongation(N+1);

    norm_r = [];
    u_k = zeros(max_steps,length(A));
    uk = u0;
    
    for i = 1:max_steps

        %pre-smoothing, apply the smoother on the fine grid and 
        % calculate the residual r_h
        uk = smoother(A, f, uk, smoother_steps);
        r_h = f - A*uk;
        
        %interpolate to coarse grid, restrict residual
        r_2h = restriction(N+1)*r_h;
        % and solve error equation
        e_2h = A_2h\r_2h;
        
        %coarse grid corretion (update uk)
        uk = uk + prolongation(N+1) * e_2h;
        
        % post-smoothing
        uk = smoother(A ,f, uk, smoother_steps);
    
        %errors
        res = f - A*uk;
        norm_r(i) = norm(res); %norm of the residual
        u_k(i, :) = uk(:);
        
        %break
        if norm_r(i) < 1e-12
            break
        end
    end
    u = uk; 
end


