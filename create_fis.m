% create_fis.m
% Create a Fuzzy Inference System (FIS) with 3 inputs and 3 outputs

% Create a new Mamdani FIS
fis = mamfis('Name', 'SmartHomeControl');

%% ------------------- Inputs -------------------

% Add Temperature Input (0 to 40°C)
fis = addInput(fis, [0 40], 'Name', 'Temperature');
fis = addMF(fis, 'Temperature', 'trimf', [0 0 15], 'Name', 'Low');
fis = addMF(fis, 'Temperature', 'trimf', [10 20 30], 'Name', 'Medium');
fis = addMF(fis, 'Temperature', 'trimf', [25 40 40], 'Name', 'High');

% Add Light Level Input (40 to 1000 lux)
fis = addInput(fis, [40 1000], 'Name', 'LightLevel');
fis = addMF(fis, 'LightLevel', 'trimf', [40 40 300], 'Name', 'Dark');
fis = addMF(fis, 'LightLevel', 'trimf', [200 500 800], 'Name', 'Normal');
fis = addMF(fis, 'LightLevel', 'trimf', [700 1000 1000], 'Name', 'Bright');

% Add Motion Activity Input (0 = No Motion, 1 = Motion Detected)
fis = addInput(fis, [0 1], 'Name', 'MotionActivity');
fis = addMF(fis, 'MotionActivity', 'trimf', [-0.1 0 0.1], 'Name', 'NoMotion');
fis = addMF(fis, 'MotionActivity', 'trimf', [0.9 1 1.1], 'Name', 'Motion');

%% ------------------- Outputs -------------------

% Add Fan Speed Output (0 to 100)
fis = addOutput(fis, [0 100], 'Name', 'FanSpeed');
fis = addMF(fis, 'FanSpeed', 'trimf', [0 0 50], 'Name', 'Low');
fis = addMF(fis, 'FanSpeed', 'trimf', [25 50 75], 'Name', 'Medium');
fis = addMF(fis, 'FanSpeed', 'trimf', [50 100 100], 'Name', 'High');

% Add Light Intensity Output (0 to 100)
fis = addOutput(fis, [0 100], 'Name', 'LightIntensity');
fis = addMF(fis, 'LightIntensity', 'trimf', [0 0 40], 'Name', 'Dim');
fis = addMF(fis, 'LightIntensity', 'trimf', [30 50 70], 'Name', 'Medium');
fis = addMF(fis, 'LightIntensity', 'trimf', [60 100 100], 'Name', 'Bright');

% Add Blinds Position Output (0 = Closed, 1 = Open)
fis = addOutput(fis, [0 1], 'Name', 'BlindsPosition');
fis = addMF(fis, 'BlindsPosition', 'trimf', [-0.1 0 0.1], 'Name', 'Closed');
fis = addMF(fis, 'BlindsPosition', 'trimf', [0.9 1 1.1], 'Name', 'Open');

%% ------------------- Rules -------------------

ruleList = [
    % Fan Speed Control
    "If Temperature is High and MotionActivity is Motion then FanSpeed is High"
    "If Temperature is Medium and MotionActivity is Motion then FanSpeed is Medium"
    "If Temperature is Low then FanSpeed is Low"
    "If Temperature is High and MotionActivity is NoMotion then FanSpeed is Medium"
    "If Temperature is Medium and MotionActivity is NoMotion then FanSpeed is Low"
    "If Temperature is Low and MotionActivity is Motion then FanSpeed is Medium"

    % Light Intensity Control
    "If LightLevel is Dark and MotionActivity is Motion then LightIntensity is Bright"
    "If LightLevel is Normal then LightIntensity is Medium"
    "If LightLevel is Bright then LightIntensity is Dim"
    "If LightLevel is Dark and MotionActivity is NoMotion then LightIntensity is Dim"
    "If LightLevel is Normal and MotionActivity is NoMotion then LightIntensity is Medium"
    "If LightLevel is Bright and MotionActivity is Motion then LightIntensity is Medium"

    % Blinds Position Control
    "If LightLevel is Bright then BlindsPosition is Closed"
    "If LightLevel is Dark then BlindsPosition is Open"
    "If LightLevel is Normal and MotionActivity is Motion then BlindsPosition is Open"
    "If LightLevel is Normal and MotionActivity is NoMotion then BlindsPosition is Closed"
    "If LightLevel is Bright and MotionActivity is NoMotion then BlindsPosition is Closed"
    "If LightLevel is Dark and MotionActivity is Motion then BlindsPosition is Open"

    

    
];


fis = addRule(fis, ruleList);


fis = addRule(fis, ruleList);

%% ------------------- Save and Display -------------------

% Save the FIS
writeFIS(fis, 'SmartHomeControl.fis');

% Display the rules
disp('FIS created successfully with the following rules:');
showrule(fis);

% Plot membership functions for verification
figure;
subplot(3,1,1);
plotmf(fis, 'input', 1);
title('Temperature MFs');

subplot(3,1,2);
plotmf(fis, 'input', 2);
title('Light Level MFs');

subplot(3,1,3);
plotmf(fis, 'input', 3);
title('Motion Activity MFs');
