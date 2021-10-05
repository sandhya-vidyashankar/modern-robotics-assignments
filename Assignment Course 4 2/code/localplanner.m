function [Xnew,Ynew, heuristic] = localplanner(XNearest, YNearest, Xsamp, Ysamp)
%find Xnew, YNew at d from Xsamp and Ysamp along the same direction
x1 = XNearest; y1 = YNearest; x2 = Xsamp; y2 = Ysamp;
m = (y2-y1)/(x2-x1);
c = y2 - (m*x2);
d = 0.01;
syms X;
eqn = sqrt((x2 - X)^2 + (y2 - (m*X + c))^2) == d;
X = solve(eqn, X,'Real',true);
Y = m.*X + c;
[Xnew, Ynew] = closertogoal(X, Y, x2, y2); %chooses the closer point for more efficient planning
heuristic = sqrt(((0.5-Xnew)^2)+((0.5-Ynew)^2)); %heuristic is euc dist to goal
end 
