function [c,r] = coordinate_to_cell(coordinate)
    x = round(coordinate(1),1);
    y = round(coordinate(2),1);
    % round to the nearest defined (x,y) pair
    c = abs((-5 - x)/0.05);
    r = abs((-5 - y)/0.05);
end