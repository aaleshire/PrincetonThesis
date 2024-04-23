function signals = combined_signals(los_signals, nlos_signals, nlos_phase)
    num_beams = length(los_signals);
    signals = zeros(size(los_signals));
    for i = 1:num_beams
        los_signal = los_signals(i);
        nlos_signal = nlos_signals(i);
        signals(i) = los_signal + nlos_signal * exp(1i * nlos_phase);
    end
end
