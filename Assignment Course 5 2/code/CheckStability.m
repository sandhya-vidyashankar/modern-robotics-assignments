function [isstable] = CheckStability(bodylist,contactlist)
%takes a matrix of bodies (with columns x, y, centre of mass, total mass)
nbody = size(bodylist,1);
ncontact = size(contactlist,1);
g = 9.81;
%initialise Fr cone
F = zeros(3*nbody, 2*ncontact);
%initialise Fext
Fext = [];
%values from bodylist [body no., mass, x, y]
%calculate Fext
for i = 1:nbody
    G = [bodylist(i, 3); bodylist(i,4); 0]; %centre of mass
    W = bodylist(i,2)*g; %weight
    N = W.*[0; -1; 0]; %g acts in -y direction
    Fext = [Fext; cross(G,N); N(1); N(2)];
    
%values from contact list [body1, body2, xc, yc, theta, mu]
%calculate F
for j = 1:ncontact
    %defines bodies b1 and b2 in contact, also theta, mu and alpha
    b1 = contactlist(j, 1);
    b2 = contactlist(j, 2);
    theta = contactlist(j, 5);
    mu = contactlist(j, 6);
    alpha = atan2(mu);
    contactpt = [contactlist(j,2); contactlist(j, 3); 0];
    %if the contact points are not the ground(ie not 0)
    if b1 ~= 0
        angle1 = theta + alpha; %angles of wrench cones
        angle2 = theta - alpha;
        n1 = [cos(angle1); sin(angle1); 0]; %normals
        n2 = [cos(angle2); sin(angle2); 0];
        F1 = [cross(contactpt, n1); n1]; %wrenches
        F2 = [cross(contactpt, n2); n2];
        F((b1 - 1)*3 + 1:(b1*3),(j - 1) * 2 + 1) = F1; %place wrenches in larger matrix
        F((b1 - 1)*3 + 1:(b1*3),(j - 1) * 2 + 2) = F2;
    end 
    if b2 ~=0 %repeat procedure
        angle1 = theta + alpha + pi;
        angle2 = theta - alpha + pi;
        n1 = [cos(angle1); sin(angle1); 0];
        n2 = [cos(angle2); sin(angle2); 0];
        F1 = [cross(contactpt, n1); n1];
        F2 = [cross(contactpt, n2); n2];
        F((b2 - 1)*3 + 1:(b2*3),(j-1)*2+1) = F1; 
        F((b2 - 1)*3 + 1:(b2*3),(j-1)*2+2) = F2;
    end   
end 

%linprog to find k
    f = ones(1, 2*ncontact);
    A = -1.* eye(2 * ncontact);
    b = -1.*f;
    Aeq = F;
    beq = -1.*Fext;
    k = linprog(f,A,b,Aeq,beq);
%see if stable based on wether k exists
if numel(k)>0
    isstable = true;
    k %display k
else 
    isstable = false;
end 

end

