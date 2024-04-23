function signals = rx_signals(tx, rx, lambda, signalmaps)
    distance = euc_distance(tx, rx);
    signalmaps = pathloss(signalmaps, lambda, distance);
    theta = angle_tx_to_rx(tx, rx);
    if theta < 0
        theta = theta + 360;
    end
    index = round(theta * 4 + 1); % because 0.25 degree interval
    signals = angular_signals(signalmaps, index);
end
