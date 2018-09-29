%set plot pos based on input
function plotvalues(input,R)

 % initalize 0 value 
% for example 300 = 0 angle
% 280 = 45 angle
% 330 = 90 angle
% calculate the equations for each 0 degree angle with input encoder
% equation y=mx+b

    if (input >= 330)
        input = 330;
    end

    if (input>=280 && input<=330)% angle 0 to 90 changed by Yang
        R.x=input*(-.015)+4.95;
        R.y=input*(.005)-.65;
        % Change the x and y data in R.handle 
        set(R.handle,'XData',[0;R.x],'YData',[0;R.y]);
        elseif(input>=230 && input<280) % angle 45 to 0changed by Yang
        R.x=input*(-.005)+2.15;  
        R.y=input*(.015)-3.45;
         % Change the x and y data in R.handle 
        set(R.handle,'XData',[0;R.x],'YData',[0;R.y]);
    else
        print('Input Values cannot calculate, over 90 deg');
    end
end
