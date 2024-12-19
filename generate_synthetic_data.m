% generate_synthetic_data.m
% Script to generate synthetic input-output data for the Fuzzy Logic Controller (FLC)

% Set the number of samples
numSamples = 100;

%% ------------------- Generate Inputs -------------------

% Temperature (0°C to 40°C)
temperature = randi([0, 40], numSamples, 1);

% Light Level (0 to 1000 lux)
lightLevel = randi([0, 1000], numSamples, 1);

% Motion Activity (0 = No Motion, 1 = Motion Detected)
motionActivity = randi([0, 1], numSamples, 1);

% Combine inputs into a single matrix
inputData = [temperature, lightLevel, motionActivity];

%% ------------------- Generate Outputs -------------------

% Fan Speed (0 to 100)
fanSpeed = randi([0, 100], numSamples, 1);

% Light Intensity (0 to 100)
lightIntensity = randi([0, 100], numSamples, 1);

% Blinds Position (0 = Closed, 1 = Open)
blindsPosition = randi([0, 1], numSamples, 1);

% Combine outputs into a single matrix
targetOutputs = [fanSpeed, lightIntensity, blindsPosition];

%% ------------------- Save the Data -------------------

% Save the synthetic dataset
save('synthetic_dataset.mat', 'inputData', 'targetOutputs');

% Display sample data
disp('Sample Input Data:');
disp(inputData(1:5, :));

disp('Sample Target Outputs:');
disp(targetOutputs(1:5, :));

disp('Synthetic dataset generated and saved as synthetic_dataset.mat');
