function [x1, y1] = closertogoal(X, Y, x2, y2)
%returns x1, y1, by seeing which solution of X and Y are closer to the goal
dist=[];
if ~isscalar(X) && numel(X)>0
    for j = 1:length(X)
        eucdist = sqrt((X(j)-x2)^2+(Y(j)-y2)^2);
        dist(j,:) = [j, eucdist];
    end 
    dist = sortrows(dist, 2);
    j = dist(1,1);
    x1 = single(X(j)); %converts values to decimals
    y1 = single(Y(j));
else isscalar(X)
    x1 = single(X);
    y1= single(Y);
end 
end 