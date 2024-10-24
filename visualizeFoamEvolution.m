% visualizeFoamEvolution.m
% Funcție pentru vizualizarea evoluției spumei

function visualizeFoamEvolution(timeVec, foamAreaMeasurements, foamHeightMeasurements, foamDensityMeasurements)
    figure('Position', [100, 100, 1200, 800]);

    subplot(3, 1, 1);
    plot(timeVec, foamAreaMeasurements, '-o', 'Color', 'b');
    xlabel('Timp (ore)');
    ylabel('Suprafața spumei (mm^2)');
    title('Evoluția suprafeței spumei');
    grid on;

    subplot(3, 1, 2);
    plot(timeVec, foamHeightMeasurements, '-o', 'Color', 'r');
    xlabel('Timp (ore)');
    ylabel('Înălțimea spumei (mm)');
    title('Evoluția înălțimii spumei');
    grid on;

    subplot(3, 1, 3);
    plot(timeVec, foamDensityMeasurements, '-o', 'Color', 'g');
    xlabel('Timp (ore)');
    ylabel('Densitatea spumei (numărul de bule)');
    title('Evoluția densității spumei');
    grid on;

    sgtitle('Evoluția spumei în timpul fermentației alcoolice a berii');
end
