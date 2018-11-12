function S = integral(f, t, n, k, w)
    max_idx = length(t);
    h = floor(max_idx/n);
    
    t_n = zeros();
    f_n = zeros();
    for i = 1:n
        i_time = i*h;
        t_n(i) = t(i_time);
        f_n(i) = f(i_time);
    end
    sinus = sin(k*t_n(1:end)*w);
    S = h/2*(f_n(1)*sinus(1)+f_n(end)*sinus(end)+2*sum(f_n(2:end-1).*sinus(2:end-1)));

end