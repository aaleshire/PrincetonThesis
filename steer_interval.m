function theta = steer_interval(n)
    num_beams = min(80, n * 5);
    theta = 180/num_beams;
end
