function [t,y] = RK4(fun, tspan, N, y0 )
h=(tspan(end)-tspan(1))/N;
t=tspan(1):h:tspan(end);
y=y0; %Must be a column vector
    for i=1:N    
        f1=fun(t(i),y(:,i));    
        f2=fun(t(i)+h/2,y(:,i)+h/2*f1);    
        f3=fun(t(i)+h/2,y(:,i)+h/2*f2);    
        f4=fun(t(i)+h,y(:,i)+h*f3);    
        y(:,i+1)=y(:,i)+h/6*(f1+2*f2+2*f3+f4);
    end
end