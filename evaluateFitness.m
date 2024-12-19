function fitness = evaluateFitness(fis, inputData, targetOutputs, chromosome)
    % Set the MFs using the chromosome
    fis = setMembershipFunctions(fis, chromosome);
    
    try
        % Simulate the FIS with the input data
        simulatedOutputs = evalfis(fis, inputData);
        
        % Calculate Mean Squared Error (MSE)
        error = targetOutputs - simulatedOutputs;
        mse = mean(error .^ 2, 'all');

        % Fitness is the inverse of the error (minimize error)
        fitness = 1 / (1 + mse);
    catch
        % Assign low fitness if an error occurs
        fitness = 0;
    end
end
