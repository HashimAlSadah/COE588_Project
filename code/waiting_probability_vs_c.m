clc;clearvars;
saveFigure = true;
numCustomers = 1000000;
max_c = 15;
rho = 0.90; c = 1: 1: max_c;
a = zeros(1, length(c));
simPWaiting = zeros(1, length(c));
theoPwaiting = zeros(1, length(c));
for i = 1:max_c
    a(i) = rho * c(i);
    lambda = a(i); mu = 1;
    IAT = exprnd((1/lambda) * ones(1, numCustomers));
    AT = cumsum(IAT);
    ST = exprnd((1/mu) * ones(1, numCustomers));
    [DT, startList, serviceTime] = simulation_loop(AT, ST, c(i));
    WT = startList - AT;
    simPWaiting(i) = sum( WT > 0) / numCustomers;
    [~, ~, ~, ~, ~, theoPwaiting(i), ~,~] = MMc_theoretical_results(lambda, mu, c(i), c(i)+10);
end 

figure(1)
plot(c, theoPwaiting, "-b", LineWidth=1.5)
hold on;
plot(c, simPWaiting, "or", LineWidth=1.5)
hold off;
xlim([0 max_c+1])
ylim([min(theoPwaiting)-0.05 max(theoPwaiting)+0.05])
xlabel("No of servers")
ylabel("Prob[W > 0]")
legend("Theoretical", "Simulation")
grid on;
fig_title = strcat("no_customers_", num2str(numCustomers), ...
    "_max_c_", num2str(max_c), ".png");
if saveFigure
    exportgraphics(gcf, strcat("figures/pWaiting_vs_c/", fig_title), Resolution=300)
end