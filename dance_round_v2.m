function wq_prime = dance_round_v2(boundary_mask, vq,g)
    [m,n] = size(boundary_mask);

    % Get indices of cells where boundary_mask equals 1
    [i, j] = find(boundary_mask == 1);
    deltaT = 1;
    % Initialize wq_prime
    wq_prime = vq;
    
    % Check for water flow in north direction
    north_indices = sub2ind([m, n], i-1, j);
    north_flow = g(sub2ind([m, n, 1], i, j, ones(size(i)))) < 0 & boundary_mask(north_indices) == 1;
    wq_prime(north_indices(north_flow)) = wq_prime(north_indices(north_flow)) - deltaT * g(sub2ind([m, n, 4], i(north_flow), j(north_flow), ones(sum(north_flow), 1))) .* vq(sub2ind([m, n], i(north_flow), j(north_flow)));
    wq_prime(sub2ind([m, n], i(north_flow), j(north_flow))) = wq_prime(sub2ind([m, n], i(north_flow), j(north_flow))) + deltaT * g(sub2ind([m, n, 4], i(north_flow), j(north_flow), ones(sum(north_flow), 1))) .* vq(sub2ind([m, n], i(north_flow), j(north_flow)));
    % 
    % % Check for water flow in south direction
    south_indices = sub2ind([m, n], i+1, j);
    south_flow = g(sub2ind([m, n, 2], i, j, 2*ones(size(i)))) < 0 & boundary_mask(south_indices) == 1;
    wq_prime(south_indices(south_flow)) = wq_prime(south_indices(south_flow)) - deltaT * g(sub2ind([m, n, 4], i(south_flow), j(south_flow), 2*ones(sum(south_flow), 1))) .* vq(sub2ind([m, n], i(south_flow), j(south_flow)));
    wq_prime(sub2ind([m, n], i(south_flow), j(south_flow))) = wq_prime(sub2ind([m, n], i(south_flow), j(south_flow))) + deltaT * g(sub2ind([m, n, 4], i(south_flow), j(south_flow), 2*ones(sum(south_flow), 1))) .* vq(sub2ind([m, n], i(south_flow), j(south_flow)));
    
    % Check for water flow in east direction
    east_indices = sub2ind([m, n], i, j-1);
    east_flow = g(sub2ind([m, n, 3], i, j, 3*ones(size(i)))) < 0 & boundary_mask(east_indices) == 1;
    wq_prime(east_indices(east_flow)) = wq_prime(east_indices(east_flow)) - deltaT * g(sub2ind([m, n, 4], i(east_flow), j(east_flow), 3*ones(sum(east_flow), 1))) .* vq(sub2ind([m, n], i(east_flow), j(east_flow)));
    wq_prime(sub2ind([m, n], i(east_flow), j(east_flow))) = wq_prime(sub2ind([m, n], i(east_flow), j(east_flow))) + deltaT * g(sub2ind([m, n, 4], i(east_flow), j(east_flow), 3*ones(sum(east_flow), 1))) .* vq(sub2ind([m, n], i(east_flow), j(east_flow)));

    % Check for water flow in west direction
    west_indices = sub2ind([m, n], i, j+1);
    west_flow = g(sub2ind([m, n, 4], i, j, 4*ones(size(i)))) < 0 & boundary_mask(west_indices) == 1;
    wq_prime(west_indices(west_flow)) = wq_prime(west_indices(west_flow)) - deltaT * g(sub2ind([m, n, 4], i(west_flow), j(west_flow), 4*ones(sum(west_flow), 1))) .* vq(sub2ind([m, n], i(west_flow), j(west_flow)));
    wq_prime(sub2ind([m, n], i(west_flow), j(west_flow))) = wq_prime(sub2ind([m, n], i(west_flow), j(west_flow))) + deltaT * g(sub2ind([m, n, 4], i(west_flow), j(west_flow), 4*ones(sum(west_flow), 1))) .* vq(sub2ind([m, n], i(west_flow), j(west_flow)));
end