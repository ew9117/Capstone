function W = dance_round(boundary_mask, V,g)
    % V is water location post rainfall and W is water location post
    % movement
    % initialize post movement array by copying current matrix
    W = V;
    [m,n] = size(boundary_mask);
    deltaT = 1;
    % loop through all the points
    for i = 1:m
        for j = 1:n
            % check if current cell can hold water
            if boundary_mask(i,j) == 1 || boundary_mask(i,j) == 0

                % CHECK IF WATER CAN MOVE NORTH
                if g(i,j,1) < 0
                    % water flows from i,j to i-1,j
                    if boundary_mask(i-1,j) == 1
                        % move water into new cell
                        W(i-1,j) = W(i-1,j) - deltaT*g(i,j,1)*V(i,j);
                    end
                    %check if current cell is not boundary
                    if boundary_mask(i,j) == 1
                        % remove water from current cell
                        W(i,j) = W(i,j) + deltaT*g(i,j,1)*V(i,j);
                    end
                 end
   

                % CHECK IF WATER CAN MOVE SOUTH
                if g(i,j,2) < 0
                    % water flows from i,j to i+1,j
                    if boundary_mask(i+1,j) == 1
                        % move water into new cell
                        W(i+1,j) = W(i+1,j) - deltaT*g(i,j,2)*V(i,j);
                    end
                    %check if current cell is not boundary
                    if boundary_mask(i,j) == 1
                        % remove water from current cell
                        W(i,j) = W(i,j) + deltaT*g(i,j,2)*V(i,j);
                    end
                 end


                % CHECK IF WATER CAN MOVE WEST
                if g(i,j,3) < 0
                    % water flows from i,j to i,j-1
                    if boundary_mask(i,j-1) == 1
                        % move water into new cell
                        W(i,j-1) = W(i,j-1) - deltaT*g(i,j,3)*V(i,j);
                    end
                    %check if current cell is not boundary
                    if boundary_mask(i,j) == 1
                        % remove water from current cell
                        W(i,j) = W(i,j) + deltaT*g(i,j,3)*V(i,j);
                    end
                 end


                % CHECK IF WATER CAN MOVE WEST
                if g(i,j,4) < 0
                    % water flows from i,j to i,j+1
                    if boundary_mask(i,j+1) == 1
                        % move water into new cell
                        W(i,j+1) = W(i,j+1) - deltaT*g(i,j,4)*V(i,j);
                    end
                    %check if current cell is not boundary
                    if boundary_mask(i,j) == 1
                        % remove water from current cell
                        W(i,j) = W(i,j) + deltaT*g(i,j,4)*V(i,j);
                    end
                 end
            end
        end
    end
end
                