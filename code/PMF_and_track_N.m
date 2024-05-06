function [areaN, areaNq] = PMF_and_track_N(AT, DT, c)
    N = 0; areaN = 0; areaNq = 0;
    preEventTime = 0; clock = 0;
    i = 1; j = 1;
    sortedDT = sort(DT);
    while clock < max(AT)
        if AT(i) < sortedDT(j)
            clock = AT(i);
            timeInterval = clock - preEventTime;
            areaN = areaN + timeInterval * N;
            areaNq = areaNq + timeInterval * max(0, N - c);
            N = N + 1;
            preEventTime = clock;
            i = i + 1;
        else
            clock = sortedDT(j);
            timeInterval = clock - preEventTime;
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
        areaN = areaN + timeInterval * N;
        areaNq = areaNq + timeInterval * max(0, N - c);
        N = N - 1;
        preEventTime = clock;
    end 
end