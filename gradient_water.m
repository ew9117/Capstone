% this does not currently work the way it is supposed to

function total  = gradient_water(bm, W, z)
    [m,n] = size(z);
    % g = NaN*ones(m,n,4);
    % alpha = 11.7376;
    % alpha = 3.287370735199700;
    % alpha=3.51;
    alpha = 1;
    dx = 0.05;

    % i think instead of predefining an alpha I am just going to make an
    % anonymous function and solve for alpha

    % Find indices of cells where boundary_mask equals 1
    [rows, cols] = find(bm == 1);
    
    % Initialize g
    g_dz = zeros(m, n, 4);
    
    % Calculate north, south, east, and west slopes for selected cells
    g_dz(rows, cols, 1) = alpha * ((z(rows - 1, cols) - z(rows, cols)) / dx);
    g_dz(rows, cols, 2) = alpha * ((z(rows + 1, cols) - z(rows, cols)) / dx);
    g_dz(rows, cols, 3) = alpha * ((z(rows, cols - 1) - z(rows, cols)) / dx);
    g_dz(rows, cols, 4) = alpha * ((z(rows, cols + 1) - z(rows, cols)) / dx);

    % initialze water height difference
    w_dz = zeros(m, n, 4);

    w_dz(rows, cols, 1) = alpha * ((W(rows - 1, cols) - W(rows, cols)) / dx);
    w_dz(rows, cols, 2) = alpha * ((W(rows + 1, cols) - W(rows, cols)) / dx);
    w_dz(rows, cols, 3) = alpha * ((W(rows, cols - 1) - W(rows, cols)) / dx);
    w_dz(rows, cols, 4) = alpha * ((W(rows, cols + 1) - W(rows, cols)) / dx);

    total = g_dz + w_dz;

end