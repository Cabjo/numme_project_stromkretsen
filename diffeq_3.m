% clear all, close all, clc
format long


tspan = [0 0.01];
I_0 = [0 0 0; 240 1200 2400];        % Initial values for the ode:s
N = 100000;                          % Number of sub intervals for RK4

T = [];
Trk = [];
T_idx = [];
Trk_idx = [];


for i = 1:1
    % ode45
    options = odeset('RelTol',1e-9);
    [t, I] = ode45(@current_ode, tspan, I_0(:,i), options);  
    [I_max, I_idx] = half_period(I(:,1));
    
    T_idx = [T_idx, I_idx*4];       % T_idx contains the indexes for the times of the different periods
    T = [T, t(I_idx*4)];            % T contains the times of the different periods
    f = I(1:I_idx*4+10,1);          % f contains the function evaluations at the different times
%     figure(1)
%     plot(t(1:I_idx*4+10), f)


    %RK4
    [trk,Irk] = RK4(@current_ode, tspan, N, I_0(:,i)); 
    [Irk_max, Irk_idx] = half_period(Irk(1,:));
    
    Trk_idx = [Trk_idx, Irk_idx*4];        % Trk_idx contains the indexes for the times of the different periods
    Trk_period = [Trk, trk(Irk_idx*4)];    % Trk contains the times of the different periods
    frk = Irk(1,1:Irk_idx*4);              % frk contains the function evaluations at the different times
%     figure(2)
%     plot(trk(1:Irk_idx*4), frk);
    
    
    I_zero = [0 0];
    figure(i+3)
    subplot(2,1,1), plot(t, I(:,1),'-', tspan, I_zero, '-')
    legend('ode45', 'y = 0', 'Location','NorthEastOutside')
    subplot(2,1,2), plot(trk, Irk(1,:),'-', tspan, I_zero, '-')
    legend('Runge-Kutta 4', 'y = 0', 'Location','NorthEastOutside')

    fourier_coef_rk = zeros();
    fourier_coef = zeros();
    % fourier_fun = zeros();

    for k = 1:14
        n = 100;                            % nr of subintervals for the integral
        w = 2*pi/Trk_period(i);             % RK4 omega
        Srk = integral(frk, trk(1:Trk_idx(i)), n, k);
        S = integral(f, t(1:T_idx(i)+10), n, k);
        fourier_coef(k) = (2/t(T_idx(i)+10))*S;
        fourier_coef_rk(k) = (2/trk(Trk_idx(i)))*Srk;
        fourier = @(t) fourier_coef(k)*sin(w*t);
        %fourier = @(t) 0.243*sin(w*t);
        
    end
    fourier_coef_rk
    fourier_coef
    % This plots a wrong version of the RK4 fourier-series of the first graph
    % with one coefficent
    figure(3)
    plot(trk, fourier(trk), '-',trk, Irk(1,:),'-')
    legend('hemagjord', 'rk', 'Location','NorthEastOutside')

end

