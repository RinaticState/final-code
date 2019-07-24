function plotsol =  parambarplot(tmax,percent,params)

paramnames = {'sE','sR','Dss','aEm','eta_basal','alpha_eta','beta_eta','fM',...
    'fMa','J','k','b','c','e1','e2','alphaB','deltaB','Ghb','R0','G0','SI',...
    'sigmaI','deltaI','GI','Qpanc','bDE','bIR','aE','aR','Tnaive','bP','ram',...
    'thetaD','d','bE','bR','muPB','muBP','fD','ftD','muE','muR','muB','Qblood',...
    'mustarSB','munormalSB','muBSE','aI','aD','Bconv','Qspleen','thetashut','deltamu'};

% paramnames = {'1sE','2sR','3Dss','4aEm','5eta_basal','6alpha_eta','7beta_eta','8fM',...
%     '9fMa','10J','11k','12b','13c','14e1','15e2','16alphaB','17deltaB','18Ghb','19R0','20G0','21SI',...
%     '22sigmaI','23deltaI','24GI','25Qpanc','26bDE','27bIR','28aE','29aR','30Tnaive','31bP','32ram',...
%     '33thetaD','34d','35bE','36bR','37muPB','38muBP','39fD','40ftD','41muE','42muR','43muB','44Qblood',...
%     '45mustarSB','46munormalSB','47muBSE','48aI','49aD','50Bconv','51Qspleen','52thetashut','53deltamu'};
          
for i = 1:length(paramnames)
    
    paramnames{i};
    sol = odesolve(tmax,paramnames(i),percent,params);
    plotsol(i,:) = ((sol([1,3])/sol(2))-1)*100;
    plotsol;
    
end


inc = plotsol(:,2);
dec = plotsol(:,1);


