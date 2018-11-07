tspan = [0 0.01];
I_01 = [0; 240];
N = 10;
[t,I] = RK4(@current_ode, tspan, N, I_01);
% options = odeset('RelTol',1e-10);
% [t, I] = ode45(@current_ode, tspan, I_01, options);

%plot(t, I(:,1),'-o', t, I(:,2), '-o')
plot(t, I(:,1),'-o', t, I(:,2), '-o')