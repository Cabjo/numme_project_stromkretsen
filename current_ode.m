function dIdt = current_ode(t,I)
% dIdt = [I(2); (1-I(1)^2)*I(2)-I(1)];

L_0 = 1;
C = 1*1e-6;
dIdt = [I(2); 2*I(1)/(1+I(1)^2)*I(2)^2-I(1)*((1+I(1)^2)/(L_0*C))];