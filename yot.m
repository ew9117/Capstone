function yot()
% this function will initialize all the maps and variables needed for thie
% clinton elevation dataset
    
    dx = -5:0.05:5;
    dy = dx;

    
    [xq, yq] = meshgrid(dx, dy);
    z = -exp(-(xq.^2 + yq.^2));
    % zq = griddata(dx, dy, z, xq, yq);


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
    
    % if a cell cant hold water set its height to NaN
    z(isnan(bm)) = NaN;
    z(bm == 0) = NaN;


    % initialize water grid post rain
    vq = NaN*ones(size(z));
    

    % is the boundry mask says that cell can hold water there, put 1 water
    % there
    vq(bm==1) = 1;
    % vq(bm==0) = 0;

    % vq(40,40)
    % figure
    % surf(z,vq)
    % figure
    % surf(vq)

    % initialize water grid post water movement
    wq = 0*ones(m,n);
    wq(1,:) = NaN;
    wq(:,1) = NaN;
    wq(m,:) = NaN;
    wq(:,n) = NaN;
   
    % pq = 0*ones(m,n);
    % p2q = 0*ones(m,n);
    % p2q(40,40) = 1;
    g = gradient(bm,z);
    % figure
    % surf(xq, yq, g(:,:,2));
    % g = g./3.287;
    for a = 1:2
        % print the total
        sum(sum(vq(~isnan(vq))))
        vq = dance_round(wq, bm, vq, g);
    end
    figure
    surf(z,vq)
    shading interp
    figure
    surf(vq)
    % shading interp
    figure 
    surf(bm)
    % figure;
    % surf(xq,yq,vq);
    % figure;
    % surf(xq,yq,z)


    
end

