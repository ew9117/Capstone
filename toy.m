function toy()
% this function will initialize all the maps and variables needed for thie
% clinton elevation dataset
    
    dx = -5:0.1:5;
    dy = dx;

    
    [xq, yq] = meshgrid(dx, dy);
    z = -exp(-(xq.^2 + yq.^2));
    zq = griddata(dx, dy, z, xq, yq);


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
    % bm


    for i = 2:(m-1)
        for j = 2:(n-1)
            if isnan(bm(i,j))
                
                if (bm(i,j+1) == 1)
                    bm(i,j) = 0;
                elseif (bm(i,j-1) == 1)
                    bm(i,j) = 0;
                elseif (bm(i+1,j) == 1)
                    bm(i,j) = 0;
                elseif (bm(i-1,j) == 1)
                    bm(i,j) = 0;
                end
            end

        end
    end

    z(isnan(bm)) = NaN;


    % initialize water grid post rain
    vq = NaN*ones(m,n);

    % is the boundry mask says that cell can hold water there, put 1 water
    % there
    vq(bm == 1) = 1;

    % initialize water grid post water movement
    wq = 0*ones(m,n);

    g = gradiant(bm,z);
    for i = 1:10
        vq = dance_round(wq, bm,vq,g);
    end
    s = surf(xq,yq,z);
    s.CData = vq;
    s
end

