function [areaN, areaNq, simPMF] = PMF_and_track_N(AT, DT, c, N_max)
    N = 0; simPMF = zeros(1, N_max+1);
    areaN = 0; areaNq = 0;
    preEventTime = 0; clock = 0;
    i = 1; j = 1;
    sortedDT = sort(DT);
    while clock < max(AT)
        if AT(i) < sortedDT(j)
            clock = AT(i);
            timeInterval = clock - preEventTime;
            simPMF(min(N, N_max)+1) = simPMF(min(N, N_max)+1) + timeInterval;
            areaN = areaN + timeInterval * N;
            areaNq = areaNq + timeInterval * max(0, N - c);
            N = N + 1;
            preEventTime = clock;
            i = i + 1;
        else
            clock = sortedDT(j);
            timeInterval = clock - preEventTime;
            simPMF(min(N, N_max)+1) = simPMF(min(N, N_max)+1) + timeInterval;
            areaN = areaN + timeInterval * N;
            areaNq = areaNq + timeInterval * max(0, N - c);
            N = N - 1;
            preEventTime = clock;
            j = j + 1;
        end
    end

    for j = j:1:length(sortedDT)
        clock = sortedDT(j);
        timeInterval = clock - preEventTime;
        simPMF(min(N, N_max)+1) = simPMF(min(N, N_max)+1) + timeInterval;
        areaN = areaN + timeInterval * N;
        areaNq = areaNq + timeInterval * max(0, N - c);
        N = N - 1;
        preEventTime = clock;
    end 
    simPMF = simPMF/clock;
end