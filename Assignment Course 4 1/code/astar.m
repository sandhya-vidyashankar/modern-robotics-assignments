function [path] = astar
nodes = readmatrix('nodes.csv'); %converting csv files to matrices
nodes = sortrows(nodes, 1); %sort the nodes matrix by the first column 
eedges = readmatrix('edges.csv');
eedges = sortrows(eedges, [1 2]); %sort edges by first column, use second column as a tie breaker
open = [nodes(1,:)]; %moving the first row of nodes matrix to open
closed = []; %initialising closed
parent = zeros(length(nodes), 1); 
past_cost= zeros(length(nodes), 1); %initialise past cost
past_cost(1) = 0;
past_cost(2:length(nodes))= inf;
goal = nodes(end,:); %set goal as the last row of nodes matrix
PATHS{1} = []; %set path to first element as none
while numel(open)>0
    current = open(1,:); %set current
    curr = round(current(1,1)); %curr is the first element of current (the current nodeZ)
    open(1,:) = []; %delete current from open
    [nbr, returncost] = findneighbour(current(1,1), eedges); %calls on custom function to return a list of neighbours and a list of costs indexed to each neighbour
    closed = [closed; current]; %add current to closed
    for i = 1:length(nbr)
        for nb = nbr(i) %for an element in the neighbours list
        if checkelements(nb, closed(:, 1)) == false %uses custom function checkelements to see if nb is in closed
            nb = round(nb); %rounds nb an integer value
            tentative_past_cost = past_cost(curr) + returncost(nb); 
            if tentative_past_cost < past_cost(nb)
                past_cost(nb) = tentative_past_cost;
                parent(nb) = curr; 
                PATHS{nb} = [PATHS{curr}, curr]; %sets path to this element
                nb = nodes(round(nb),:); %gives node nb the row value from the nodes matrix
                nb(1,4) = nb(1,4) + past_cost(round(nb(1,1))); %updates heuristic cost with past cost for easy sorting
                open = [open; nb]; %adds updated row to open list
                open = sortrows(open, 4); %sorts open as per the 4th column(i.e. the costs)
            end 
        end  
    end 
    end
end 
path = [PATHS{round(goal(1,1))}, round(goal(1,1))]; %returns path to goal
writematrix(path,'path.csv'); %writes to csv
end 
    
                    
                    
                    
            
    
    