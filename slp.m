function solp = slp(coord1, coord2, ddx, z)

    x1 = round(coord1(1));
    y1 = round(coord1(2));
    x2 = round(coord2(1));
    y2 = round(coord2(2));
    % slope obvs

    % dx = -5:0.05:5;
    % dy = dx;
    % [xq, yq] = meshgrid(dx, dy);
    % z = -exp(-(xq.^2 + yq.^2));
    % zq = griddata(dx, dy, z, xq, yq);

    if ~anynan([x1,y1,x2,y2])
        % z(x1,y1)
        % z(x2,y2)
        alpha = 1;
        % interp2(xq, yq, zq, x2, y2)
        % interp2(xq, yq, zq, x1, y1)
        solp = alpha*(z(x1,y1) - z(x2,y2))/ddx;
       
    else
        solp = 0;
    end
end
    