function clinton_elevation()
    clinton = readtable('clinton_elevation.csv');
    dx = min(clinton.X):0.5:max(clinton.X);
    dy = min(clinton.Y):0.5:max(clinton.Y);

    [xq, yq] = meshgrid(dx, dy, 0);

    %scatter3(clinton.X, clinton.Y, clinton.Z)
    vq = griddata(clinton.X, clinton.Y, clinton.Z, xq, yq);
    for i = 1:69
        for j = 1:129
            if vq(i,j) > 151
                vq(i,j) = NaN;
            end
        end
    end
    hold on
    surf(xq,yq,vq)
    hold off