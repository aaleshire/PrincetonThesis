function [Mal_from_Alice_powers, Mal_from_Bob_powers] = mal_power_profiles(...
    Alice, Alice_signals, Bob, Bob_signals, Mal)
        
    % Constant
    lambda = 0.00495689; % Wavelength: 60.48 GHz
   

    %%%%%%%%%%%%%%%%%
    % 1. Alice = Tx %
    %%%%%%%%%%%%%%%%%

    % Mal = Rx
    Mal_from_Alice_signals = rx_signals(Alice, Mal, lambda, Alice_signals);
    Mal_from_Alice_powers = signals_to_power(Mal_from_Alice_signals);
    
    
    %%%%%%%%%%%%%%%
    % 2. Bob = Tx %
    %%%%%%%%%%%%%%%

    % Mal = Rx
    Mal_from_Bob_signals = rx_signals(Bob, Mal, lambda, Bob_signals);
    Mal_from_Bob_powers = signals_to_power(Mal_from_Bob_signals);
    
end