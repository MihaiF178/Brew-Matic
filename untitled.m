% Script actualizat pentru analiza fermentației berii (gestionare fișiere neconforme)

% Definirea variabilelor
pixel_to_mm = 0.1; % Exemplu: 1 pixel = 0.1 mm

% Calea către directorul cu imaginile
image_directory = 'C:\Users\OK\OneDrive\Desktop\experiment';

% Obținerea listei de fișiere de imagine PNG
image_files = dir(fullfile(image_directory, '*.png'));
num_images = length(image_files);

% Inițializarea vectorilor pentru măsurători
foam_area = [];
foam_height = [];
foam_density = [];
foam_texture = [];
time_vector = [];

valid_image_count = 0;

for i = 1:num_images
    % Extragerea datei și orei din numele fișierului
    [~, file_name, ~] = fileparts(image_files(i).name);
    
    % Verifică dacă numele fișierului se potrivește cu formatul așteptat
    if ~isempty(regexp(file_name, '^\d{4}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}', 'once'))
        % Eliminarea milisecundelor și conversia la datetime
        date_time_str = regexprep(file_name, '\.\d+$', '');
        date_time = datetime(date_time_str, 'InputFormat', 'yyyy-MM-dd_HH-mm-ss');
        
        valid_image_count = valid_image_count + 1;
        
        if valid_image_count == 1
            start_time = date_time;
        end
        time_vector(valid_image_count) = hours(date_time - start_time); % Timp în ore de la prima imagine
        
        % Citirea imaginii
        img = imread(fullfile(image_directory, image_files(i).name));
        
        % Conversia în grayscale dacă imaginea este RGB
        if size(img, 3) == 3
            gray_img = rgb2gray(img);
        else
            gray_img = img;
        end
        
        % Binarizarea imaginii pentru a izola spuma
        binary_img = imbinarize(gray_img, 'adaptive', 'Sensitivity', 0.6);
        
        % Calcularea ariei spumei
        foam_area(valid_image_count) = sum(binary_img(:)) * pixel_to_mm^2;
        
        % Calcularea înălțimii spumei
        [rows, ~] = find(binary_img);
        if ~isempty(rows)
            foam_height(valid_image_count) = (max(rows) - min(rows)) * pixel_to_mm;
        else
            foam_height(valid_image_count) = 0;
        end
        
        % Estimarea densității spumei
        foam_density(valid_image_count) = sum(binary_img(:)) / numel(binary_img);
        
        % Estimarea texturii spumei (folosind deviația standard a intensității în zona spumei)
        foam_mask = binary_img .* double(gray_img);
        foam_texture(valid_image_count) = std(foam_mask(foam_mask > 0));
    else
        warning('Fișierul %s nu are un nume valid și va fi ignorat.', file_name);
    end
end

% Verifică dacă au fost găsite imagini valide
if valid_image_count == 0
    error('Nu au fost găsite imagini valide în directorul specificat.');
end

% Sortarea datelor în funcție de timp
[time_vector, sort_idx] = sort(time_vector);
foam_area = foam_area(sort_idx);
foam_height = foam_height(sort_idx);
foam_density = foam_density(sort_idx);
foam_texture = foam_texture(sort_idx);

% Vizualizarea rezultatelor
figure('Position', [100, 100, 1200, 800]);

% Plotarea ariei spumei
subplot(2,2,1);
plot(time_vector, foam_area, 'b-', 'LineWidth', 2);
xlabel('Timp (ore)');
ylabel('Aria spumei (mm^2)');
title('Evoluția ariei spumei');
grid on;

% Plotarea înălțimii spumei
subplot(2,2,2);
plot(time_vector, foam_height, 'r-', 'LineWidth', 2);
xlabel('Timp (ore)');
ylabel('Înălțimea spumei (mm)');
title('Evoluția înălțimii spumei');
grid on;

% Plotarea densității spumei
subplot(2,2,3);
plot(time_vector, foam_density, 'g-', 'LineWidth', 2);
xlabel('Timp (ore)');
ylabel('Densitatea spumei (unități arbitrare)');
title('Evoluția densității spumei');
grid on;

% Plotarea texturii spumei
subplot(2,2,4);
plot(time_vector, foam_texture, 'm-', 'LineWidth', 2);
xlabel('Timp (ore)');
ylabel('Textura spumei (deviație standard)');
title('Evoluția texturii spumei');
grid on;

% Adăugarea unui titlu general
sgtitle('Analiza fermentației berii - Caracteristicile spumei', 'FontSize', 16);

% Salvarea figurii
saveas(gcf, fullfile(image_directory, 'rezultate_fermentatie.png'));

fprintf('Analiză completă. Au fost procesate %d imagini valide.\n', valid_image_count);