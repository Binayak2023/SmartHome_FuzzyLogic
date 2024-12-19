% compare_optimization.m
% Compare Genetic Algorithm (GA) and Particle Swarm Optimization (PSO)
% on Sphere and Rastrigin functions for D = 2 and D = 10

%% ------------------- Initialization -------------------

% Set dimensions to compare
dimensions = [2, 10];

% Number of runs for each optimization (to ensure reliable results)
numRuns = 5;

% Define the benchmark functions
sphereFunction = @(x) sum(x.^2);
rastriginFunction = @(x) 10 * numel(x) + sum(x.^2 - 10 * cos(2 * pi * x));

% Define the lower and upper bounds for the variables
lowerBound = -5.12;
upperBound = 5.12;

% Optimization options for Genetic Algorithm (GA)
gaOptions = optimoptions('ga', ...
    'MaxGenerations', 300, ...
    'PopulationSize', 100, ...
    'CrossoverFraction', 0.8, ...
    'MutationFcn', @mutationuniform, ...
    'Display', 'iter');

% Optimization options for Particle Swarm Optimization (PSO)
psoOptions = optimoptions('particleswarm', ...
    'SwarmSize', 100, ...
    'MaxIterations', 300, ...
    'InertiaRange', [0.4, 0.9], ...
    'SelfAdjustmentWeight', 1.5, ...
    'SocialAdjustmentWeight', 2.0, ...
    'Display', 'iter');

%% ------------------- Run Optimizations -------------------

% Loop through each dimension
for D = dimensions
    fprintf('\n========== Optimization for D = %d ==========\n', D);
    
    % Number of variables for current dimension
    numVars = D;

    % Loop through each function
    functions = {@(x) sphereFunction(x), @(x) rastriginFunction(x)};
    functionNames = {'Sphere Function', 'Rastrigin Function'};

    for i = 1:length(functions)
        objectiveFunction = functions{i};
        funcName = functionNames{i};

        fprintf('\n--- %s ---\n', funcName);

        %% Genetic Algorithm (GA)
        fprintf('Running Genetic Algorithm (GA)...\n');
        gaBestValues = zeros(numRuns, 1);
        for run = 1:numRuns
            [gaSolution, gaBestValue] = ga(objectiveFunction, numVars, [], [], [], [], ...
                                           lowerBound * ones(1, numVars), upperBound * ones(1, numVars), [], gaOptions);
            gaBestValues(run) = gaBestValue;
        end
        fprintf('GA Best Value: %.4f (Mean: %.4f, Std: %.4f)\n', min(gaBestValues), mean(gaBestValues), std(gaBestValues));

        %% Particle Swarm Optimization (PSO)
        fprintf('Running Particle Swarm Optimization (PSO)...\n');
        psoBestValues = zeros(numRuns, 1);
        for run = 1:numRuns
            [psoSolution, psoBestValue] = particleswarm(objectiveFunction, numVars, ...
                                                        lowerBound * ones(1, numVars), upperBound * ones(1, numVars), psoOptions);
            psoBestValues(run) = psoBestValue;
        end
        fprintf('PSO Best Value: %.4f (Mean: %.4f, Std: %.4f)\n', min(psoBestValues), mean(psoBestValues), std(psoBestValues));

        %% Plot Comparison of GA and PSO Results
        figure;
        bar([mean(gaBestValues), mean(psoBestValues)]);
        set(gca, 'XTickLabel', {'GA', 'PSO'});
        ylabel('Mean Best Value');
        title(sprintf('%s Optimization Results (D = %d)', funcName, D));
        grid on;
    end
end
