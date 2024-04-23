function theta = angle_tx_to_rx(tx, rx)
    theta = atan2d(rx(2) - tx(2), rx(1) - tx(1));
end

