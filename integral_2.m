function S = integral_2(I_period, t_period, k)
    w = 2*pi/t_period(end);
    argument= k*w*t_period;
    sinus = sin(argument);
    S = (t_period(2)-t_period(1))/2*(I_period(1)*sinus(1)+I_period(end)*sinus(end)+2*sum(I_period(2:end-1).*sinus(2:end-1))); 
end