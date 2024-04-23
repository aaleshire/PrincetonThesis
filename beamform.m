function map = beamform(n, lambda, steer_angle)
    spacing = 0.002415; % Antenna Spacing

    % Desired phase profile
    desiredGradient = sind(steer_angle) * spacing * 2 * pi / lambda;
    desiredPhase = 0:n-1; 
    desiredPhase = desiredPhase * desiredGradient; 
    desiredPhase = mod(desiredPhase, 2*pi); % Phase map wanted
    
    psi = 0:0.25:360; % 0.25 degree interval covering 360 degrees
    map = zeros(size(psi));

    for i = 1:length(psi)
        ang = psi(i);
        dis = -1 * sind(ang) * spacing;
        phase = (2*pi/lambda) * dis;
        for j = 1:n
            map(i) = map(i) + exp(1i * ((j-1) * phase + desiredPhase(j)));
        end
    end
end

