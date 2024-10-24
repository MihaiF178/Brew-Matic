% extractTimestamps.m
% Funcție pentru extragerea timestamp-urilor din numele fișierelor

function timeVec = extractTimestamps(imageFiles)
    numImages = length(imageFiles);
    timeVec = zeros(numImages, 1);

    for i = 1:numImages
        [~, fileName, ~] = fileparts(imageFiles(i).name);
        dateTimeStr = regexprep(fileName, '\.\d+$', '');
        dateTime = datetime(dateTimeStr, 'InputFormat', 'yyyy-MM-dd_HH-mm-ss');
        if i == 1
            startTime = dateTime;
        end
        timeVec(i) = hours(dateTime - startTime); % Timp în ore de la prima imagine
    end
end
