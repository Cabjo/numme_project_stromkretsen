function [T, T_index] = interpol(I_vector, t, N)
    I = I_vector(1,1:end);
    I_prim = I_vector(2,1:end);

    pos_zero = 1;
    l = 1;
    while I_prim(l) > 0
        pos_zero = I_prim(l);
        l = l+1;
    end
    neg_zero = I_prim(l);
    pos_zero_index = l-1;
    neg_zero_index = l;
    
    t_pos = t(pos_zero_index);
    t_neg = t(neg_zero_index);
    
    h = abs(t_neg - t_pos)/N;
    
    x = [t_pos t_neg];
    v = [pos_zero neg_zero];
    xq = t_pos:h:t_neg;
    vq = interp1(x,v,xq);

    % Time for I_max (I'=0)
    k = 1;
    while abs(vq(k)) ~= min(abs(vq))
        k = k+1;
    end 
    t_zero = xq(k);
    
    T_exact = 4*t_zero;
    
    H = (t(end)-t(1))/N;             % Same h as in ODE calculations
    T_interval = [T_exact-H T_exact+H];
    
    m = 1;
    n = 1;
    t_one_period = zeros();
    t_one_period_index = zeros();
    while t(m) <= T_interval(2)
       if t(m) >= T_interval(1)
           t_one_period(n) = t(m);
           t_one_period_index(n) = m;
           n = n+1;
       end
       m = m+1;
    end
    
    T_min_difference_vector = abs(t_one_period - T_exact); 
    T_min_difference = min(T_min_difference_vector);
    
    % Find T index
    r = 1;
    while T_min_difference_vector(r) ~= T_min_difference
        r = r+1;
    end
    T_index = t_one_period_index(r);
    T = t(T_index);
end