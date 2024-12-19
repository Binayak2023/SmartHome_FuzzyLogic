function offspring = crossover(parents)
    % Crossover function for Genetic Algorithm
    % Performs single-point crossover on the selected parents

    numParents = size(parents, 1);
    numVars = size(parents, 2);
    offspring = parents;

    % Perform crossover for pairs of parents
    for i = 1:2:numParents-1
        % Choose a random crossover point
        crossoverPoint = randi([1, numVars-1]);

        % Swap genetic information between parents at the crossover point
        offspring(i, crossoverPoint+1:end) = parents(i+1, crossoverPoint+1:end);
        offspring(i+1, crossoverPoint+1:end) = parents(i, crossoverPoint+1:end);
    end
end
