clc;clearvars;
numCustomers = 100000;
lambda = 16;
mue = 10;
c = 2;
rho = lambda / (c * mue);
n_trials = 5;
sim_E_W = 0;
sim_E_T = 0;
sim_E_N = 0;
sim_E_Nq = 0;
sim_rho = 0;

for i = 1:n_trials 
% Initialize lists
AT = cumsum(exprnd((1/lambda)*ones(1,numCustomers)));
ST = exprnd((1/mue)*ones(1,numCustomers));
n_runs = 1;



%---------E[T], E[W]--------
[DT, startList, serviceTime] = simulation_loop(AT, ST, c);
WT = startList - AT;
TT = WT + ST;
sim_E_W = sim_E_W + mean(WT);
sim_E_T = sim_E_T + mean(TT);
probWait = sum( WT > 0) / length(WT);

%-------E[N], E[Nq]-------
[areaN, areaNq] = PMF_and_track_N(AT, DT, c);
maxDT = max(DT);
sim_E_N = + sim_E_N + areaN / maxDT;
sim_E_Nq = sim_E_Nq + areaNq / maxDT;
sim_rho =sim_rho + mean(serviceTime / maxDT);


end 
sim_E_W = sim_E_W / n_trials;
sim_E_T = sim_E_T / n_trials;
sim_E_N = sim_E_N / n_trials;
sim_E_Nq = sim_E_Nq / n_trials;
sim_rho = sim_rho / n_trials;

%-------theoretical results------
[theo_PMF, theo_E_N, theo_E_Nq, theo_E_T, theo_E_W] = ...
    MMc_theoretical_results(lambda, mue, c, 30);

disp("----------Simulation Resutls-------")
fprintf("E[N] = %f \n", sim_E_N);
fprintf("E[Nq] = %f \n", sim_E_Nq);
fprintf("E[T] = %f \n", sim_E_T);
fprintf("E[W] = %f \n", sim_E_W);

disp("----------Theoretical Resutls-------")
fprintf("E[N] = %f \n", theo_E_N);
fprintf("E[Nq] = %f \n", theo_E_Nq);
fprintf("E[T] = %f \n", theo_E_T);
fprintf("E[W] = %f \n", theo_E_W);
