% if wall_height = 0, then only doing LOS

function [Alice_signals, Alice_steer_angles, Bob_from_Alice_powers, ...
    Bob_signals, Bob_steer_angles, BtoA_beams] = setup(...
        Alice, Alice_n, Alice_scan_region, ...
        Bob, Bob_n, Bob_scan_region, ...
        wall_height, randomize_beams)

    % Constant
    lambda = 0.00495689; % Wavelength: 60.48 GHz

    %%%%%%%%%%%%%%%%%
    % 1. Alice = Tx %
    %%%%%%%%%%%%%%%%%
    Alice_interval = steer_interval(Alice_n);
    [Alice_steer_angles, Alice_signals] = beamscan(Alice_n, lambda, Alice_interval, Alice_scan_region);
    
    % Randomize Alice Beam IDs %
    if randomize_beams
        Alice_new_beam_ids = randperm(size(Alice_signals, 1));
        Alice_signals = Alice_signals(Alice_new_beam_ids, :);
    end

    % 1a. Bob = Rx (LOS + NLOS)
    Bob_los_signals = rx_signals(Alice, Bob, lambda, Alice_signals);
    
    if wall_height ~= 0
        Bob_virtual = virtual(Bob, wall_height);
        Bob_nlos_signals = rx_signals(Alice, Bob_virtual, lambda, Alice_signals);
        Bob_delta_distance = euc_distance(Alice, Bob_virtual) - euc_distance(Alice, Bob);
        Bob_nlos_phase = calculate_phase_shift(Bob_delta_distance, lambda);
        Bob_from_Alice_signals = combined_signals(Bob_los_signals, Bob_nlos_signals, Bob_nlos_phase);
        Bob_from_Alice_powers = signals_to_power(Bob_from_Alice_signals);
    else
        Bob_from_Alice_signals = Bob_los_signals;
        Bob_from_Alice_powers = signals_to_power(Bob_from_Alice_signals);
    end


    %%%%%%%%%%%%%%%
    % 2. Bob = Tx %
    %%%%%%%%%%%%%%%
    Bob_interval = steer_interval(Bob_n);
    [Bob_steer_angles, Bob_signals] = beamscan(Bob_n, lambda, Bob_interval, Bob_scan_region);
    
    % 2a. Alice = Rx
    Alice_from_Bob_signals = rx_signals(Bob, Alice, lambda, Bob_signals);
    Alice_from_Bob_powers = signals_to_power(Alice_from_Bob_signals);
    
    % Beams
    BtoA_beams = rank_beams(Bob_steer_angles, Alice_from_Bob_powers);
end