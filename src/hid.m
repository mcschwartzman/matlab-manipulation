
javaaddpath('../lib/hid4java-0.5.1.jar');

import org.hid4java.*;
import org.hid4java.event.*;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.lang.*;
%returnValuesStatus;
pp = PacketProcessor(7);
% create string array for csv file
stringarray = ["Joint Angle 1","Joint Angle 2", "Joint Angle 3", ...
    "Velocity Arm 1", "Velocity Arm 2", "Velocity Arm 3",...
    "Torque 1","Torque 2", "Torque 3"];

% print string to csv file using fprintf
 fid = fopen('StatusValues_toWrite.csv', 'w');
 fprintf(fid, '%s,', stringarray);
 %print new line to csv file
 stringname = '';
 fprintf(fid, '%s\n', stringname);
 % close fprintf
 fclose(fid) ;
xline = [0;0;0];

%% Control robot arm construction in visualization
 % initalize robot arm as a function
Robot.arm = 1; % arm length for simulation 
Robot.x = 0; % simulated length in the x direction
Robot.y = 0; % simulated length in the y direction
Robot.z = 0;
% Initializing figure
figure(); % Open figure 
axes; % Add axes environment 
hold on; % Hold on the objects in axes
axis equal; % Set the coordinates to be equal
box on; % box around axes 
grid on;  % display grid lines 
axis(60*[-1 1 -1 1 0 1]); % Set axes limits
%title('Robot 1 Link Arm'); % title

% Set "handle" field in "Robot" structure to be the handle to the arm plot
Robot.handle = plot3(Robot.x,Robot.y,Robot.z,Robot.x,Robot.y,Robot.z);%'LineWidth',4,'MarkerSize',10,'MarkerFaceColor','c',...
   %'LineWidth',2,'MarkerSize',5,'MarkerFaceColor','r' );
        drawnow();

values = zeros(15, 1, 'single'); % set values to '0's
%read values in from another csv file

grip = 0;

while(1)
    
    % send command to packet processor
     tic;
     returnValuesStatus = pp.command(37, values);
     toc;
    
    swivel = returnValuesStatus(1);
    shoulder = returnValuesStatus(4);
    elbow = returnValuesStatus(7);
    
    doAll;
    
    removing;
    
    gotox = goToCoords(1);
    gotoy = goToCoords(2);
    gotoz = 10;
    
    desAng = invKin(gotox, gotoy, gotoz);
    
    desAng = desAng * 11.4;
    
    values(1) = desAng(1); % this is the value for angle0
    values(4) = desAng(2); % angle1
    values(7) = desAng(3); % angle2
    
    values(2) = grip;
    values(5) = grip;
    values(8) = grip;
    
    values(3) = 0;
    values(6) = 0;
    values(9) = 0;
    % send command to packet processor
     tic;
     returnValuesStatus = pp.command(37, values);
     %disp(returnValuesStatus)
     toc;
     % change to next point on triangle when last point is within
     % tollerance.

   % write to csv file
    dlmwrite("StatusValues.csv", transpose(returnValuesStatus(1:9)),'-append');
     % draw plots
     xline=fwdKin(Robot,xline,(returnValuesStatus(1)*0.08), (returnValuesStatus(4)*0.08), (returnValuesStatus(7)*0.08));
     drawnow();

     pause(0.2); % pause to allow robot to move
     
     %timestep = timestep + 1;
     
end
pp.shutdown()
% clear java;
