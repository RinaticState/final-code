function formLHS(sizemat)


%prepare grid of parameters values a_e, b_e
n = sizemat;

% set a lower-bound and upper-bound for alpha-eta parameter
alpha_min = 0.01;
alpha_max = 0.4;

% set a lower-bound and upper-bound for beta-eta parameter
beta_min = 7;
beta_max = 35;

%-----------------------------------

alpha = sort(LHS_Uniform(alpha_min,alpha_max,n)); %generate random number for alphamin and alphamax for a certain amount
beta = sort(LHS_Uniform(beta_min,beta_max,n));
[f1, f2] = meshgrid(alpha, beta); %stretch matrices out in vector
% 

%-------- putting them into vector
f1 = reshape(f1, [], 1); 
f2 = reshape(f2, [],1);
LHS = [f1 f2]; %store them in a matrix

%----- Save as LHS.csv

csvwrite('LHS.csv',LHS);

end 