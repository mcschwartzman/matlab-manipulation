%   Created by Mathew Schwartzman on 7 September 2017

function another = fwdKin(R,linea,q0,q1,q2)   %takes in arm joint angles
xline = linea(1,1);
yline = linea(2,1);
zline = linea(3,1);
%   lengths of robot arm links
l0 = 20;
l1 = 17;
l2 = 20;

%q0 = -q0;

q0offset = 0;
q1offset = 0;
q2offset = -90; % may change to neg 90

a = 0;
a(2,:) = 0;
a(3,:) = 20;

b = l1*cosd(q1) * sind(q0);     %switch with next
b(2,:) = l1*cosd(q1) * cosd(q0);
b(3,:) = l1*sind(q1) + l0;

c = (l1*cosd(q1) + l2*cosd(q2 + q2offset + q1))*sind(q0);  %i component
c(2,:) = (l1*cosd(q1) + l2*cosd(q2 + q2offset + q1))*cosd(q0); %j component
c(3,:) = l1*sind(q1) + l2*sind(q2 + q2offset + q1) + l0;  %k component

%   a = [i ; j ; k];

x = [0, a(1), b(1), c(1)];
y = [0, a(2), b(2), c(2)];
z = [0, a(3), b(3), c(3)];

if(xline(1:end)==0)
xline = [c(1,:)];
yline = [c(2,:)];
zline = [c(3,:)];
else
xline = linea(1,:);
yline = linea(2,:);
zline = linea(3,:); 
xline = [xline(1,:), c(1,:)];
yline = [yline(1,:), c(2,:)];
zline = [zline(1,:), c(3,:)];
end
%'XData',[0;y(:,1)],'YData',[
set(R.handle(1),'XData',x,'YData',y,'ZData',z,'LineWidth',4,'MarkerSize',10,'MarkerFaceColor','b');
set(R.handle(2),'XData',xline,'YData',yline,'ZData',zline,'LineWidth',2,'MarkerSize',5,'MarkerFaceColor','r');
%set(R.handle,x,y,z,'LineWidth',2,'MarkerSize',5,'MarkerFaceColor','r');
%rotate3d on;
%another = 0;
another= [xline(1:end); yline(1:end); zline(1:end)];
end