function [error, Bob_estimated] = localize(...
    Alice, Alice_n, Alice_signals, Alice_steer_angles, AtoB_beams, ...
    Bob, Bob_n, Bob_signals, Bob_steer_angles, BtoA_beams, ...
    Mal, ...
    dB_threshold, nth_beam)
   
    Bob_estimated = [-1, -1];

    % Mal Power Profiles
    [Mal_from_Alice_powers, Mal_from_Bob_powers] = mal_power_profiles(Alice, Alice_signals, Bob, Bob_signals, Mal);

    % Get all best beams
    if nth_beam == 1
        [AtoB_power, AtoB_beam] = max(AtoB_beams);
    else
        localmax_logic = islocalmax(AtoB_beams);
        localmax_powers = AtoB_beams(localmax_logic);
        sortedValues = sort(localmax_powers, 'descend'); % Sort in descending order
        AtoB_power = sortedValues(nth_beam); % The second highest value
        AtoB_beam = find(AtoB_beams == AtoB_power, 1, 'first');

        if AtoB_power < mean(AtoB_beams) + 5
            error = -3;
            return;
        end
    end

    BtoA_beam = BtoA_beams(1, 1);

    AtoM_beams = rank_beams(Alice_steer_angles, Mal_from_Alice_powers);
    AtoM_beam = AtoM_beams(1, 1);

    BtoM_beams = rank_beams(Bob_steer_angles, Mal_from_Bob_powers);
    BtoM_beam = BtoM_beams(1, 1);


    % Overhear
    AtoM_eavesdrop_power = Mal_from_Alice_powers(AtoB_beam);
    
    if dB_threshold ~= 0 && AtoB_power - AtoM_eavesdrop_power > dB_threshold
        error = -2;
        return;
    end
    
    % Triangulate
    Alice_interval = steer_interval(Alice_n);
    Bob_interval = steer_interval(Bob_n);

    Alice_interior_angle = Alice_interval * abs(AtoB_beam - AtoM_beam);
    Bob_interior_angle = Bob_interval * abs(BtoA_beam - BtoM_beam);
    Mal_interior_angle = 180 - Alice_interior_angle - Bob_interior_angle;

    if Alice_interior_angle <= 0 || Bob_interior_angle <= 0 || Mal_interior_angle <= 0
        error = -1;
        return;
    end
    
    % FINAL ANSWERS
    Bob_estimated = triangulate(Alice, Mal, Alice_interior_angle, Mal_interior_angle, AtoB_beam, AtoM_beam);
    error = sqrt((Bob_estimated(1) - Bob(1))^2 + (Bob_estimated(2) - Bob(2))^2);
end
