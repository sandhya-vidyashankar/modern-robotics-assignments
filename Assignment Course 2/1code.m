function [thetalist] = IKinBodyIterates(Blist, M, T, thetalist0, eomg, ev)
%call the function using [thetalist] = IKinBodyIterates(Blist, M, T, thetalist0, eomg, ev)
thetalist = thetalist0; %initialises to first guess
allthetalist = thetalist0.'; %initialises list of all thetalist values
i = 0; %iterations
maxiterations = 20;
Vb = se3ToVec(MatrixLog6(TransInv(FKinBody(M, Blist, thetalist)) * T)); %initialises error twists Vb
err = norm(Vb(1: 3)) > eomg || norm(Vb(4: 6)) > ev; %error is returned as a true or false value
while err && i < maxiterations %loop initialised for for 'true' error 
    fprintf('Iteration: %i \n', i) %print iteration
    fprintf('Joint vector: \n') %print joint vector
    thetalist = thetalist + pinv(JacobianBody(Blist, thetalist)) * Vb
    i = i + 1;
    fprintf("End effector config: \n")
    Tthetai = FKinBody(M, Blist, thetalist) %returns T for a given value of theta i
    fprintf("error twist: \n")
    Vb = se3ToVec(MatrixLog6(TransInv(FKinBody(M, Blist, thetalist)) * T))
    fprintf("linear error magnitude:%d \n", norm(Vb(4: 6))) %linear error
    fprintf("angular error magnitude: %d \n\n", norm(Vb(1: 3))) %angular error
    err = norm(Vb(1: 3)) > eomg || norm(Vb(4: 6)) > ev; %checks error
    allthetalist = [allthetalist; thetalist.']; %matrix containing all values of theta
end
writematrix(allthetalist, 'iterates.csv') %outputs matrix as csv file that gets saved to current folder
end

