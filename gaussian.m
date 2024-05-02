function gaussian()
    % this function will initialize all the maps and variables needed for thie
    % clinton elevation dataset
    deltaX = 0.25
    dx = -3:deltaX:3;
    dy = dx;
    [xq, yq] = meshgrid(dx, dy);
    z = -exp(-(xq.^2 + yq.^2));
    zq = griddata(dx, dy, z, xq, yq);
    size(zq)

    % create boundry mask
    % if zq(i,j) has an elevation boundary_mask(i,j) = 1
    % if zq(i,j) does not have an elevation BUT it is adjacent to a cell
    % with a defined elevation then boundary_mask(i,j) = 0
    % else zq(i,j) is nan then boundary_mask(i,j) is nan
    [m,n] = size(xq);
    bm = NaN.*ones(m, n);
    % loop through all points of boundary mask
    for i = 1:m
        for j = 1:n
            if (xq(i,j)^2 + yq(i,j)^2) < 4
                bm(i,j) = 1;
            end
        end
    end
    
    % clean up the edges
    bm(1,:) = NaN;
    bm(:,1) = NaN;
    bm(m,:) = NaN;
    bm(:,n) = NaN;
    
    % loop through all points in the boundary mask
    for i = 1:m
        for j = 1:n
            if isnan(bm(i,j))
                % check to see if a cell that can hold water is adjacent to
                % any other cells that can contain water
                try
                    if (bm(i,j+1) == 1)
                        bm(i,j) = 0;  
                    end
                catch
                    
                end

                try
                    if (bm(i,j-1) == 1)
                        bm(i,j) = 0;
                    end
                catch

                end

                try
                    if (bm(i+1,j) == 1)
                        bm(i,j) = 0;
                    end
                catch

                end

                try
                    if (bm(i-1,j) == 1)
                        bm(i,j) = 0;
                    end
                catch

                end
            end
        end
    end

    disp(bm)
    % if a cell cant hold water set its height to NaN
    z(isnan(bm)) = NaN;
    % z(bm == 0) = NaN;


    % initialize water grid post rain
    V = NaN*ones(size(z));
    

    % is the boundry mask says that cell can hold water there, put 1 water
    % there
    % V(bm==1) = 0.2;
    V(bm==1) = 0;
    % disp(V)
    V(bm==0) = 0;  

    [c,r] = coordinate_to_cell([1,1]);
    V(c,r) = 0.2;

    % disp(V)
    sum(sum(V(~isnan(V))))


   



    water_lst(:,:,1) = V;
    % initial plastic location
    coord = [1,1];
    coord_lst = NaN*ones(200,2);
    coord_lst(1,:) = coord;
    alpha = 1
    g = gradient(bm,z,V,deltaX,alpha);
    deltaT = 0.1
    figure
    surf(xq,yq,z, V)
    title({'Water Movement', '0.2 Water Placed On (1,1)'});
    subtitle('Step $0, \Delta t = 0.1, \alpha = 1$', 'Interpreter','latex')    
    shading interp
    % size(bm==1)
    % size(V)
    for a = 2:500
        % print the total
        sum(sum(V(~isnan(V))));
        % V(bm==0) = sum(sum(V(~isnan(V))))/126749;
        V = dance_round(bm,V,g, deltaT);
        % if mod(a,50) == 0
        %     water_lst(:,:,a) = V;
        % end
        % g = gradient(bm,z,V,deltaX,alpha);
        % coord = move_plastic(coord, 0.01, V, z, deltaT); 
        % coord_lst(a,:) = coord;
        % V = maybe(bm,V,g);
        % water_lst(:,:,a) = V;
        % coord = move_plastic(coord, 0.05, V, z);
        % coord_lst(a,:) = coord;
    end
    
    % figure
    % surf(z)
    % title('elevation')
    % shading interp

    figure
    surf(xq,yq,z, V)
    title({'Water Movement', '0.2 Water Placed On (1,1)'});
    subtitle('Step $450, \Delta t = 0.1, \alpha = 1$', 'Interpreter','latex')
    shading interp

    % figure
    % surf(g(:,:,1))
    % shading interp
    % 
    % figure
    % surf(V + z)
    % shading interp

    % interpolated_z = interp2(xq,yq,zq, coord_lst(:,1), coord_lst(:,2), 'linear');
    % figure
    % colormap abyss
    % surf(xq,yq,z)
    % shading interp
    % hold on
    % scatter3(coord_lst(:,1), coord_lst(:,2), interpolated_z, 50, 'filled','MarkerFaceColor',[1 1 1])
    % hold off


    
end

