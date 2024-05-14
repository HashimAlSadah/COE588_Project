function Plots(lambda, mue, c, rho, numCustomers, ...
    TT, WT, theo_E_T, theo_E_W, pc, ...
    pWaiting, probWait, N_max, theo_E_N, theo_PMF, simPMF)

save = false;
% plot the distribution of TotalTime
MinTime = 0; MaxTime = max(TT); 
NoOfBins = 50; BinWidth = (MaxTime-MinTime)/NoOfBins;
bins = MinTime+BinWidth/2:BinWidth:MaxTime-BinWidth/2;
freq = hist(TT, bins);
TT_EPDF = freq./sum(freq)./BinWidth;
TT_PDF = (1/(theo_E_T))*exp(-bins*(1/(theo_E_T)));
figure(1); clf;
bar(bins, TT_EPDF); 
grid on; hold on;
plot(bins, TT_PDF, '--or', 'LineWidth', 2);
hold off;
xlabel('total time, T'); ylabel('PDF f_T(t)');
set(gca,'FontSize', 14);
h = legend(['No of customers = ', num2str(numCustomers) ', \rho = ', ...
 num2str(lambda/(c*mue))], 'Theoretical');
set(h, 'FontSize', 12);
if save
    fileName = strcat("bars_plot_no_customers_", ...
        num2str(numCustomers), "_rho_", num2str(rho));
    exportgraphics(gcf, strcat("figures/total_time_dist/", ...
        fileName, ".png"), Resolution=300)
end

%------semi lograthmic f_T(t)------
figure(2);clf;
semilogy(bins, TT_PDF, "-b", bins, TT_EPDF, "or", LineWidth=1.5)
xlabel('total time, T'); 
ylabel('PDF $f_T(t)$', Interpreter="latex");
h = legend(['No of customers = ', num2str(numCustomers) ', \rho = ', ...
 num2str(lambda/(c*mue))], 'Theoretical');
set(h, 'FontSize', 12);
grid on;
if save 
    fileName = strcat("semilogy_plot_no_customers_", ...
        num2str(numCustomers), "_rho_", num2str(rho));
    exportgraphics(gcf, strcat("figures/total_time_dist/", ...
        fileName, ".png"), Resolution=300)
end 

% plot the distribution of waitTime
WWT = nonzeros(WT)';
MinTime = 0; MaxTime = max(WWT); 
NoOfBins = 50; BinWidth = (MaxTime-MinTime)/NoOfBins;
bins = MinTime+BinWidth/2:BinWidth:MaxTime-BinWidth/2;
freq = hist(WWT, bins);
WT_EPDF = probWait*freq./sum(freq)./BinWidth;
WT_PDF = c*mue*pc*exp(-bins*c*mue*pc/pWaiting);
figure(3); clf;
bar(bins, WT_EPDF); 
grid on; hold on;
plot(bins, WT_PDF, '--or', 'LineWidth', 2);
hold off;
xlabel('wait time, T'); ylabel('PDF f_W(t)');
set(gca,'FontSize', 14);
h = legend(['No of customers = ', num2str(numCustomers) ', \rho = ', ...
 num2str(lambda/(c*mue))], 'Theoretical');
set(h, 'FontSize', 12);
if save
    fileName = strcat("bar_plot_no_customers_", ...
        num2str(numCustomers), "_rho_", num2str(rho));
    exportgraphics(gcf, strcat("figures/waiting_time_dist/", ...
        fileName, ".png"), Resolution=300)
end

%------semi logarithmic f_W(t)-----
figure(4);clf;
semilogy(bins, WT_EPDF, "ro", bins, WT_PDF, "-b", LineWidth=1.5)
xlabel('wait time, T');
ylabel('PDF $f_W(t)$', Interpreter="latex");
h = legend(['No of customers = ', num2str(numCustomers) ', \rho = ', ...
 num2str(lambda/(c*mue))], 'Theoretical');
set(h, 'FontSize', 12);
grid on;
if save 
    fileName = strcat("semilogy_plot_no_customers_", ...
        num2str(numCustomers), "_rho_", num2str(rho));
    exportgraphics(gcf, strcat("figures/waiting_time_dist/", ...
        fileName, ".png"), Resolution=300)
end

%---------PMF of N-------
fig_xlabel = "No of customers, k";
fig_ylabel = "Prob[N(t) = k]";

%--------semi logarithmic-----
figure(5); clf;
semilogy(0:1:N_max, simPMF, "ro", ...
     0:1:N_max, theo_PMF, "-b", LineWidth=1.5)
xlabel(fig_xlabel)
ylabel(fig_ylabel)
h = legend(['No of customers = ', num2str(numCustomers) ', \rho = ', ...
 num2str(lambda/(c*mue))], 'Theoretical');
set(h, 'FontSize', 12);
grid on;
if save
    fileName = strcat("bar_plot_no_customers_", ...
        num2str(numCustomers), "_rho_", num2str(rho));
    exportgraphics(gcf, strcat("figures/N_PMF/", ...
        fileName, ".png"), Resolution=300)
end


%-------bar plot------
figure(6); clf;
bar(0:1:N_max, simPMF)
hold on;
plot(0:1:N_max, theo_PMF, "--ro",LineWidth=1.5)
hold off;
xlabel(fig_xlabel)
ylabel(fig_ylabel)
h = legend(['No of customers = ', num2str(numCustomers) ', \rho = ', ...
 num2str(lambda/(c*mue))], 'Theoretical');
set(h, 'FontSize', 12);
grid on;
if save
    fileName = strcat("semilogy_plot_no_customers_", ...
        num2str(numCustomers), "_rho_", num2str(rho));
    exportgraphics(gcf, strcat("figures/N_PMF/", ...
        fileName, ".png"), Resolution=300)
end
end

