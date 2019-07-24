%Main file to run for local parameter sensitivity using LHS matrix
%Simply press run, but this takes a long time to run

tmax = 280; %runtime for the simulations
percent = 5; %percent change for parameters

LHS = readmatrix('LHS.csv'); %Load LHS matrix

paramnames = {'sE','sR','Dss','aEm','eta_basal','alpha_eta','beta_eta','fM',...
    'fMa','J','k','b','c','e1','e2','alphaB','deltaB','Ghb','R0','G0','SI',...
    'sigmaI','deltaI','GI','Qpanc','bDE','bIR','aE','aR','Tnaive','bP','ram',...
    'thetaD','d','bE','bR','muPB','muBP','fD','ftD','muE','muR','muB','Qblood',...
    'mustarSB','munormalSB','muBSE','aI','aD','Bconv','Qspleen','thetashut','deltamu'};

output = zeros(2*length(LHS),length(paramnames)); % Create template output matrix



for i = 1:10 %loop through each row in LHS matrix
    data = parambarplot(tmax,percent,LHS(i,:)); % simulate with params
    data = data'; %
    output(i,:) = data(1,:);
    output(2*i,:) = data(2,:);
end
avg = mean(abs(output));
avg = avg';

label = [avg, [1:length(paramnames)]'];
[~,idx] = sort(abs(label(:,1)),'descend'); % sort just the first column
sortedmat = label(idx,:)   % sort the whole matrix using the sort indices
figure
bar(sortedmat(:,1))
ylabel(['Percent Change in Glucose Level After ' num2str(tmax) ' days'],'FontSize',14);
xlabel('Parameter Changed','FontSize',14);
title(['Parameters Changed by ' num2str(percent) ' percent'],'FontSize',14)

set(gca,'XTick',1:length(paramnames))
set(gca,'XTickLabel',sortedmat(:,2))