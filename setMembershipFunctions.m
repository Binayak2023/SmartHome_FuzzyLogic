function fis = setMembershipFunctions(fis, chromosome)
    idx = 1;
    lowerBound = 0;
    upperBound = 40;  % Assuming inputs range between 0 and 40

    % Update Input 1 (Temperature) MFs
    for i = 1:3
        params = sort(chromosome(idx:idx+2));
        params = max(min(params, upperBound), lowerBound);
        fis.Inputs(1).MembershipFunctions(i).Parameters = params;
        idx = idx + 3;
    end

    % Update Input 2 (Light Level) MFs
    for i = 1:3
        params = sort(chromosome(idx:idx+2));
        params = max(min(params, upperBound), lowerBound);
        fis.Inputs(2).MembershipFunctions(i).Parameters = params;
        idx = idx + 3;
    end

    % Update Input 3 (Motion Activity) MFs
    for i = 1:3
        params = sort(chromosome(idx:idx+2));
        params = max(min(params, upperBound), lowerBound);
        fis.Inputs(3).MembershipFunctions(i).Parameters = params;
        idx = idx + 3;
    end
end
