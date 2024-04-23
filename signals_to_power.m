function powers = signals_to_power(signals)
    powers = zeros(size(signals));
    num_beams = length(signals);
    for i = 1:num_beams
        signal = signals(i);
        powers(i) = 10*log10(abs(signal).^2);
    end
end

