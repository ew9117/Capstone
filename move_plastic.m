function new_coord = move_plastic(current_coord, deltaX, V, Z, deltaT)
    
    [m,n] = size(current_coord);
    new_coord = zeros(m,n);
    for i=1:n/2
        x1 = current_coord(1,2*(i-1)+1);
        y1 = current_coord(1,2*(i-1)+2);
        [c,r] = coordinate_to_cell([x1,y1]);
        g_minusJ = slp([c, r-1], [c,r], deltaX, Z);
        g_plusJ = slp([c, r+1], [c,r], deltaX, Z);

        g_minusI = slp([c-1, r], [c,r], deltaX, Z);
        g_plusI = slp([c+1, r], [c,r], deltaX, Z);

        W_bar_minusJ = abs(W_bar([c, r-1], [c,r], g_minusJ, V));
        W_bar_plusJ = abs(W_bar([c, r+1], [c,r], g_plusJ, V));

        W_bar_minusI = abs(W_bar([c-1, r], [c,r], g_minusI, V));
        W_bar_plusI = abs(W_bar([c+1, r], [c,r], g_plusI, V));

        dy_denom = W_bar_minusJ + W_bar_plusJ;
        deltaX_denom = W_bar_minusI + W_bar_plusI;

        dydt = ((W_bar_minusJ*g_minusJ - W_bar_plusJ*g_plusJ)*deltaX)/dy_denom;
        deltaXdt = ((W_bar_minusI*g_minusI - W_bar_plusI*g_plusI)*deltaX)/deltaX_denom;

        new_coord(1,2*(i-1)+1) = x1 + deltaT*deltaXdt;
        new_coord(1,2*(i-1)+2) = y1 + deltaT*dydt;
    end
end