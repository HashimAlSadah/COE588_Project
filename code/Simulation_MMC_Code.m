clear all;
% Define input parameters
%arrivalList = [2, 7, 8, 11, 12, 15, 18, 20, 24, 29];
%serviceList = [12, 10, 16, 9, 10, 13, 17, 10, 8, 12];
%numCustomers = length(arrivalList);

numCustomers = 10000;
lambda = 9;
mue = 10;
c = 3;
rho = lambda / (c * mue);


% Initialize lists
arrivalList = cumsum(exprnd((1/lambda)*ones(1,numCustomers)));
serviceList = exprnd((1/mue)*ones(1,numCustomers));
startList = zeros(1, numCustomers);
departureList = zeros(1, numCustomers);
serverList = zeros(1, c); % Initialize server list with c free servers
serverID = zeros(1, numCustomers);

% Run simulation
for i = 1:numCustomers
    % Find the earliest available server
    [~, idx] = min(serverList);
    earliestAvailableTime = serverList(idx);
    serverID(i) = idx;
    
    % Calculate the start time for the customer
    startTime = max(arrivalList(i), earliestAvailableTime);
    startList(i) = startTime;
    
    % Calculate the departure time
    departureTime = startTime + serviceList(i);
    departureList(i) = departureTime;
    
    % Update the server list
    serverList(idx) = departureTime;
end
% Performance Measure
waitList = startList - arrivalList;
AvgWaitTime = sum(waitList)/length(waitList);
AvgTotalTime = sum(waitList+serviceList)/length(waitList);
countWait = 0;
for w=1:length(waitList)
    if(waitList(w)==0)
        countWait = countWait + 1;
    end
end
ProbabilityWait = 1-(countWait/length(waitList));



%-------------------------------------------------------------
%-------------------------------------------------------------
%Theoritical
%-------------------------------------------------------------\
%-------------------------------------------------------------

a = lambda / mue; rho = a/c;
p0 = 0;
for i = 0:(c-1)
    p0 = p0 + a^i / factorial(i);
end 
p0 = p0 + ( a^c / factorial(c) ) * ( 1/(1-rho) );
p0 = 1/p0;
pj = zeros(1, numCustomers);
%compute the PMFs
for j = 1:c
    pj(j) = ( (a^(j)) / factorial(j) ) * p0;
end 
for j = c+1:numCustomers
    pj(j) = ( a^(j-c) / factorial(c) ) * a^c * p0;
end 
PMF = [p0 pj];
pc = PMF(c+1); 
pWaiting = pc / (1-rho);
E_Nq = ( rho / (1-rho) ) * pWaiting;
E_W = E_Nq/lambda;
E_T = E_W + (1/mue);
E_N = E_Nq + a;

%-------------------------------------------------------------
%-------------------------------------------------------------
%-------------------------------------------------------------
%-------------------------------------------------------------

all_events = sort([0 arrivalList departureList]);

N = zeros(1,length(all_events));

%create a transitions vector first
%loop over all events and match them arrivals and departures
%for each matching arrival increment the transition
%for each departure decrement the transistion
for n = 1:length(all_events)
    if sum(arrivalList == all_events(n)); N(n) = N(n) + 1; end
    if sum(departureList == all_events(n)); N(n) = N(n) - 1; end
end

%then N(t) is the cummulitve sum of the transitions vector
N = cumsum(N);

AvgNumCustomers = sum(N)/length(N);
ProbabilityIdle = sum(N==0)*2/length(N);


%plot the number of blocks in the system
figure(1)
stairs(all_events, N, 'LineWidth', 1); grid on;
legend('Number of Customers');
axis([0 max(departureList)+0.1 0 max(N)+1]);
