x0 = 0;
y0 = 0;
z0 = 0;
xf = 100;
yf = 50;
zf = 150;
t0 = 0;
tf = 5;
ts = .1;

x = genCubTraj(t0,tf,0,0,x0,xf,ts);
y = genCubTraj(t0,tf,0,0,y0,yf,ts);
z = genCubTraj(t0,tf,0,0,z0,zf,ts);

close all
figure
plot(x(:,1),x(:,2),y(:,1),y(:,2),z(:,1),z(:,2));
title('Position versus Time')
xlabel('Time (s)')
ylabel('Position (mm)')
legend('x Position','y Position','z Position')

figure
plot(x(:,1),x(:,3),y(:,1),y(:,3),z(:,1),z(:,3));
title('Velocity versus Time')
xlabel('Time (s)')
ylabel('Velocity (mm/s)')
legend('x Velocity','y Velocity','z Velocity')

figure
plot(x(:,1),x(:,4),y(:,1),y(:,4),z(:,1),z(:,4));
title('Acceleration versus Time')
xlabel('Time (s)')
ylabel('Acceleration (mm/s/s)')
legend('x Acceleration','y Acceleration','z Acceleration')
