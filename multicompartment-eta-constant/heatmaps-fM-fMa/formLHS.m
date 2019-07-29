function formLHS(sizemat)


%prepare grid of parameters values fM, fMa
n = sizemat;

% set a lower-bound and upper-bound for both the fM and fMa parameters
f_min = 0.1;
f_max = 2;

%-----------------------------------

fMa = sort(LHS_Uniform(f_min, f_max, n)); %generate random number for alphamin and alphamax for a certain amount
fM = sort(LHS_Uniform(f_min, f_max, n));
[f1, f2] = meshgrid(fMa, fM); %stretch matrices out in vector
% 

%-------- putting them into vector
f1 = reshape(f1, [], 1); 
f2 = reshape(f2, [],1);
LHS = [f1 f2]; %store them in a matrix

%----- Save as LHS.csv

csvwrite('LHS.csv',LHS);

end 