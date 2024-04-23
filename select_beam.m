function [best_power, best_beam, beam_angle] = select_beam(angles, powers)
    [best_power, best_beam] = max(powers);
    beam_angle = angles(best_beam);
end
