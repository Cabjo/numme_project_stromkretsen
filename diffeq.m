% clear all, close all, clc
format long
tspan = [0 0.01];
I_0 = [0 0 0; 240 1200 2400];
N = 100000;

Irk_max = [];
Irk_idx = [];
I_max = [];
I_idx = [];

for i = 1:1

    % ODE45 approximation
    % t is the times
    % I is the matrix containing I(t) and I'(t)
    options = odeset('RelTol',1e-9);
    [t, I] = ode45(@current_ode, tspan, I_0(:,i), options);
        
    [val, idx] = max(I(5:end,2));
    I_max = [I_max val];
    I_idx = [I_idx, idx];
    
    % Runge-Kutta approximation
    % trk is the times
    % Irk is the matrix containing Irk(trk) and Irk'(trk)
    [trk,Irk] = RK4(@current_ode, tspan, N, I_0(:,i));
    
    [val_rk, idx_rk] = max(Irk(2,2:end)); % look at valuse of I from index 2 to end (index 1 gives max...)
    Irk_max = [Irk_max val_rk];
    Irk_idx = [Irk_idx, idx_rk];
    
    figure(i)
    subplot(2,1,1), plot(t, I(:,1),'-', t, I(:,2), '-')
    legend('y = 0', 'ode45', 'Location','NorthEastOutside')
    subplot(2,1,2),plot(trk, Irk(1,:),'-', t, I(:,2), '-')
    legend('y = 0', 'Runge-Kutta 4', 'Location','NorthEastOutside')
end 

% get index for these (we need to take t(index))
% I_max
% I_idx
% 
% Irk_max
% Irk_idx


k = 1;
T = t(I_idx);
t_period = t(1:I_idx);
w = 2*pi/T;
n = 8;
max_idx = length(t_period);
a = 0; 
a_next = 1;
f = I(1:I_idx,2);


%while abs(a-a_next) > 1e-2
    a = a_next;
    n = n*2;
    h = floor(max_idx/n);
    S = integral(f, t_period, h, k);
    a_next = (2/T)*S
    if h == 0
        % attempt to break the loop :( 
        a = a_next;
    end
%end
