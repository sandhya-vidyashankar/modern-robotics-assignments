function inobstacle = checkcircle(X, Y, obstacles)
%checks if point is in the obstacle
for i = 1:length(obstacles)
eucdist = sqrt((X-obstacles(i,1))^2+(Y-obstacles(i,2))^2);
if eucdist <= obstacles(i,3) %if distance to centre is lesser than radius
    inobstacle = true;
    break
else 
    inobstacle = false;
end
end
end
    