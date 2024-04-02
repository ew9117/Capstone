function clinton_elevation()
    clinton = readtable('clinton_elevation.csv');
    %dx = min(clinton.X):0.5:max(clinton.X);
    %dy = min(clinton.Y):0.5:max(clinton.Y);
    dx = linspace(min(clinton.X), max(clinton.X));
    dy = linspace(min(clinton.Y), max(clinton.Y));

    [xq, yq] = meshgrid(dx, dy, 0);
    %scatter3(clinton.X, clinton.Y, clinton.Z)
    vq = griddata(clinton.X, clinton.Y, clinton.Z, xq, yq);


    % loop through points and remove some based on slope
    % might want to check to see if the slop continues to be steep
    % for i = 2:100
    %     for j = 2:100
    % 
    %         if abs((vq(i,j) - vq(i,j-1))./(yq(j) - yq(j-1))) > 0.75
    %             vq(i,j) = NaN;
    %         end
    %         if abs((vq(i,j) - vq(i - 1,j))/(yq(i) - yq(i - 1))) > 0.75
    %             vq(i,j) = NaN;
    %         end
    % 
    %     end
    % end
    % for i = 1:100
    %     for j = 1:100
    %         if vq(i,j) > 151
    %             vq(i,j) = NaN;
    %         end
    %     end
    % end
    figure;
    waterfall(xq,yq,vq)
end

