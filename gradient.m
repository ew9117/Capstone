function g  = gradient(boundary_mask, z)
    [m,n] = size(z);
    g = NaN*ones(m,n,4);



    % alpha = 11.7376;
    % alpha = 3.287370735199700;
    % alpha=3.51;
    alpha = 1;
    dx = 0.1;

    % i think instead of predefining an alpha I am just going to make an
    % anonymous function and solve for alpha

    for i = 1:m
        for j = 1:n
            % if current cell can hold water
            if boundary_mask(i,j) == 1
                % north slope
                g(i,j,1) = alpha*((z(i - 1,j) - z(i,j))/dx);
                % south slope 
                g(i,j,2) = alpha*((z(i + 1,j) - z(i,j))/dx);
                % east slope
                g(i,j,3) = alpha*((z(i,j - 1) - z(i,j))/dx);  
                % west slope
                g(i,j,4) = alpha*((z(i,j + 1) - z(i,j))/dx); 
            end
        end
    end
end