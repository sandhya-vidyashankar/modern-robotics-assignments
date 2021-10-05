function isformclosure = formclosure(points)
%returns true or false for the formclosure when points are specified as a
%matrix with row [x, y, n] where n = angle with the x axis
%if points are a csv file use fn points = readmatrix('filename.csv')
xlist = points(:, 1); %extracts, x, y, z from points matrix
ylist = points(:, 2);
thetalist = points(:, 3);
[j, l] = size(points); %j and arbitrary value l for size of points
F = zeros(3,j); %initialise f
isformclosure = false; %initialise formclosure as false
for i = 1:j
    x = xlist(i);
    y = ylist(i);
    theta = thetalist(i);
    p = [x, y].'; %position
    n = [round(cos(theta)), round(sin(theta))].'; %normal in terms of theta
    miz = (p(1,1)*n(2,1)) - (p(2,1)*n(1,1)); %calculates miz
    F(:,i) = [miz; n]; %represents F
end 
%initialisation for linear programming in general terms 
Aeq = F; 
beq= zeros(3,1);
f = ones(1, j);
b = -1*ones(1,j);
A = diag(b);
%calls on linprog inbuilt fn to find k
k = linprog(f,A, b, Aeq,beq);
if numel(k)>0 && rank(F)==3 %checks that k is real and rank of F is 3 (since planar)
    k %displays k
    isformclosure = true;
end 



    


