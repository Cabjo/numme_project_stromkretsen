% clear all, close all, clc
format long
tspan = [0 0.01];
I_0 = [0 0 0; 240 1200 2400];
N = 10000;

T = [];
Trk = [];
T_idx = [];
Trk_idx = [];


for i = 1:1
    % ode45
    options = odeset('RelTol',1e-9);
    [t, I] = ode45(@current_ode, tspan, I_0(:,i), options);
   % [val, idx] = max(I(1:end,1))
    j = 1;
    I_half = zeros();
    while I(j,1) >= 0
        I_half(j)= I(j,1);
        j = j+1;
    end
    [I_max, I_idx] = max(I_half);
    T_idx = [T_idx, I_idx*4];
    T = [T, t(I_idx*4)];
    f = I(1:I_idx*4+10,1);
    figure(1)
    plot(t(1:I_idx*4+10), f)
    
    %t(1:t_max_idx)
%     t_max_idx = length(I_half);
%     figure(i)
%     plot(t(1:t_max_idx), I_half);

    %RK4
    [trk,Irk] = RK4(@current_ode, tspan, N, I_0(:,i));
    l = 1;
    Irk_half = zeros();
    while Irk(1,l) >= 0
        Irk_half(l)= Irk(1,l);
        l = l+1;
    end
    [Irk_max, Irk_idx] = max(Irk_half);
    Trk_idx = [Trk_idx, Irk_idx*4]; % Symetry
    Trk_period = [Trk, trk(Irk_idx*4)];
    frk = Irk(1,1:Irk_idx*4);
    figure(2)
    plot(trk(1:Irk_idx*4), frk);
    
    
%     I_zero = [0 0];
%     figure(i+3)
%     subplot(2,1,1), plot(t, I(:,1),'-', tspan, I_zero, '-')
%     legend('ode45', 'y = 0', 'Location','NorthEastOutside')
%     subplot(2,1,2), plot(trk, Irk(1,:),'-', tspan, I_zero, '-')
%     legend('Runge-Kutta 4', 'y = 0', 'Location','NorthEastOutside')
end
i = 1;
k= 1;
n = 250;
hrk = floor(Trk_idx(i)/n);
h = floor((T_idx(i)+10)/n);
Srk = integral(frk, trk(1:Trk_idx(i)), hrk, k)
S = integral(f, t(1:T_idx(i)+10), h, k)