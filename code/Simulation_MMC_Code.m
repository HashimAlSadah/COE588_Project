clc;clearvars;
numCustomers = 100000;
lambda = 16;
mue = 10;
c = 2;
N_max = 100;
rho = lambda / (c * mue);
n_trials = 1;
sim_E_W = 0;
sim_E_T = 0;
sim_E_N = 0;
sim_E_Nq = 0;
sim_rho = 0;

for i = 1:n_trials 
% Initialize lists
AT = cumsum(exprnd((1/lambda)*ones(1,numCustomers)));
ST = exprnd((1/mue)*ones(1,numCustomers));


%---------E[T], E[W]--------
[DT, startList, serviceTime] = simulation_loop(AT, ST, c);
WT = startList - AT;
TT = WT + ST;
sim_E_W = sim_E_W + mean(WT);
sim_E_T = sim_E_T + mean(TT);
probWait = sum( WT > 0) / length(WT);

%-------E[N], E[Nq]-------
[areaN, areaNq, simPMF] = PMF_and_track_N(AT, DT, c, N_max);
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
[theo_PMF, theo_E_N, theo_E_Nq, theo_E_T, theo_E_W, pWaiting, pc, p0] = ...
    MMc_theoretical_results(lambda, mue, c, N_max);

disp("----------Simulation Resutls-------")
fprintf("E[N] = %f \n", sim_E_N);
fprintf("E[Nq] = %f \n", sim_E_Nq);
fprintf("E[T] = %f \n", sim_E_T);
fprintf("E[W] = %f \n", sim_E_W);
fprintf("Probability to Wait = %f \n", probWait);

disp("----------Theoretical Resutls-------")
fprintf("E[N] = %f \n", theo_E_N);
fprintf("E[Nq] = %f \n", theo_E_Nq);
fprintf("E[T] = %f \n", theo_E_T);
fprintf("E[W] = %f \n", theo_E_W);
fprintf("Probability to Wait = %f \n", pWaiting);

Plots(lambda, mue, c, rho, numCustomers, TT, WT, theo_E_T, ...
    theo_E_W, pc, pWaiting, probWait, N_max, theo_E_N, ...
    theo_PMF, simPMF);