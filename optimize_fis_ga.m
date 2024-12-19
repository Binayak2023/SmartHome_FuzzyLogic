% optimize_fis_ga.m
% Load the existing FIS and synthetic dataset for optimization

% Load the existing FIS
fis = readfis('SmartHomeControl.fis');

% Load the synthetic dataset (contains 'inputData' and 'targetOutputs')
load('synthetic_dataset.mat');  % Ensure this file contains 'inputData' and 'targetOutputs'

% Display a few samples to verify
disp('Sample Input Data:');
disp(inputData(1:5, :));

disp('Sample Target Outputs:');
disp(targetOutputs(1:5, :));

% Genetic Algorithm Parameters
populationSize = 20;       % Number of chromosomes in the population
numGenerations = 50;       % Number of generations to evolve
mutationRate = 0.1;        % Probability of mutation
numVars = 27;              % 3 inputs × 3 MFs × 3 parameters each = 27 parameters

% Initialize Population with values between 0 and 40
population = rand(populationSize, numVars) * 40;

% Main GA loop
bestFitness = -inf;
bestSolution = [];

for gen = 1:numGenerations
    fitness = zeros(populationSize, 1);
    
    % Evaluate fitness for each chromosome
    for i = 1:populationSize
        fitness(i) = evaluateFitness(fis, inputData, targetOutputs, population(i, :));
    end
    
    % Display the best fitness in the current generation
    [maxFitness, maxIndex] = max(fitness);
    fprintf('Generation %d: Best Fitness = %f\n', gen, maxFitness);
    
    % Update the best solution if a new best fitness is found
    if maxFitness > bestFitness
        bestFitness = maxFitness;
        bestSolution = population(maxIndex, :);
    end

    % Selection: Roulette Wheel Selection
    selected = population(rouletteWheelSelection(fitness), :);
    
    % Crossover: Single-Point Crossover
    offspring = crossover(selected);
    
    % Mutation
    offspring = mutate(offspring, mutationRate);
    
    % Update the population
    population = offspring;
end

% Apply the best solution to the FIS
optimizedFIS = setMembershipFunctions(fis, bestSolution);

% Save the optimized FIS
writeFIS(optimizedFIS, 'OptimizedSmartHomeControl.fis');
disp('Optimization complete. Optimized FIS saved as OptimizedSmartHomeControl.fis');
