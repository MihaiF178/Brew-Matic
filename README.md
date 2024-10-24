
 Brew-Matic: Foam Analysis Tools

 Project Overview

This project contains a set of MATLAB scripts designed for the analysis of foam evolution during beer fermentation. The scripts can process images of foam, extract timestamps from the filenames, and visualize the foam's evolution in terms of area, height, and density over time. 

 Included Scripts

1. processImages.m
   - Purpose: Processes a set of images to measure the foam's area, height, and density.
   - Inputs: A list of image files and their directory.
   - Outputs:
     - Foam Area Measurements (`foamAreaMeasurements`) in mm².
     - Foam Height Measurements (`foamHeightMeasurements`) in mm.
     - Foam Density Measurements (`foamDensityMeasurements`) (number of bubbles).
   - Processing steps:
     - Crops the specified region of interest.
     - Converts the image to grayscale, enhances contrast, and denoises.
     - Performs advanced segmentation using adaptive thresholding.
     - Calculates foam area, height, and density based on processed binary images.
   - Debug Features: Each processed image is displayed during execution for verification purposes.

2. visualizeFoamEvolution.m
   - Purpose: Plots the foam area, height, and density measurements over time to visualize the foam's evolution.
   - Inputs: 
     - Time vector (`timeVec`),
     - Foam Area Measurements (`foamAreaMeasurements`),
     - Foam Height Measurements (`foamHeightMeasurements`),
     - Foam Density Measurements (`foamDensityMeasurements`).
   - Output: A figure with three subplots showing the foam’s evolution over time.
   - Usage: Helps to analyze and visually interpret the data obtained from the `processImages.m` script.

3. extractTimestamps.m
   - Purpose: Extracts timestamps from image filenames to create a time vector.
   - Inputs: A list of image files with names formatted as `yyyy-MM-dd_HH-mm-ss`.
   - Output: A time vector in hours, with the first image's timestamp as the starting point.
   - Usage: Generates a time vector for use in visualizing foam evolution.

 Installation and Usage

 Requirements

To use these scripts, you must have MATLAB installed on your system. Ensure that the Image Processing Toolbox is available for image segmentation and analysis.

 Instructions

1. Place your image files in a designated directory.
2. Ensure that the filenames follow the format: `yyyy-MM-dd_HH-mm-ss.extension`.
3. Call `processImages.m` to process the images and extract foam measurements:
   ```matlab
   [foamArea, foamHeight, foamDensity] = processImages(imageFiles, imageDir);
   ```
4. Use `extractTimestamps.m` to generate the time vector:
   ```matlab
   timeVec = extractTimestamps(imageFiles);
   ```
5. Visualize the evolution of foam with `visualizeFoamEvolution.m`:
   ```matlab
   visualizeFoamEvolution(timeVec, foamArea, foamHeight, foamDensity);
   ```

 Example

```matlab
% Example usage of all scripts
imageDir = 'C:/path/to/images';
imageFiles = dir(fullfile(imageDir, '*.png'));

% Process images
[foamArea, foamHeight, foamDensity] = processImages(imageFiles, imageDir);

% Extract timestamps
timeVec = extractTimestamps(imageFiles);

% Visualize results
visualizeFoamEvolution(timeVec, foamArea, foamHeight, foamDensity);
```

 Intellectual Property and Protection

The content of this repository and the scripts provided are part of the Brew-Matic project and are protected by intellectual property laws. Reuse, modification, or redistribution of these scripts or any part of this project requires explicit permission from the Brew-Matic project team. If you wish to contribute or use any part of this project, please contact the Brew-Matic team.
