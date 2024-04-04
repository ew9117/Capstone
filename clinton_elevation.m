function clinton_elevation()
% this function will initialize all the maps and variables needed for thie
% clinton elevation dataset
    
    % read in the csv
    clinton = readtable('clinton_elevation.csv');

    % use if want equally spaced point
    %dx = min(clinton.X):0.5:max(clinton.X);
    %dy = min(clinton.Y):0.5:max(clinton.Y);
    
    % use if you want square grid
    dx = linspace(min(clinton.X), max(clinton.X));
    dy = linspace(min(clinton.Y), max(clinton.Y));

    
    [xq, yq] = meshgrid(dx, dy, 0);
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

    % loop through points and remove based on height
    for i = 1:100
        for j = 1:100
            if zq(i,j) > 151
                zq(i,j) = NaN;
            end
        end
    end


    % create boundry mask
    % if zq(i,j) has an elevation boundary_mask(i,j) = 1
    % if zq(i,j) does not have an elevation BUT it is adjacent to a cell
    % with a defined elevation then boundary_mask(i,j) = 0
    % else zq(i,j) is nan then boundary_mask(i,j) is nan
    boundary_mask = NaN.*ones(100, 100);
    % loop through all points of boundary mask
    for i = 2:99
        for j = 2:99
            % is the corresponding coordinate of the elevation map is not a
            % number
            if isnan(zq(i,j))

                % is this cell has any neighbors with elevation values
                if ~isnan(zq(i,j+1))
                    boundary_mask(i,j) = 0;
                elseif ~isnan(zq(i,j-1))
                    boundary_mask(i,j) = 0;
                elseif ~isnan(zq(i+1,j))
                    boundary_mask(i,j) = 0;
                elseif ~isnan(zq(i-1,j))
                    boundary_mask(i,j) = 0;
                end
            else
                % this cell has no elevation data and no neighbors with
                % elevation data
                boundary_mask(i,j) = 1;
            end
        end
    end

    % initialize water grid post rain
    vq = NaN*ones(100,100);

    % is the boundry mask says that cell can hold water there, put 1 water
    % there
    vq(boundary_mask == 1) = 1;

    % initialize water grid post water movement
    wq = 0*ones(100,100);

    delta_t = 1;

    % have to find the max elevation change of the viable water 
    %save('clinton_elevation_variables')

    for i = 1:60
        vq = dance_round(wq, boundary_mask,vq);
    end
    s = surf(xq,yq,zq);
    s
    % s.CData = vq;
    % s

end

