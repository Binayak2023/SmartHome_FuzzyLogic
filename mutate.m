function mutated = mutate(population, mutationRate)
    % mutate function for Genetic Algorithm
    % Introduces small random mutations in the population

    % Copy the population to preserve the original structure
    mutated = population;

    % Get the number of individuals and number of variables
    [numIndividuals, numVars] = size(population);

    % Perform mutation for each individual
    for i = 1:numIndividuals
        for j = 1:numVars
            % Apply mutation based on mutation rate
            if rand < mutationRate
                % Introduce a small random change
                mutationValue = (randn * 2);  % Adjust the scale of mutation as needed
                mutated(i, j) = mutated(i, j) + mutationValue;
            end
        end
    end
end
