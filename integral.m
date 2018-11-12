function S = integral(f, t, h, k)
    max_idx = length(t);
%     h = floor(max_idx/n)
    T = t(max_idx);
    w = 2*pi/T;
    %plot(t, f,'-')
    f_n = zeros();
    t_n = zeros();
    i_time = 1;
    f_n(1) = f(i_time);
    t_n(1) = t(i_time);
    i = 2;
    while i_time+h < max_idx 
        i_time = i_time+h;
        t_n(i) = t(i_time);
        f_n(i) = f(i_time);
        i = i+1;   
    end
    i_time = max_idx;
    t_n(i) = t(i_time);
    f_n(i) = f(i_time);

    argument= k*t_n*w;
    sinus = sin(argument);
    S = h/2*(f_n(1)*sinus(1)+f_n(end)*sinus(end)+2*sum(f_n(2:end-1).*sinus(2:end-1)));  
end