function [I_max, I_idx] = half_period(I)

    l = 1;
    I_half = zeros();
    while I(l) >= 0
        I_half(l)= I(l);
        l = l+1;
    end
    [I_max, I_idx] = max(I_half);
    
end