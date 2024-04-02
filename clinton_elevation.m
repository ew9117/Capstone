function clinton_elevation()
    clinton = readtable('clinton_elevation.csv');
    %dx = min(clinton.X):0.5:max(clinton.X);
    %dy = min(clinton.Y):0.5:max(clinton.Y);
    dx = linspace(min(clinton.X), max(clinton.X));
    dy = linspace(min(clinton.Y), max(clinton.Y));

    [xq, yq] = meshgrid(dx, dy, 0);
    %scatter3(clinton.X, clinton.Y, clinton.Z)
    zq = griddata(clinton.X, clinton.Y, clinton.Z, xq, yq);

    % loop through points and remove some based on slope
    % might want to check to see if the slop continues to be steep
    for i = 2:100
        for j = 2:100
            
            if abs((zq(i,j) - zq(i,j-1))./(yq(j) - yq(j-1))) > 0.75
                zq(i,j) = NaN;
            end
            if abs((zq(i,j) - zq(i - 1,j))/(yq(i) - yq(i - 1))) > 0.75
                zq(i,j) = NaN;
            end

        end
    end
    for i = 1:100
        for j = 1:100
            if zq(i,j) > 151
                zq(i,j) = NaN;
            end
        end
    end

    % boundry mask 
    bm = NaN.*ones(100, 100);
    % loop through all points of boundary mask
    for i = 2:99
        for j = 2:99
            % is the corresponding coordinate of the elevation map is not a
            % number
            if isnan(zq(i,j))

                % is this cell has any neighbors with elevation values
                if ~isnan(zq(i,j+1))
                    bm(i,j) = 0;
                elseif ~isnan(zq(i,j-1))
                    bm(i,j) = 0;
                elseif ~isnan(zq(i+1,j))
                    bm(i,j) = 0;
                elseif ~isnan(zq(i-1,j))
                    bm(i,j) = 0;
                end
            else
                % this cell has no elevation data and no neighbors with
                % elevation data
                bm(i,j) = 1;
            end
        end
    end

    vq = NaN*ones(100,100);
    wq = NaN*ones(100,100);

    vq(bm == 1) = 1;

    
    figure;
    surf(xq,yq,vq)
end

