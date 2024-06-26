clc;clearvars;
LineWidth = 2; MarkerSize = 8; FontSize1 = 14; FontSize2 = 12;
numCustomers = 100000;
rho = 0.05:0.05:0.99;
mue = 10;
lambda = rho * mue;
c = 2;
N_max = 100;

for i=1:length(rho)
    sim_E_W(i) = 0;
    sim_E_T(i) = 0;
    sim_E_N(i) = 0;
    sim_E_Nq(i) = 0;

    % Initialize lists
    AT = cumsum(exprnd((1/lambda(i))*ones(1,numCustomers)));
    ST = exprnd((1/mue)*ones(1,numCustomers));
  
    %---------E[T], E[W]--------
    [DT, startList, serviceTime] = simulation_loop(AT, ST, c);
    WT = startList - AT;
    TT = WT + ST;
    sim_E_W(i) = sim_E_W(i) + mean(WT);
    sim_E_T(i) = sim_E_T(i) + mean(TT);
    probWait(i) = sum( WT > 0) / length(WT);
    
    %-------E[N], E[Nq]-------
    [areaN, areaNq, simPMF] = PMF_and_track_N(AT, DT, c, N_max);
    maxDT = max(DT);
    sim_E_N(i) = + sim_E_N(i) + areaN / maxDT;
    sim_E_Nq(i) = sim_E_Nq(i) + areaNq / maxDT;
    
    %-------theoretical results------
    [theo_PMF, theo_E_N(i), theo_E_Nq(i), theo_E_T(i), theo_E_W(i), pWaiting(i), pc, p0] = ...
        MMc_theoretical_results(lambda(i), mue, c, N_max);
end

figure(1); clf;
plot(rho,theo_E_T, '--', 'LineWidth', LineWidth); grid on; hold on;
plot(rho,sim_E_T, 'or', 'LineWidth', LineWidth);
xlabel('Traffic intensity Rho (Erlang)'); ylabel('E[T] (time)');
set(gca,'FontSize', FontSize2);
h = legend('theoritical ', 'simulation', 'Location','northwest');
set(h, 'FontSize', FontSize2);
exportgraphics(gcf, "figures/avgs_vs_traffic_intensity/E_T.png", ...
    Resolution=300);

figure(2); clf;
plot(rho,theo_E_W, '--', 'LineWidth', LineWidth); grid on; hold on;
plot(rho,sim_E_W, 'or', 'LineWidth', LineWidth);
xlabel('Traffic intensity Rho (Erlang)'); ylabel('E[W] (time)');
set(gca,'FontSize', FontSize2);
h = legend('theoritical ', 'simulation', 'Location','northwest');
set(h, 'FontSize', FontSize2);
exportgraphics(gcf, "figures/avgs_vs_traffic_intensity/E_W.png", ...
    Resolution=300);

figure(3); clf;
plot(rho,theo_E_N, '--', 'LineWidth', LineWidth); grid on; hold on;
plot(rho,sim_E_N, 'or', 'LineWidth', LineWidth);
xlabel('Traffic intensity Rho (Erlang)'); ylabel('E[N] (Customer)');
set(gca,'FontSize', FontSize2);
h = legend('theoritical ', 'simulation', 'Location','northwest');
set(h, 'FontSize', FontSize2);
exportgraphics(gcf, "figures/avgs_vs_traffic_intensity/E_N.png", ...
    Resolution=300);

figure(4); clf;
plot(rho,theo_E_Nq, '--', 'LineWidth', LineWidth); grid on; hold on;
plot(rho,sim_E_Nq, 'or', 'LineWidth', LineWidth);
xlabel('Traffic intensity Rho (Erlang)'); ylabel('E[Nq] (Customer)');
set(gca,'FontSize', FontSize2);
h = legend('theoritical ', 'simulation', 'Location','northwest');
set(h, 'FontSize', FontSize2);
exportgraphics(gcf, "figures/avgs_vs_traffic_intensity/E_Nq.png", ...
    Resolution=300);