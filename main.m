% main_script.m
% Script principal pentru analiza și vizualizarea spumei în timpul fermentației alcoolice a berii

% Directorul în care se află imaginile
imageDir = 'C:\Users\paul\OneDrive\Desktop\imagini_procesate'; % Înlocuiește cu calea reală

% Verifică dacă există imagini în director
imageFiles = dir(fullfile(imageDir, '*.png'));
if isempty(imageFiles)
    error('Nu s-au găsit imagini în directorul specificat.');
end

% Extrage timestamp-urile din numele fișierelor și timpul în ore de la prima imagine
timeVec = extractTimestamps(imageFiles);

% Procesează imaginile pentru a extrage măsurătorile spumei
[foamAreaMeasurements, foamHeightMeasurements, foamDensityMeasurements] = processImages(imageFiles, imageDir);

% Vizualizează evoluția spumei
visualizeFoamEvolution(timeVec, foamAreaMeasurements, foamHeightMeasurements, foamDensityMeasurements);

disp('Analiza și vizualizarea au fost finalizate.');
