function g = steepest(boundary_mask, z)
    [m,n] = size(boundary_mask);
    g = NaN*ones(m,n,2);

    dx = 1;

    for i = 2:(m-1)
        for j = 2:(n-1)
            % if current cell can hold water
            if boundary_mask(i,j) == 1
                g(i,j,1) = 1;
                g(i,j,2) = 1;
                if boundary_mask(i-1,j) == 1
                    % north slope
                    north_slope = ((z(i - 1,j) - z(i,j))/dx);
                    if north_slope < g(i,j,2)
                        g(i,j,1) = 1;
                        g(i,j,2) = north_slope;
                    end
                end
                if boundary_mask(i+1,j) == 1
                    % south slope 
                    south_slope = ((z(i + 1,j) - z(i,j))/dx);
                    if south_slope < g(i,j,2)
                        g(i,j,1) = 2;
                        g(i,j,2) = south_slope;
                        
                    end
                end

                if boundary_mask(i,j - 1) == 1
                    % east slope
                    east_slope = ((z(i,j - 1) - z(i,j))/dx);  
                    if east_slope < g(i,j,2)
                        g(i,j,1) = 3;
                        g(i,j,2) = east_slope;
                    end
                end

                if boundary_mask(i,j+1) == 1                 
                    % west slope
                    west_slope = ((z(i,j + 1) - z(i,j))/dx); 
                    if west_slope < g(i,j,2)
                        g(i,j,1) = 4;
                        g(i,j,2) = west_slope;
                    end
                end
            end

        end
    end
    
end

