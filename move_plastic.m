function new_coord = move_plastic(current_coord, dx, V, Z)
    
    x1 = current_coord(1);
    y1 = current_coord(2);
    [c,r] = coordinate_to_cell([x1,y1]);
    g_minusJ = slp([c, r-1], [c,r], dx, Z);
    g_plusJ = slp([c, r+1], [c,r], dx, Z);

    g_minusI = slp([c-1, r], [c,r], dx, Z);
    g_plusI = slp([c+1, r], [c,r], dx, Z);

    W_bar_minusJ = abs(W_bar([c, r-1], [c,r], g_minusJ, V));
    W_bar_plusJ = abs(W_bar([c, r+1], [c,r], g_plusJ, V));

    W_bar_minusI = abs(W_bar([c-1, r], [c,r], g_minusI, V));
    W_bar_plusI = abs(W_bar([c+1, r], [c,r], g_plusI, V));

    dy_denom = W_bar_minusJ + W_bar_plusJ;
    dx_denom = W_bar_minusI + W_bar_plusI;

    dydt = ((W_bar_minusJ*g_minusJ - W_bar_plusJ*g_plusJ)*dx)/dy_denom;
    dxdt = ((W_bar_minusI*g_minusI - W_bar_plusI*g_plusI)*dx)/dx_denom;

    new_coord = [x1 + dxdt, y1 + dydt];
end