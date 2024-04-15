function wq = dance_round(boundary_mask, vq,g)
    %load('clinton_elevation_variables.mat')

    % initialize post movement array by copying current matrix
    wq = vq;
    [m,n] = size(boundary_mask);
    deltaT = 1;
    % loop through all the points
    for i = 2:(m - 1)
        for j = 2:(n-1)
            % if this cell is able to hold water
            if boundary_mask(i,j) == 1
                % if water can move north
                if boundary_mask(i-1,j) == 1
                    % water flows from i-1,j to i,j
                    if g(i,j,1) < 0
                        % move water into new cell
                        wq(i-1,j) = wq(i-1,j) - deltaT*g(i,j,1)*vq(i,j);
                        % remove water from current cell
                        wq(i,j) = wq(i,j) + deltaT*g(i,j,1)*vq(i,j);
                    end
                end
                % if water can move south
                if boundary_mask(i+1,j) == 1
                    if g(i,j,2) < 0
                        wq(i+1,j) = wq(i+1,j) - deltaT*g(i,j,2)*vq(i,j);
                        wq(i,j) = wq(i,j) + deltaT*g(i,j,2)*vq(i,j);   
                    end
                end
                % if water can move east
                if boundary_mask(i,j-1) == 1
                    if g(i,j,3) < 0
                        wq(i,j-1) = wq(i,j-1) - deltaT*g(i,j,3)*vq(i,j);
                        wq(i,j) = wq(i,j) + deltaT*g(i,j,3)*vq(i,j); 
                    end
                end
                % if the water can move west
                if boundary_mask(i,j+1) == 1
                    if g(i,j,4) < 0
                        wq(i,j+1) = wq(i,j+1) - deltaT*g(i,j,4)*vq(i,j);
                        wq(i,j) = wq(i,j) + deltaT*g(i,j,4)*vq(i,j);  
                    end
                end               
            end
        end
    end
end
                