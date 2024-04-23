function distance = euc_distance(tx, rx)
    distance = sqrt((rx(1) - tx(1))^2 + (rx(2) - tx(2))^2);
end