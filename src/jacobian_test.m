function vel = jacobian_test(joint0,joint1,joint2)

syms q0 q1 q2

%   lengths of robot arm links
l0 = 20;
l1 = 17;
l2 = 20;

q0offset = 0;
q1offset = 0;
q2offset = -90; % may change to neg 90

i = (l1*cos(q1) + l2*cos(q2 + q2offset + q1))*sin(q0);  %i component
j = (l1*cos(q1) + l2*cos(q2 + q2offset + q1))*cos(q0); %j component
k = l1*sin(q1) + l2*sin(q2 + q2offset + q1) + l0;  %k component

jac = jacobian([i,j,k],[q0,q1,q2]); %symbolically find the jacobian

sol0 = inv(jac);    %invert the jacobian

sol1 = subs(sol0, q0, deg2rad(joint0));
sol2 = subs(sol1, q1, deg2rad(joint1));
solv = subs(sol2, q2, deg2rad(joint2));

%double(solv)

speedVector = double(solv);  % resultant velocity vector

vel = rad2deg(speedVector); % final angular speed in degrees

end