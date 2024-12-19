% generate_visualizations.m
% This script generates and saves various visualizations for the SmartHomeControl.fis system

% Load the FIS
fis = readfis('SmartHomeControl.fis');

% Create a folder to save the visualizations
outputFolder = 'visualizations';
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%% 1. Plot Membership Functions for Inputs

% Plot Temperature Membership Functions
figure;
plotmf(fis, 'input', 1);
title('Temperature Membership Functions');
saveas(gcf, fullfile(outputFolder, 'Temperature_MF.png'));

% Plot Light Level Membership Functions
figure;
plotmf(fis, 'input', 2);
title('Light Level Membership Functions');
saveas(gcf, fullfile(outputFolder, 'LightLevel_MF.png'));

% Plot Motion Activity Membership Functions
figure;
plotmf(fis, 'input', 3);
title('Motion Activity Membership Functions');
saveas(gcf, fullfile(outputFolder, 'MotionActivity_MF.png'));

%% 2. Plot Membership Functions for Outputs

% Plot Fan Speed Membership Functions
figure;
plotmf(fis, 'output', 1);
title('Fan Speed Membership Functions');
saveas(gcf, fullfile(outputFolder, 'FanSpeed_MF.png'));

% Plot Light Intensity Membership Functions
figure;
plotmf(fis, 'output', 2);
title('Light Intensity Membership Functions');
saveas(gcf, fullfile(outputFolder, 'LightIntensity_MF.png'));

% Plot Blinds Position Membership Functions
figure;
plotmf(fis, 'output', 3);
title('Blinds Position Membership Functions');
saveas(gcf, fullfile(outputFolder, 'BlindsPosition_MF.png'));

%% 3. Generate Surface Plots

% Fan Speed as a function of Temperature and Motion Activity
figure;
gensurf(fis, [1, 3], 1);  % Inputs: 1 (Temperature), 3 (MotionActivity); Output: 1 (FanSpeed)
title('Fan Speed Surface Plot (Temperature vs Motion Activity)');
xlabel('Temperature (°C)');
ylabel('Motion Activity');
zlabel('Fan Speed');
saveas(gcf, fullfile(outputFolder, 'FanSpeed_Surface.png'));

% Light Intensity as a function of Light Level and Motion Activity
figure;
gensurf(fis, [2, 3], 2);  % Inputs: 2 (LightLevel), 3 (MotionActivity); Output: 2 (LightIntensity)
title('Light Intensity Surface Plot (Light Level vs Motion Activity)');
xlabel('Light Level (lux)');
ylabel('Motion Activity');
zlabel('Light Intensity');
saveas(gcf, fullfile(outputFolder, 'LightIntensity_Surface.png'));

% Blinds Position as a function of Light Level and Temperature
figure;
gensurf(fis, [2, 1], 3);  % Inputs: 2 (LightLevel), 1 (Temperature); Output: 3 (BlindsPosition)
title('Blinds Position Surface Plot (Light Level vs Temperature)');
xlabel('Light Level (lux)');
ylabel('Temperature (°C)');
zlabel('Blinds Position');
saveas(gcf, fullfile(outputFolder, 'BlindsPosition_Surface.png'));

%% 4. Open Rule Viewer

% Display the Rule Viewer
ruleview(fis);
disp('Rule Viewer opened. You can manually export visuals from this window.');

%% Completion Message

disp(['All visualizations have been saved in the folder: ', fullfile(pwd, outputFolder)]);
