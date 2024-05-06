function [DT, startList, serviceTime] = simulation_loop(AT, ST, c)
    numCustomers = length(AT);
    startList = zeros(1, numCustomers);
    DT = zeros(1, numCustomers);
    serverList = zeros(1, c); % Initialize server list with c free servers
    serverID = zeros(1, numCustomers);
    serviceTime = zeros(1, c);
    % Run simulation
    for i = 1:numCustomers
        % Find the earliest available server
        [~, idx] = min(serverList);
        earliestAvailableTime = serverList(idx);
        serverID(i) = idx;
        
        % Calculate the start time for the customer
        startTime = max(AT(i), earliestAvailableTime);
        startList(i) = startTime;
        
        % Calculate the departure time
        departureTime = startTime + ST(i);
        DT(i) = departureTime;
        
        % Update the server list
        serverList(idx) = departureTime;
        serviceTime(idx) = serviceTime(idx) + ST(i); 
    end
end