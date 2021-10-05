function [nbr,returncost] = findneighbour(curr, eedge)
%returns neighbour and map of costs for a given node and the edges matrix
nbr = []; %initialise
cost = [];
for i = 1:length(eedge) %rows
    for j = 1:2 %columns
        if eedge(i,j) == curr(1,1) %checks if curr is present in edge and appends to nbr list
            if j ==1
                nbr = [nbr; eedge(i, 2)];
            else
                nbr = [nbr; eedge(i, 1)];
            end 
            cost = [cost, eedge(i, 3)]; %gives cost matrix for that element
        end 
    end 
end 
returncost = containers.Map(nbr, cost); %nbr is the key to call cost (similar to dict in python)
end 

