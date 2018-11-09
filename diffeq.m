tspan = [0 0.01];
I_01 = [0; 240];
N = 100;
[trk,Irk] = RK4(@current_ode, tspan, N, I_01);
options = odeset('RelTol',1e-10);
[t, I] = ode45(@current_ode, tspan, I_01, options);

figure(1)
plot(t, I(:,1),'-o', t, I(:,2), '-o')
figure(2)
plot(trk, Irk(1,:),'-o')