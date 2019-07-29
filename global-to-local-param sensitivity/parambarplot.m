function parambarplot(tmax,percent,wave)
% user input: 
% tmax= endtime of ode solver 
% percent: percentage to change each parameter, right now we use 5% 
% wave: wave strength (e.g. 0, 0.5, 1, ...)

paramnames = {'sE','sR','Dss','aEm','eta_basal','alpha_eta','beta_eta',...
    'fM','fMa','Jnew','k','b','cnew','e1','e2','alphaB','deltaB','Ghb','R0',...
    'G0','SI',...
    'sigmaI','deltaI','GI','Qpanc','bDE','bIR','aE','aR','Tnaive','bP','ram',...
    'thetaD',...
     'd','bE','bR','muBP','muPB','fD','ftD','muE','muR','muB','Qblood',...
     'mustarSB',...
     'munormalSB','muBSE','aI','aD','Bconv','Qspleen','thetashut'};

LHS =  csvread('LHS.csv'); % call LHS and extract a row from the matrix 
n = size(LHS,1); 

% Apply local sensitivity routine 

for j = 1:n % beginning of looping around LHS matrix
    
    for i = 1:length(paramnames) % beginning of local sensitivity 
    paramnames{i};
    sol = odesolve(tmax,paramnames(i),percent, LHS, j); %solve ODE
    %sol
    plotsol(i,:) = ((sol([1,3])/sol(2))-1)*100; %percent change in glucose 
    %plotsol;    
    end % end of local sensitivity
    
    %plotsol= 2 column matrix whose 1st column is 95% and 2nd is 105%
    
   percentchange = abs(plotsol); %matrix with first column
                                        % is decrease and 2nd is increase
   output(j,:) = max(percentchange,[],2); %maximum absolute change per parameter

    
end % end looping rows of LHS matrix 




 
%  %add labels to plot
% label =  [plotsol, [1:57]']; %Add labels to matrix rows
% [~,idx] = sort(label(:,1),'descend'); % sort just the first column
% sortedmat = label(idx,:)   % sort the whole matrix using the sort indices
% figure
% 
% % create bar plot of output
% inc = bar(sortedmat(:,2),'FaceColor', 'w', 'EdgeColor', 'k');
% hold on
% dec = bar(sortedmat(:,1),'FaceColor', 'k', 'EdgeColor', 'k');
% hold off
% legend('Increased','Decreased');
% ylabel(['Percent Change in Glucose Level After ' num2str(tmax) ' days'],'FontSize',14);
% xlabel('Parameter Changed','FontSize',14);
% title(['Parameters Changed by ' num2str(percent) ' percent'],'FontSize',14)
% 



%set(h,'fontsize',12,'fontname','courier'); %  to change font namae and size
%set(h,{'string'},char('a','b','c','K_T','\delta_T', ...
%              'e/f','f','p','p_N','g_N','K_N','\delta_N', ...
%              'm','\theta','q','r_1','r_2','u','p_I','g_I','j','k','\kappa','K_L','\delta_L', ...
%              '\alpha/\beta','\beta','K_C','delta_C', ...
%              '\gamma', ...
%              '\mu_I','\omega','\phi','\zeta', ...
%              'd','l','s')); % to change ticklabels

% set(gca,'XTick',1:length(paramnames))
% 
% 
% paramlabels = {'1sE','2sR','3Dss','4aEm','5eta_basal','6alpha_eta','7beta_eta',...
%     '8fM','9fMa','10Jnew','11k','12b','13cnew','14e1','15e2','16alphaB','17deltaB','18Ghb','19R0',...
%     '20G0','21SI',...
%     '22sigmaI','23deltaI','24GI','25Qpanc','26bDE','27bIR','28aE','29aR','30Tnaive','31bP','32ram',...
%     '33thetaD',...
%      '34d','35bE','36bR','37muBP','38muPB','39fD','40ftD','41muE','42muR','43muB','44Qblood',...
%      '45mustarSB',...
%      '46munormalSB','47muBSE','48aI','49aD','50Bconv','51Qspleen','52thetashut'};
% 
% set(gca,'XTickLabel',sortedmat(:,3))
% 
% h = twxticklabel;
% %set(h,'fontsize',12,'fontname','courier'); %  to change font namae and size
% set(h,'fontsize',12); %  to change font namae and size
end 
