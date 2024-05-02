function g  = gradient(boundary_mask, z, V, deltaX, alpha)
    [m,n] = size(z);
    g = NaN*ones(m,n,4);



    % alpha = 11.7376;
    % alpha = 3.287370735199700;
    % alpha=3.51;
    % alpha = 1;
    dx = 0.05;

    % I am going to try and include the water height in this output but I
    % dont think it is going to work for some reason

    for i = 1:m
        for j = 1:n
            % if current cell can hold water
            if boundary_mask(i,j) == 1 || boundary_mask(i,j) == 0
                % north slope
                % if boundary_mask(i,j) == 1 && boundary_mask(i-1,j) == 1
                    g(i,j,1) = alpha*((z(i - 1,j) - z(i,j))/deltaX) + alpha*((V(i - 1,j) - V(i,j))/deltaX);
                % else
                    % g(i,j,1) = alpha*((z(i - 1,j) - z(i,j))/dx);
                % end
                % south slope 
                % if boundary_mask(i,j) == 1 && boundary_mask(i+1,j) == 1
                    g(i,j,2) = alpha*((z(i + 1,j) - z(i,j))/deltaX) + alpha*((V(i + 1,j) - V(i,j))/deltaX);
                % else
                    % g(i,j,2) = alpha*((z(i + 1,j) - z(i,j))/dx);
                % end

                % east slope
                % if boundary_mask(i,j) == 1 && boundary_mask(i,j-1) == 1
                    g(i,j,3) = alpha*((z(i,j - 1) - z(i,j))/deltaX) + alpha*((V(i,j - 1) - V(i,j))/deltaX);  
                % else
                    % g(i,j,3) = alpha*((z(i,j - 1) - z(i,j))/dx);
                % end

                % west slope
                % if boundary_mask(i,j) == 1 && boundary_mask(i,j+1) == 1
                    g(i,j,4) = alpha*((z(i,j + 1) - z(i,j))/deltaX) + alpha*((V(i,j + 1) - V(i,j))/deltaX); 
                % else 
                %     g(i,j,4) = alpha*((z(i,j + 1) - z(i,j))/dx);
                % end
            end
        end
    end
end