% clear all, close all, clc
format long
tspan = [0 0.01];
I_0 = [0 0 0; 240 1200 2400];
N = 100000;

Irk_max = [];
Irk_idx = [];
I_max = [];
I_idx = [];

T = [];
T_idx = [];

for i = 1:3
  

    % ODE45 approximation
    % t is the times
    % I is the matrix containing I(t) and I'(t)
    options = odeset('RelTol',1e-9);
    [t, I] = ode45(@current_ode, tspan, I_0(:,i), options);
    
    j = 1;
    I_half = zeros();
    while I(j,1) >= 0
        I_half(j)= I(j,1);
        j = j+1;
    end
    [I_max, I_idx] = max(I_half);
%     t_max_idx = length(I_half);
%     figure(i)
%     plot(t(1:t_max_idx), I_half);
    

%     
%     [val, idx] = max(I(5:end,1)); 
%     I_max = [I_max val];
%     I_idx = [I_idx, idx];
    
    % Runge-Kutta approximation
    % trk is the times
    % Irk is the matrix containing Irk(trk) and Irk'(trk)
    [trk,Irk] = RK4(@current_ode, tspan, N, I_0(:,i));
    
    [val_rk, idx_rk] = max(Irk(1,2:end)); % look at valuse of I from index 2 to end (index 1 gives max...)
    Irk_max = [Irk_max val_rk];
    Irk_idx = [Irk_idx, idx_rk];
    
    I_zero = [0 0];
    figure(i+3)
    subplot(2,1,1), plot(t, I(:,1),'-', tspan, I_zero, '-')
    legend('ode45', 'y = 0', 'Location','NorthEastOutside')
    subplot(2,1,2),plot(trk, Irk(1,:),'-', tspan, I_zero, '-')
    legend('Runge-Kutta 4', 'y = 0', 'Location','NorthEastOutside')
    
    T = [T t(I_idx)];
    T_idx = [T_idx I_idx];
%     Trk = trk(Irk_idx);
end 

%get index for these (we need to take t(index))
% I_max
% I_idx
% 
% Irk_max
% Irk_idx
i = 1;
k = 2;
T = T*4;              % times 4 due to symmetry
T_idx = T_idx*4;
t_period = t(1:T_idx(i));
w = 2*pi/T(i);
n = 8;
max_idx = length(t_period);
a = 0; 
a_next = 1;
f = I(1:T_idx(i));


%while abs(a-a_next) > 1e-2
    a = a_next;
    n = n*2;
    h = floor(max_idx/n);
    S = integral(f, t_period, h, k);
    a_next = (2/T(i))*S
    if h == 0
        % attempt to break the loop :( 
        a = a_next;
    end
%end
