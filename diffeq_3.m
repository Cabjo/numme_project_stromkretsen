clear all, close all, clc
format long

i = 1;
tspan = [0 0.01];
I_0 = [0 0 0; 240 1200 2400];        % Initial values for the ode:s


N = 8;                          % Number of sub intervals for RK4, N>3 (i=1), >8 i=2, >64 (i=3)
tol = 1e-10;

a_start = double([0 0 0 0 0 0 0 0 0 0 0 0 0 0])
a_next = double([1 1 1 1 1 1 1 1 1 1 1 1 1 1])


max(abs(a_next-a_start))


while max(abs(a_next-a_start)) > tol
    
    a_start = a_next;
    N = N*2;
    
    %RK4
    [t,I_vector] = RK4(@current_ode, tspan, N, I_0(:,i)); 
    [T, T_index] = interpol(I_vector, t, N);
    
    
    I_period = I_vector(1,1:T_index);
    t_period = t(1:T_index);
    for k = 1:14
        integral_value = integral_2(I_period, t_period, k);
        a_next(k) = 2/T*integral_value;
    end
    
end
w = 2*pi/T;
ak = a_next;


I_fourier = @(q) ak(1)*sin(1*w*q) + ak(2)*sin(2*w*q) + ak(3)*sin(3*w*q) + ak(4)*sin(4*w*q) + ak(5)*sin(5*w*q) + ak(6)*sin(6*w*q) + ak(7)*sin(7*w*q) + ak(8)*sin(8*w*q) + ak(9)*sin(9*w*q) + ak(10)*sin(10*w*q) + ak(11)*sin(11*w*q) + ak(12)*sin(12*w*q) + ak(13)*sin(13*w*q) + ak(14)*sin(14*w*q);
I_q_values = I_fourier(t_period);

figure(1)
plot(t_period, I_q_values, '-', t_period, I_vector(1,1:T_index), '-')
legend('Fourier serie', 'Runge-Kutta', 'Location','NorthEastOutside')

N

