function clinton_elevation()
% this function will initialize all the maps and variables needed for thie
% clinton elevation dataset
    
    % read in the csv
    clinton = readtable('clinton_elevation.csv');

    % use if want equally spaced point
    %dx = min(clinton.X):0.5:max(clinton.X);
    %dy = min(clinton.Y):0.5:max(clinton.Y);
    
    % use if you want square grid
    dx = linspace(min(clinton.X), max(clinton.X), 200);
    dy = linspace(min(clinton.Y), max(clinton.Y), 200);
    (max(clinton.Y) - min(clinton.Y))/200;
    size(dx);
    [xq, yq] = meshgrid(dx, dy, 0);
    zq = griddata(clinton.X, clinton.Y, clinton.Z, xq, yq);
    deltaX = 0.2;
    % loop through points and remove some based on slope
    % might want to check to see if the slop continues to be steep
    [m,n] = size(xq);
    disp(zq);
    temp_zq = zq;
    oringinal = zq;
    for i = 2:m
        for j = 2:n
            % abs((zq(i,j) - zq(i,j-1))./(xq(i,j) - xq(i,j-1)))
            if abs((zq(i,j) - zq(i,j-1))./(xq(i,j) - xq(i,j-1))) > 0.1
                temp_zq(i,j) = -1;
            end
            if abs((zq(i,j) - zq(i - 1,j))/(yq(i,j) - yq(i - 1,j))) > 0.1
                temp_zq(i,j) = -1;            
            end

        end
    end
    % disp(temp_zq)

    % loop through points and remove based on height
    for i = 1:m
        for j = 1:n
            if zq(i,j) > 150.2
                temp_zq(i,j) = -1;
            end
            if zq(i,j) > 157
                temp_zq(i,j) = NaN;
            end
        end
    end
    figure 
    surf(temp_zq)
    % disp(temp_zq)
    for i = 2:m
        for j = 2:n

            if abs((zq(i,j) - zq(i,j-1))./(xq(i,j) - xq(i,j-1))) > 0.1
                zq(i,j) = NaN;
            end
            if abs((zq(i,j) - zq(i - 1,j))/(yq(i,j) - yq(i - 1,j))) > 0.1
                zq(i,j) = NaN;            
            end

        end
    end    
    for i = 1:m
        for j = 1:n
            if zq(i,j) > 150.2
                zq(i,j) = NaN;
            end
        end
    end    
    % zq = temp_zq;
    % create boundry mask
    % if zq`    (i,j) has an elevation boundary_mask(i,j) = 1
    % if zq(i,j) does not have an elevation BUT it is adjacent to a cell
    % with a defined elevation then boundary_mask(i,j) = 0
    % else zq(i,j) is nan then boundary_mask(i,j) is nan
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
    V(boundary_mask == 0) = 1;


    % zq(isnan(boundary_mask)) = NaN;

    %randomly add plastic into the system


    deltaT = 0.01;

    % have to find the max elevation change of the viable water 
    %save('clinton_elevation_variables')
    alpha = 1;
    g = gradient(boundary_mask, zq, V, deltaX, alpha);

    water_lst(:,:,1) = V;

    coord_lst = NaN*ones(4,2,2);
    coord_lst(1,:,1) = [1,1];
    coord_lst(1,:,1) = [1,1];

    for a = 2:2
        sum(sum(V(~isnan(V))));

        V = dance_round(boundary_mask,V,g,deltaT);
        water_lst(:,:,a) = V;

    end

    temp_interp = NaN*ones(m,90);
    for i = 1:m
        for j = 80:170
            temp_interp(i,j) = temp_zq(i,j);
        end
    end
    temp2 = NaN*ones(m,90);
    for i = 1:m
        for j = 80:170
            temp2(i,j) = oringinal(i,j);
        end
    end
    good_x_list = [];
    good_y_list = [];
    good_z_list = [];
    % temp_interp
    % point_counter = 1;
    % good_x_list = NaN*ones(10000);
    % good_y_list = NaN*ones(10000);
    % good_z_list = NaN*ones(10000);
    for i = 1:m
        for j = 80:170
            if (~isnan(temp_interp(i, j))) && (temp_interp(i,j)~=-1)
                good_x_list = [good_x_list xq(i, j)];
                good_y_list = [good_y_list yq(i, j)];
                good_z_list = [good_z_list zq(i, j)];
                % good_x_list(point_counter) = xq(i,j);
                % good_y_list(point_counter) = yq(i,j);
                % good_z_list(point_counter) = zq(i,j);
                % point_counter = point_counter + 1;
            end
        end
    end
    count = 0;
    size(good_z_list)
    m
    % x_interp = [];
    % y_interp = [];
    for i = 1:m
        for j = 80:170
            if temp_interp(i,j) == -1
                % x_interp = [x_interp xq(i,j)]; 
                % y_interp = [y_interp yq(i,j)]; 
                
                interpolated_z = griddata(good_x_list, good_y_list, good_z_list, xq(i,j), yq(i, j), 'nearest');
                interpolated_z;
               
                temp_interp(i, j) = interpolated_z;
            end
        end
    end
    % [xwhat, ywhat] = meshgrid(x_interp, y_interp);
    % ugh = griddata(good_x_list, good_y_list, good_z_list, xwhat, ywhat, 'nearest');
    % disp(ugh)
    figure
    surf(zq)
    colormap abyss
    
    shading interp
    figure 
    surf(temp2)
    colormap abyss

    shading interp
    for i = 1:m
        for j = 80:170
            if temp_interp(i,j) > 157
                temp_interp(i,j) = NaN;
            end
        end
    end    
    figure 
    surf(temp_interp)
    colormap abyss
    shading interp

    
% water plotting purposes
    % for i = 1:50
    %     if mod(i,10) == 0 || i == 1
    %         figure
    %         % c = colormap('default');
    %         scaled_vq = (water_lst(:,:,i) - min(water_lst(:))) / (max(water_lst(:)) - min(water_lst(:)));
    %         % color_temp = round(scaled_vq * (size(c, 1) - 1)) + 1;
    %         % color_temp = max(1, min(color_temp, size(c, 1)));
    %         % colors = c(color_temp, :);
    %         % scatter3(coord_lst(i,1), coord_lst(i,2), interpolated_z(i), 100 ,'filled','MarkerFaceColor',[1 1 1])
    %         hold on
    %         surf(new_z)
    %         shading interp
    % 
    %         % colorbar('Ticks', 0:0.2:1);
    %         colormap(flip(parula))
    %         clim([0 1]);
    %         hold off
    %     end
    % end

end

