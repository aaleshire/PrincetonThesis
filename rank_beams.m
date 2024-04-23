function ranked_beams = rank_beams(angles, powers)
    [beam_powers, beam_indices] = maxk(powers, length(powers));
    beam_angles = angles(beam_indices);
    ranked_beams = [beam_indices', beam_powers', beam_angles'];
end
