function [XNearest, YNearest, Node, distance] = shortestdistance(T, X, Y)
%check distances to nodes in tree and sort
%finds nearest node
dist = [];
[l, b] = size(T);
for i = 1:l
    x = T(i, 1);
    y = T(i, 2);
    eucdist = sqrt((X-x)^2+(Y-y)^2);
    dist = [dist; i, x, y, eucdist];
end 
dist = sortrows(dist, 4);
XNearest = dist(1,2);
YNearest = dist(1, 3);
distance = dist(1,4);
Node =  dist(1,1); %node number of nearest node
end 


