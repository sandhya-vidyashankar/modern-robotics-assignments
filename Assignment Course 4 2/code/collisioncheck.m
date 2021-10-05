function collides = collisioncheck(Xnew, Ynew, XNearest, YNearest, obstacles)
%checks if line between nodes collides with obstacle
x1 = XNearest; y1 = YNearest; x2 = Xnew; y2 = Ynew;
m = (y2-y1)/(x2-x1);
c = y2 - (m*x2);
collides = false;
for i = 1:length(obstacles)
    x = obstacles(i, 1);
    y = obstacles(i,2);
    r = 0.2;
    %if any point satisfies both circle eq and line eq
    syms X
    eqn = (X - x)^2 + ((m*X+c)-y)^2 - r^2<= 0;
    X = solve(eqn, X,'Real',true); %checks if there are real values for the LINE and the circle
    Y = m.*X + c;
    if numel(X)>0 
        for i = 1:length(X)
            if X(i)<max(x1,x2) && X(i)>min(x1,x2) && Y(i)>min(y1,y2) && Y(i)<max(y1,y2)
                collides = true; %only returns true if the values lie within the LINE SEGMENT
                break
            end
        end 
    else 
        collides = false;
    end 
end 