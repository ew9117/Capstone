function new_pq = plastic_movement(boundary_mask, pq,g)
    %load('clinton_elevation_variables.mat')

    % initialize post movement array by copying current matrix
    new_pq = pq;
    [m,n] = size(boundary_mask);
    deltaT = 1;
    % loop through all the points
    for i = 1:m
        for j = 1:n
            % if this cell is able to hold plastic
            if boundary_mask(i,j) == 1
                % find most negative direction
                [magnitude, dir] = min(g(i,j,:));
    
                % move north
                if dir == 1
                    if boundary_mask(i-1,j) == 1
                        new_pq(i - 1, j) = new_pq(i - 1, j) + pq(i,j);
                        new_pq(i,j) = new_pq(i,j) - pq(i,j);
                    end
                
                % move south
                elseif dir == 2
                    if boundary_mask(i+1,j) == 1
                        new_pq(i + 1, j) = new_pq(i + 1, j) + pq(i,j);
                        new_pq(i,j) = new_pq(i,j) - pq(i,j);
                    end
                
                % move east
                elseif dir == 3          
                    if boundary_mask(i,j-1) == 1
                        new_pq(i, j-1) = new_pq(i, j-1) + pq(i,j);
                        new_pq(i,j) = new_pq(i,j) - pq(i,j);
                    end
                
                % move west
                elseif dir == 4            
                    if boundary_mask(i,j+1) == 1
                        new_pq(i, j+1) = new_pq(i, j+1) + pq(i,j);
                        new_pq(i,j) = new_pq(i,j) - pq(i,j);
                    end
                end
            end
        end
    end
end
               