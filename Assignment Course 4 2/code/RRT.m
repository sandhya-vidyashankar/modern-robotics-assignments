function [edges, nodes, path] = RRT
%returns RRT for given set of obstacles
%calls on 5+ functions
obstacles = readmatrix('obstacles.csv'); %read obstacles into a matrix
x1 = -0.5; %set start points
y1 = -0.5;
x2 = 0.5; %set goal points
y2 = 0.5;
edges =[]; %initialise edges
h = sqrt(((x2-x1)^2)+((y2-y1)^2));
T = [x1, y1, h]; %add start points to tree T
counter = 0;
lim = 100;
rng(1); %random seed for consistent results
while counter<lim
   counter %print number of iterations
   [Xsamp, Ysamp] = sample(x2,T, obstacles); %initialise random coordinates that are not in obstacle
   [XNearest, YNearest, NearestNode, distance] = shortestdistance(T, Xsamp, Ysamp); %find nearest node
   [Xnew,Ynew, heuristic] = localplanner(XNearest, YNearest, Xsamp, Ysamp); %local planner gives New in direction of Samp
   collides = collisioncheck(Xnew, Ynew, XNearest, YNearest, obstacles); %checks for collision
   if collides == false
        T = [T; Xnew, Ynew, heuristic]; %appends to tree
        edges = [edges; NearestNode, length(T), distance]; %adds edge
        if Xnew >= (0.49) && Ynew >= 0.49 %if in goal region
            fprintf("Success"); %display success 
            break %exit loop
        end   
   end 
    counter = counter + 1; %add to counter 
end 
nodes = [1:length(T)].'; %adds column for no. of nodes
nodes = [nodes, T]; %adds x, y, etc from Tree matrix
writematrix(nodes,'nodes.csv') %converts to csv
writematrix(edges,'edges.csv')
path = astar(nodes, edges); %uses astar for path 
writematrix(path, 'paths.csv')
end 



        
        