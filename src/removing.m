%% Removal State


for obj = 1:size(centerlist, 1)
    
    switch process
        case 0 %goto process
            centerloc = [centerlist(obj,1);
                centerlist(obj,2);
                4];
            
            goToCoords = centerloc
            goToCoords(3) = 10;
            
            pause(0.2);
            %need a delay somehow here
            process = 1;
            
        case 1 %ready process
            centerloc = [centerlist(obj,1);
                centerlist(obj,2);
                4];
            
            goToCoords = centerloc
            goToCoords(3) = 5;
            
            pause(0.2);
            process = 2;
            
        case 2 %grip process
            % PWM signal for servo
            grip = 1;
            
        case 3 %weigh process
            %move to a point, record weight value of objectr
            
        case 4 %
            %if weight is greater than.. move to +y coordinate of
            %assocaited location, else go to -y coordinate 
            grip = 0;
    
    
    
    
    
end