% processImages.m
% Funcție pentru procesarea imaginilor și extragerea măsurătorilor spumei

function [foamAreaMeasurements, foamHeightMeasurements, foamDensityMeasurements] = processImages(imageFiles, imageDir)
    numImages = length(imageFiles);
    foamAreaMeasurements = zeros(numImages, 1);
    foamHeightMeasurements = zeros(numImages, 1);
    foamDensityMeasurements = zeros(numImages, 1);

    % Definirea coordonatelor chenarului albastru (ajustează în funcție de imagini)
    rect = [50, 20, 100, 50]; % Ajustare pentru a se potrivi zonei superioare

    % Raport de conversie pixeli în milimetri pentru arie (exemplu)
    pixel_to_mm = 0.1; % Înlocuiește cu raportul real de conversie pentru arie
    % Raport de conversie pixeli în milimetri pentru înălțime (exemplu)
    pixel_to_mm_height = 0.1; % Calibrat conform observațiilor tale

    for i = 1:numImages
        img = imread(fullfile(imageDir, imageFiles(i).name));
        
        % Decuparea zonei din chenarul albastru
        croppedImg = imcrop(img, rect);
        
        % Conversia la grayscale
        grayImg = rgb2gray(croppedImg);
        
        % Îmbunătățirea contrastului
        enhancedImg = imadjust(grayImg);
        
        % Filtrare pentru reducerea zgomotului
        denoisedImg = medfilt2(enhancedImg, [3 3]);
        
        % Segmentare avansată folosind thresholding adaptiv
        binaryImg = imbinarize(denoisedImg, 'adaptive', 'Sensitivity', 0.5);
        
        % Post-procesare pentru curățarea imaginii binare
        cleanedImg = imopen(binaryImg, strel('disk', 1));
        cleanedImg = imclose(cleanedImg, strel('disk', 1));
        
        % Vizualizare pentru verificare
        imshow(cleanedImg);
        title(['Processed Image ' num2str(i)]);
        pause(1); % Pauză pentru a vizualiza fiecare imagine procesată
        
        % Calcularea ariei spumei
        foamArea = sum(cleanedImg(:)) * (pixel_to_mm^2); % Conversie la mm^2
        foamAreaMeasurements(i) = foamArea;
        
        % Calcularea înălțimii maxime a spumei
        [rows, ~] = find(cleanedImg);
        if ~isempty(rows)
            foamHeight = (max(rows) - min(rows)) * pixel_to_mm_height; % Conversie la mm
        else
            foamHeight = 0;
        end
        foamHeightMeasurements(i) = foamHeight;
        
        % Calcularea densității spumei (numărul de bule)
        bubbles = bwconncomp(cleanedImg);
        foamDensity = bubbles.NumObjects; % Numărul de bule rămâne același
        foamDensityMeasurements(i) = foamDensity;
    end
end
