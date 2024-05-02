function W = maybe(boundary_mask, V, g)
    % Initialize post-movement array by copying the current matrix
    W = V;
    [m, n] = size(boundary_mask);
    deltaT = 1;

    % Mask for non-NaN elements in boundary_mask
    valid_mask = ~isnan(boundary_mask);

    % Check if water can move in each direction using logical indexing
    north_indices = 1:m-1;
    south_indices = 2:m;
    west_indices = 1:n-1;
    east_indices = 2:n;

    north_flow = g(north_indices, :, 1) < 0 & boundary_mask(north_indices, :) == 1 & valid_mask(north_indices, :);
    south_flow = g(south_indices, :, 2) < 0 & boundary_mask(south_indices, :) == 1 & valid_mask(south_indices, :);
    west_flow = g(:, west_indices, 3) < 0 & boundary_mask(:, west_indices) == 1 & valid_mask(:, west_indices);
    east_flow = g(:, east_indices, 4) < 0 & boundary_mask(:, east_indices) == 1 & valid_mask(:, east_indices);

    % Update water movement in each direction
    if any(north_flow, 'all')
        W(north_indices(north_flow)) = W(north_indices(north_flow)) - deltaT * g(north_flow) .* V(north_indices(north_flow));
        W(south_indices(north_flow)) = W(south_indices(north_flow)) + deltaT * g(north_flow) .* V(north_indices(north_flow));
    end

    if any(south_flow, 'all')
        W(south_indices(south_flow)) = W(south_indices(south_flow)) - deltaT * g(south_flow) .* V(south_indices(south_flow));
        W(north_indices(south_flow)) = W(north_indices(south_flow)) + deltaT * g(south_flow) .* V(south_indices(south_flow));
    end

    if any(west_flow, 'all')
        W(:, west_indices(west_flow)) = W(:, west_indices(west_flow)) - deltaT * g(west_flow) .* V(:, west_indices(west_flow));
        W(:, east_indices(west_flow)) = W(:, east_indices(west_flow)) + deltaT * g(west_flow) .* V(:, west_indices(west_flow));
    end

    if any(east_flow, 'all')
        W(:, east_indices(east_flow)) = W(:, east_indices(east_flow)) - deltaT * g(east_flow) .* V(:, east_indices(east_flow));
        W(:, west_indices(east_flow)) = W(:, west_indices(east_flow)) + deltaT * g(east_flow) .* V(:, east_indices(east_flow));
    end
end
