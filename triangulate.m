function Bob_estimated = triangulate(Alice, Eve, Alice_interior_angle, Eve_interior_angle, Alice_to_Bob_beam, Alice_to_Eve_beam)
    % Calculate angles for line segment between ap and mal
    dx = Eve(1) - Alice(1);
    dy = Eve(2) - Alice(2);
    Alice_to_Eve_angle = atan2(dy, dx);
    Eve_to_Alice_angle = atan2(-dy, -dx);


    if Alice_to_Bob_beam > Alice_to_Eve_beam
        Alice_to_Bob_angle = Alice_to_Eve_angle + deg2rad(Alice_interior_angle);
        Eve_to_Bob_angle = Eve_to_Alice_angle - deg2rad(Eve_interior_angle);
    else
        Alice_to_Bob_angle = Alice_to_Eve_angle - deg2rad(Alice_interior_angle);
        Eve_to_Bob_angle = Eve_to_Alice_angle + deg2rad(Eve_interior_angle);
    end

    Alice_to_Bob_slope = tan(Alice_to_Bob_angle);
    Eve_to_Bob_slope = tan(Eve_to_Bob_angle);
    
    % Convert to y = mx + b format
    Alice_b = Alice(2) - Alice_to_Bob_slope * Alice(1);
    Eve_b = Eve(2) - Eve_to_Bob_slope * Eve(1);
    
    syms x y;
    eq1 = y == Alice_to_Bob_slope * x + Alice_b;
    eq2 = y == Eve_to_Bob_slope * x + Eve_b;
    sol = solve([eq1, eq2], [x, y]);
    
    Bob_estimated = [double(sol.x), double(sol.y)];
end
