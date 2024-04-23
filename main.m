Alice = [1,11];
Alice_n = 16;
Alice_scan_region = [-90, 90];
Bob = [11, 11];
Bob_n = 16;
Bob_scan_region = [90, 270];
Eve = [4, 8];
wall_height = 0;
dB_threshold = 0;
nth_beam = 1;
randomize_beams = false;

% setup Alice and Bob
[Alice_signals, Alice_steer_angles, AtoB_beams, ...
    Bob_signals, Bob_steer_angles, BtoA_beams, ...
    ] = setup(...
    Alice, Alice_n, Alice_scan_region, ...
    Bob, Bob_n, Bob_scan_region, ...
    wall_height, randomize_beams);


% localize with Eve
[error, Bob_estimated] = localize(...
    Alice, Alice_n, Alice_signals, Alice_steer_angles, AtoB_beams, ...
    Bob, Bob_n, Bob_signals, Bob_steer_angles, BtoA_beams, ...
    Eve, ...
    dB_threshold, nth_beam);


figure;
plot_triangle(Alice, Bob, Eve, 'b');
hold on;
plot_triangle(Alice, Bob_estimated, Eve, 'r')
xlim = get(gca, 'xlim'); % Get the current x-axis limits to span the wall across
if wall_height ~= 0
    line(xlim, [wall_height, wall_height], 'Color', 'k', 'LineWidth', 2); % Black line for the wall
end
