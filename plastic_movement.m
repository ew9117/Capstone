function pq = plastic_movement(pq, boundary_mask, p2q,g)
    %load('clinton_elevation_variables.mat')
    % for now this will just move all the water into the cell with the
    % greatest slope
    [m,n] = size(boundary_mask);
    % loop through all the points
    for i = 1:m
        for j = 1:n
            % if this cell is able to hold water
            if boundary_mask(i,j) == 1
                % if north is steepest direction
                if g(i,j,1) == 1
                    % if the north cell can hold water
                    if boundary_mask(i-1,j) == 1
                        pq(i-1,j) = pq(i-1,j) + p2q(i,j);
                    else
                        pq(i,j) = p2q(i,j);
                    end
                % if south is the steepest direction
                elseif g(i,j,1) == 2
                    % if the south cell can hold water
                    if boundary_mask(i+1,j) == 1
                        pq(i+1,j) = pq(i+1,j) + p2q(i,j);
                    else
                        pq(i,j) = p2q(i,j);
                    end
                % if east is the steepest direction
                elseif g(i,j,1) == 3
                    % if the east cell can hold water
                    if boundary_mask(i,j - 1) == 1
                        pq(i,j - 1) = pq(i,j - 1) + p2q(i,j);
                    else
                        pq(i,j) = p2q(i,j);
                    end
                % if west is the steepest direction
                elseif g(i,j,1) == 4
                    % if the north cell can hold water
                    if boundary_mask(i,j + 1) == 1
                        pq(i,j + 1) = pq(i,j + 1) + p2q(i,j);
                    else
                        pq(i,j) = p2q(i,j);
                    end
                end
                                        
                                        
                                        

            else
                pq(i,j) = p2q(i,j);
            end
        end
    end
end
                