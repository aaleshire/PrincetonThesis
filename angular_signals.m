function signals = angular_signals(original_signals, index)
    num_beams = length(original_signals(:, 1));
    signals = zeros(1, num_beams);
    for i = 1:num_beams
        signal = original_signals(i, :);
        signals(i) = signal_tx_to_rx(signal, index);
    end
end
