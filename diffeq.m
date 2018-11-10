% clear all, close all, clc
format long
tspan = [0 0.01];
I_0 = [0 0 0; 240 1200 2400];
I_01 = [0; 240];
I_02 = [0; 1200];
I_03 = [0; 2400];
N = 10000;
Irk_max = [];
I_max = [];

for i = 1:3
[trk,Irk] = RK4(@current_ode, tspan, N, I_0(:,i));
options = odeset('RelTol',1e-10);
% rk_start
% rk_next
% while abs(rk_start - rk_next) > 1e-10
[t, I] = ode45(@current_ode, tspan, I_0(:,i), options);
Irk_max = [Irk_max max(Irk)];
I_max = [I_max max(I(2,:))];
% end
figure(i)
subplot(2,1,1), plot(t, I(:,1),'-', t, I(:,2), '-')
legend('y = 0', 'ode45', 'Location','NorthEastOutside')
subplot(2,1,2),plot(trk, Irk(1,:),'-', t, I(:,2), '-')
legend('y = 0', 'Runge-Kutta 4', 'Location','NorthEastOutside')
end 

% I_max
% Irk_max

% [trk,Irk] = RK4(@current_ode, tspan, N, I_01);
% options = odeset('RelTol',1e-10);
% [t, I] = ode45(@current_ode, tspan, I_01, options);
% 
% figure(1)
% plot(t, I(:,1),'-o', t, I(:,2), '-o')
% figure(2)
% plot(trk, Irk(1,:),'-o')