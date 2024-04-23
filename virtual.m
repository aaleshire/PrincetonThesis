function virtual_loc = virtual(loc, wall_height) % only for horizontal wall above 
    y_diff = wall_height - loc(2);
    new_y = wall_height + y_diff;
    virtual_loc = [loc(1), new_y];
end
