function [Xsamp, Ysamp] = sample(x2,T, obstacles)
%samples from random value, 10% chance of sample being the goal point
P = rand; %random no. from 0 to 1
inobstacle = true; 
if P>0.1
    while inobstacle == true
        Xsamp = T(end,1)+(x2-T(end,1))*rand; %weighted random X and Y
        Ysamp = T(end,2)+(x2-T(end,2))*rand;
        inobstacle = checkcircle(Xsamp, Ysamp, obstacles);
    end
else
    Xsamp = x2;
    Ysamp = x2;
end 
end  