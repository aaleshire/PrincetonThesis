function lineHandle = plot_triangle(A, B, C, color)
    % Plot the triangle
    lineHandle = plot([A(1), B(1), C(1), A(1)], [A(2), B(2), C(2), A(2)], '-o', 'Color', color);
    grid on;
    hold on;

    % Compute side lengths
    a = sqrt((B(1)-C(1))^2 + (B(2)-C(2))^2); % Length opposite to A
    b = sqrt((A(1)-C(1))^2 + (A(2)-C(2))^2); % Length opposite to B
    c = sqrt((A(1)-B(1))^2 + (A(2)-B(2))^2); % Length opposite to C

    % Calculate angles using the law of cosines
    angleA = rad2deg(acos((b^2 + c^2 - a^2)/(2*b*c)));
    angleB = rad2deg(acos((a^2 + c^2 - b^2)/(2*a*c)));
    angleC = rad2deg(acos((a^2 + b^2 - c^2)/(2*a*b)));

    % Annotate angles on the plot
    if color == 'r'
        offset = -0.5;
    else
        offset = 0.5;
    end
    text(A(1)-offset, A(2)-offset, sprintf('%.2f^o', angleA), 'FontSize', 10, 'Color', color);
    text(B(1)+offset, B(2)+offset, sprintf('%.2f^o', angleB), 'FontSize', 10, 'Color', color);
    text(C(1)+offset, C(2)-offset, sprintf('%.2f^o', angleC), 'FontSize', 10, 'Color', color);

    % Annotate side lengths on the plot
    text((A(1)+B(1))/2, (A(2)+B(2))/2, sprintf('%.2f', c), 'FontSize', 10, 'Color', color);
    text((A(1)+C(1))/2, (A(2)+C(2))/2, sprintf('%.2f', b), 'FontSize', 10, 'Color', color);
    text((B(1)+C(1))/2, (B(2)+C(2))/2, sprintf('%.2f', a), 'FontSize', 10, 'Color', color);

    hold on;
    title('Calculated vs Real Triangle');
    xlabel('x');
    ylabel('y');
    axis equal;
end