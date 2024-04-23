function [steer_angles, signalmaps] = beamscan(n, lambda, interval, scan_region)
    if scan_region(1) == -90 && scan_region(2) == 90
        neg_angles = fliplr(-interval:-interval:-90);
        pos_angles = 0:interval:90;
    elseif scan_region(1) == 90 && scan_region(2) == 270
        neg_angles = fliplr((180 - interval):-interval:90);
        pos_angles = 180:interval:270;
    end
    steer_angles = [neg_angles, pos_angles];

    num_beams = length(steer_angles);
    num_samples = 360 * 4 + 1;
    signalmaps = zeros(num_beams, num_samples);

    for i = 1:num_beams
        steer_angle = steer_angles(i);
        signalmaps(i, :) = beamform(n, lambda, steer_angle);
    end
end

