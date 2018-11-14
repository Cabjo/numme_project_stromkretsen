function S = integral(f, t, n, k)
    max_idx = length(t);
    h_idx = floor(max_idx/n)
    T = t(max_idx);
    w = 2*pi/T;
    f_n = zeros();      % Contains function I evaluated in h*i
    t_n = zeros();      % Contains the times that I is evaluated in
    idx_time = 1;       % i
    f_n(idx_time) = f(idx_time);
    t_n(idx_time) = t(idx_time);
    i = 2;
    while idx_time+h_idx < max_idx 
        idx_time = idx_time+h_idx;
        t_n(i) = t(idx_time);
        f_n(i) = f(idx_time);
        i = i+1;   
    end
    idx_time = max_idx;
    t_n(i) = t(idx_time);
    f_n(i) = f(idx_time);
    
    
    % S is the integral of I(t)*sin(k*w*t) from 0 to T
    argument= k*w*t_n;
    sinus = sin(argument);
    S = t(h_idx)/2*(f_n(1)*sinus(1)+f_n(end)*sinus(end)+2*sum(f_n(2:end-1).*sinus(2:end-1)));  
end