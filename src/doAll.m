

state = 1;

if ~exist('cam', 'var') % connect to webcam iff not connected
    cam = webcam();
    pause(1); % give the camera time to adjust to lighting
end
img = snapshot(cam);
%% Color checking
switch state
    case 0
        
    case 1
        [BW,rgb] = createGreenMask(img);
    case 2
        [BW,rgb] = createYellowMask(img);
    case 3
        [BW,rgb] = createBlueMask(img);
    case 4
        removing;
end

%% Displaying Task Space Region
%imshow(img)
[centers, radii] = imfindcircles(BW,[35 65], 'ObjectPolarity','bright', ...
          'Sensitivity',0.92,'Method','twostage')
%delete(h);
%h = viscircles(centers,radii);
%mark = insertMarker(img, [centers(1,1), centers(1,2)]);

%imshow(mark)

%line([500,500],[0,1200]);%define task space region X
%line([1460,1460],[0,1200]);
%line([0,2000],[1045,1045]);%define task space region Y
%line([0,2000],[390,390]);

%% Keeping track of objects in workspace
tovisit = centers; %grab object locations to visit in list form

centerlist = [0,0]; %create blank list to start

for n = 1: size(tovisit,1)
    if ((centers(n,1) > 500 ) && (centers(n,1) < 1460) && (centers(n,2) < 1045) && centers(n,2) > 390) %check if in TSR
        [centerlist(n,1),centerlist(n,2)] = mn2xy(centers(n,1), centers(n,2));
        centerlist(n,1) = centerlist(n,1) + 17; %translate to robot frame
    end
end

if ((centerlist(1,1) == 0) && (centerlist(1,2) == 0)) %if there is nothing
    state = state + 1;
else % if there is at least one item in the list
    laststate = state;
    state = 4;
end