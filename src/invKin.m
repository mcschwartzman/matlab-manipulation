%% Outputs a set of desired joint values given end-effector coordinates

function angles = invKin(ivalue, jvalue, kvalue)

l0 = 20;
l1 = 17;
l2 = 20;

tcam2bot = [cosd(90), -sind(90), 0;
                sind(90), cosd(90), 0;
                0       , 0       , 0];


values =            [ivalue;
                    jvalue;
                    kvalue - l0;];

transformed = tcam2bot * values;

i = transformed(1);
j = transformed(2);
k = transformed(3);

hyp = sqrt((j^2)+(k^2));

theta2 = acosd(((l1^2)+(l2^2)-(hyp^2))/(2*l1*l2));

theta1 = asind((l2*sind(theta2))/hyp) + rad2deg(atan2(k,j));

theta0 = rad2deg(atan2(j,i));

theta2out = theta2 - 90;
theta1out = theta1;
theta0out = 180 - theta0 - 90;

angles = [theta0out;
          theta1out;
          theta2out];

end
