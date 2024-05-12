function Plots(lambda, mue, c, rho, numCustomers, TT, WT, theo_E_T, theo_E_W, pc, pWaiting, NCustomer, theo_E_N)
% plot the distribution of TotalTime
MinTime = 0; MaxTime = max(TT); 
NoOfBins = 50; BinWidth = (MaxTime-MinTime)/NoOfBins;
bins = MinTime+BinWidth/2:BinWidth:MaxTime-BinWidth/2;
freq = hist(TT, bins);
TT_EPDF = freq./sum(freq)./BinWidth;
TT_PDF = (1/(theo_E_T))*exp(-bins*(1/(theo_E_T)));
figure(1); clf;
bar(bins, TT_EPDF); grid on; hold on;
plot(bins, TT_PDF, '--or', 'LineWidth', 2);
xlabel('total time, T'); ylabel('PDF f_T(t)');
set(gca,'FontSize', 14);
h = legend(['No of customers = ', num2str(numCustomers) ', \rho = ', ...
 num2str(lambda/(c*mue))], 'Theoretical');
set(h, 'FontSize', 12);

% plot the distribution of waitTime
MinTime = 0; MaxTime = max(WT); 
NoOfBins = 50; BinWidth = (MaxTime-MinTime)/NoOfBins;
bins = MinTime+BinWidth/2:BinWidth:MaxTime-BinWidth/2;
freq = hist(WT, bins);
WT_EPDF = freq./sum(freq)./BinWidth;
WT_PDF = (1/(theo_E_W))*exp(-bins*(1/(theo_E_W)));
figure(2); clf;
bar(bins, WT_EPDF); grid on; hold on;
plot(bins, WT_PDF, '--or', 'LineWidth', 2);
xlabel('wait time, T'); ylabel('PDF f_W(t)');
set(gca,'FontSize', 14);
h = legend(['No of customers = ', num2str(numCustomers) ', \rho = ', ...
 num2str(lambda/(c*mue))], 'Theoretical');
set(h, 'FontSize', 12);

% plot the distribution of waitTime2
MinTime = 0; MaxTime = max(WT); 
NoOfBins = 50; BinWidth = (MaxTime-MinTime)/NoOfBins;
bins = MinTime+BinWidth/2:BinWidth:MaxTime-BinWidth/2;
freq = hist(WT, bins);
WT_EPDF = freq./sum(freq)./BinWidth;
WT_PDF_1 = c*mue*pc*exp(-bins*c*mue*pc/pWaiting);
figure(3); clf;
bar(bins, WT_EPDF); grid on; hold on;
plot(bins, WT_PDF_1, '--or', 'LineWidth', 2);
xlabel('wait time, T'); ylabel('PDF f_W(t)');
set(gca,'FontSize', 14);
h = legend(['No of customers = ', num2str(numCustomers) ', \rho = ', ...
 num2str(lambda/(c*mue))], 'Theoretical');
set(h, 'FontSize', 12);

% plot the distribution of waitTime2
MinTime = 0; MaxTime = max(WT); 
NoOfBins = 50; BinWidth = (MaxTime-MinTime)/NoOfBins;
bins = MinTime+BinWidth/2:BinWidth:MaxTime-BinWidth/2;
freq = hist(WT, bins);
WT_EPDF = freq./sum(freq)./BinWidth;
WT_PDF_2 = c*mue*pWaiting*(1-rho)*exp(-bins*c*mue*(1-rho));
figure(4); clf;
bar(bins, WT_EPDF); grid on; hold on;
plot(bins, WT_PDF_2, '--or', 'LineWidth', 2);
xlabel('wait time, T'); ylabel('PDF f_W(t)');
set(gca,'FontSize', 14);
h = legend(['No of customers = ', num2str(numCustomers) ', \rho = ', ...
 num2str(lambda/(c*mue))], 'Theoretical');
set(h, 'FontSize', 12);

% plot the distribution of NCustomer
NoOfBins = max(NCustomer); BinWidth = 1;
bins = 0:BinWidth:NoOfBins;
freq = hist(NCustomer, bins);
NCustomer_EPDF = freq./sum(freq)./BinWidth;
%NCustomer_PDF = exp(-theo_E_N)*((theo_E_N)^bins)/factorial(bins);
figure(5); clf;
bar(bins, NCustomer_EPDF); grid on; hold on;
%plot(bins, NCustomer_PDF, '--or', 'LineWidth', 2);
xlabel('No. of Customers, N'); ylabel('PDF f_N(t)');
set(gca,'FontSize', 14);
%h = legend(['No of customers = ', num2str(numCustomers) ', \rho = ', ...
% num2str(lambda/(c*mue))], 'Theoretical');
%set(h, 'FontSize', 12);
end

