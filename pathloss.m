function pathloss_signalmaps = pathloss(signalmaps, lambda, distance)
    num_beams = length(signalmaps(:, 1));
    pathloss_signalmaps = zeros(size(signalmaps));
    for i = 1:num_beams
        signalmap = signalmaps(i, :);
        pathloss_signalmaps(i, :) = signalmap * (lambda / (4 * pi * distance).^2); 
    end
end