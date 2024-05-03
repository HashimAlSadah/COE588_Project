function [PMF, E_N, E_Nq, E_T, E_W] = MMc_theoretical_results(lambda, mu, c, j_max)
    a = lambda / mu; rho = a/c;
    p0 = 0;
    for i = 0:(c-1)
        p0 = p0 + a^i / factorial(i);
    end 
    p0 = p0 + ( a^c / factorial(c) ) * ( 1/(1-rho) );
    p0 = 1/p0;
    pj = zeros(1, j_max);
    %compute the PMFs
    for j = 1:c
        pj(j) = ( (a^(j)) / factorial(j) ) * p0;
    end 
    for j = c+1:j_max
        pj(j) = ( a^(j-c) / factorial(c) ) * a^c * p0;
    end 
    PMF = [p0 pj];
    pc = PMF(c+1); 
    pWaiting = pc / (1-rho);
    E_Nq = ( rho / (1-rho) ) * pWaiting;
    E_W = E_Nq/lambda;
    E_T = E_W + (1/mu);
    E_N = E_Nq + a;
end