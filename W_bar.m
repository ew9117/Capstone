function solbar = W_bar(coord1, coord2, g, V)
    x1 = coord1(1);
    y1 = coord1(2);
    x2 = coord2(1);
    y2 = coord2(2);
    
    % g^{x1,y1}_{x2,y2} - water flows from cell (x1,y1) to cell (x2,y2)

    if g < 0
        solbar = g*V(round(x2),round(y2));
    elseif g > 0
        solbar = g*V(round(x1),round(y1));
    elseif g == 0
        solbar = 0;
    end
    % W bar is the rate of change of the height of water in cell (i,j) from
    % (k,l)
end