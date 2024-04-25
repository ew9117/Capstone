function clinton_elevation()
% this function will initialize all the maps and variables needed for thie
% clinton elevation dataset
    
    % read in the csv
    clinton = readtable('clinton_elevation.csv');

    % use if want equally spaced point
    %dx = min(clinton.X):0.5:max(clinton.X);
    %dy = min(clinton.Y):0.5:max(clinton.Y);
    
    % use if you want square grid
    % 
    dx = linspace(min(clinton.X), max(clinton.X), 200);
    dy = linspace(min(clinton.Y), max(clinton.Y), 200);

    
    [xq, yq] = meshgrid(dx, dy, 0);
    zq = griddata(clinton.X, clinton.Y, clinton.Z, xq, yq);

    % loop through points and remove some based on slope
    % might want to check to see if the slop continues to be steep
    % for i = 2:100
    %     for j = 2:100
    % 
    %         if abs((zq(i,j) - zq(i,j-1))./(yq(j) - yq(j-1))) > 0.75
    %             zq(i,j) = NaN;
    %         end
    %         if abs((zq(i,j) - zq(i - 1,j))/(yq(i) - yq(i - 1))) > 0.75
    %             zq(i,j) = NaN;
    %         end
    % 
    %     end
    % end

    % loop through points and remove based on height
    % for i = 1:100
    %     for j = 1:100
    %         if zq(i,j) > 151
    %             zq(i,j) = NaN;
    %         end
    %     end
    % end

    % create boundry mask
    % if zq(i,j) has an elevation boundary_mask(i,j) = 1
    % if zq(i,j) does not have an elevation BUT it is adjacent to a cell
    % with a defined elevation then boundary_mask(i,j) = 0
    % else zq(i,j) is nan then boundary_mask(i,j) is nan
    [m,n] = size(xq);
    boundary_mask = zq;

    % loop through all points of boundary mask
    for i = 1:m
        for j = 1:n
            % is the corresponding coordinate of the elevation map is not a
            % number
            if isnan(zq(i,j))

                try
                    if ~isnan(zq(i,j+1))
                        boundary_mask(i,j) = 0;  
                    end
                catch
                    
                end

                try
                    if ~isnan(zq(i,j-1))
                        boundary_mask(i,j) = 0;
                    end
                catch

                end

                try
                    if ~isnan(zq(i+1,j))
                        boundary_mask(i,j) = 0;
                    end
                catch

                end

                try
                    if ~isnan(zq(i-1,j))
                        boundary_mask(i,j) = 0;
                    end
                catch

                end
            else
                boundary_mask(i,j) = 1;
            end
        end
    end
    boundary_mask(1,:) = NaN;
    boundary_mask(:,1) = NaN;
    boundary_mask(m,:) = NaN;
    boundary_mask(:,n) = NaN;
    % initialize water grid post rain
    V = NaN*ones(m,n);

    % is the boundry mask says that cell can hold water there, put 1 water
    % there
    V(boundary_mask == 1) = 1;
    V(boundary_mask==0) = 1;


    % zq(isnan(boundary_mask)) = NaN;

    %randomly add plastic into the system


    deltaT = 1;

    % have to find the max elevation change of the viable water 
    %save('clinton_elevation_variables')
    g = gradient(boundary_mask, zq, 1);

    water_lst(:,:,1) = V;

    coord_lst = NaN*ones(4,2,2);
    coord_lst(1,:,1) = [1,1];
    coord_lst(1,:,1) = [1,1];

    for a = 2:4
        sum(sum(V(~isnan(V))))

        V = dance_round(boundary_mask,V,g, deltaT);
        water_lst(:,:,a) = V;
        figure
        surf(zq, V)

    end

    % figure
    % surf(xq,yq,zq,p2q)

    % s

end

