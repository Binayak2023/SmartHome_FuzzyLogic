function indices = rouletteWheelSelection(fitness)
    % Normalize fitness values to create a probability distribution
    fitness = fitness - min(fitness);
    if sum(fitness) == 0
        fitness = ones(size(fitness));
    end
    fitness = fitness / sum(fitness);
    
    % Cumulative sum for roulette wheel
    cumFitness = cumsum(fitness);
    
    % Select individuals based on their fitness
    numSelections = length(fitness);
    indices = zeros(numSelections, 1);
    for i = 1:numSelections
        r = rand;
        indices(i) = find(cumFitness >= r, 1, 'first');
    end
end
