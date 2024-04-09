function wq = dance_round(wq, boundary_mask, vq,g)
    %load('clinton_elevation_variables.mat')
    % for now this will just move all the water into the cell with the
    % greatest slope
    [m,n] = size(boundary_mask);
    % loop through all the points
    for i = 2:m
        for j = 2:n
            % if this cell is able to hold water
            if boundary_mask(i,j) == 1
                % if water can move north
                if boundary_mask(i-1,j) == 1
                    % water flows from i-1,j to i,j
                    if g(i,j,1) > 0
                        wq(i-1,j) = wq(i-1,j) + g(i,j,1)*vq(i,j);
                    end
                    % wq(i,j) = w(i,j) - g(i,j,1);
                end
                % if water can move south
                % if boundary_mask(i+1,j) == 1
                %     if g(i,j,2) < 0
                %         wq(i+1,j) = wq(i+1,j) + g(i,j,2)*vq(i,j);
                %     end
                %     % wq(i,j) = wq(i,j) - g(i,j,2)*v(i,j);                    
                % end
                % if water can move east
                if boundary_mask(i,j-1) == 1
                    if g(i,j,3) > 0
                        wq(i,j-1) = wq(i,j-1) + g(i,j,3)*vq(i,j);
                    end                    % wq(i,j) = w(i,j) - g(i,j,1);                    
                end
                % if the water can move west
                % if boundary_mask(i,j+1) == 1
                %     if g(i,j,4) < 0
                %         wq(i,j+1) = wq(i,j+1) + g(i,j,4)*vq(i,j);
                %     end
                % 
                %     % wq(i,j) = wq(i,j) - g(i,j,4)*v(i,j);                    
                % end                
            else
                wq(i,j) = vq(i,j);
            end
        end
    end
end
                