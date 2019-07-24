function sol = odesolve(tmax,parname,percent,params)

IC = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.77*10^5, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 10];

sE = params(1);
sR = params(2);
Dss = params(3);
aEm = params(4);
eta_basal = params(5);
alpha_eta = params(6);
beta_eta = params(7);
fM = params(8);
fMa = params(9);
J = params(10);
k = params(11);
b = params(12);
c = params(13);
e1 = params(14);
e2 = params(15);
alphaB = params(16);
deltaB = params(17);
Ghb = params(18);
R0 = params(19);
G0 = params(20);
SI = params(21);
sigmaI = params(22);
deltaI = params(23);
GI = params(24);
Qpanc = params(25);
bDE = params(26);
bIR = params(27);
aE = params(28);
aR = params(29);
Tnaive = params(30);
bP = params(31);
ram = params(32);
thetaD = params(33);
d = params(34);
bE = params(35);
bR = params(36);
muPB = params(37);
muBP = params(38);
fD = params(39);
ftD = params(40);
muE = params(41);
muR = params(42);
muB = params(43);
Qblood = params(44);
mustarSB = params(45);
munormalSB = params(46);
muBSE = params(47);
aI = params(48);
aD = params(49);
Bconv = params(50);
Qspleen = params(51);
thetashut = params(52);
deltamu = 0.1;

wave = 1;
noWave = 0;

PP = 0;
eval(['PP = ' parname{1} ';'])

for i = -1:1
    
    eval([parname{1} '= (1+i*(' num2str(percent) '/100))*PP;'])
    
    % Solve the Model to TMAX days
    options = odeset('Refine',1,'RelTol',1e-9);
    [t,y] = ode15s(@(t,y)rhs(t, y, fMa, fM, wave),[0;tmax],IC,options);
    
    plott{i+2} = t;
    plotsol{i+2} = y(:,22);
    sol(i+2) = y(end,22);
end

% UNCOMMENT CODE TO PLOT DIFFERENCES IN TUMOR SIZE (OR ANOTHER ONE
% POPULATION)
% figure
% 
% semilogy(plott{1}, plotsol{1}, '-', ...
%          plott{2}, plotsol{2}, '-', ...
%          plott{3}, plotsol{3}, '-', 'LineWidth', 3);
% 
% legend('Decreased', 'Standard', 'Increased');
% ylabel('States (Logarithmic Scale)');
% xlabel('Time (days)');
% ylim([1,1e12]);    

% UNCOMMENT TO PLOT THE 6 POPULATIONS (UNVARIED) AND VIEW THE SIMULATION
% figure
% 
% semilogy(t, y(:,1), '-', ...
%          t, y(:,2), '-', ...
%          t, y(:,3), '-', ...
%          t, y(:,4), '-', ...
%          t, y(:,5), '-', ...
%          t, y(:,6), '-', 'LineWidth', 3);
%  
% title(case_name);
% legend('Tumor', 'Natural Killers', 'CD8+ T Cells','Circulating Lymphocytes', 'Medicine','IL-2');
% ylabel('States (Logarithmic Scale)');
% xlabel('Time (days)');
% ylim([1,1e12]);

return

    function dy = rhs(t, y ,fMat, fMt, WaveOn)

    dy = zeros(23,1);
    
    Ds = y(1);
    tDs = y(2);
    Es = y(3);
    Rs = y(4);
    Ems = y(5);

    Db = y(6);
    tDb = y(7);
    Eb = y(8);
    Rb = y(9);
    Emb = y(10);
    Mb = y(11);

    B = y(12);
    Ba = y(13);
    Bn = y(14);

    Dpanc = y(15);
    tDpanc = y(16);
    Epanc = y(17);
    Rpanc = y(18);
    Empanc = y(19);

    M = y(20);
    Ma = y(21);

    G = y(22);
    I = y(23);

    % Wave function --> (included as supplementary equation in 4.13)
    W = WaveOn*.1*B*exp(-((t-9)/9)^2);

    %eta_vary function
    eta_vary = eta_basal+2*eta_basal*(1 + tanh(alpha_eta*(t - beta_eta*7)));

    %muSB(D)
    muSB_D = mustarSB + deltamu/(1+Ds/thetashut);

    %muSB(tD)
    muSB_tD = mustarSB + deltamu/(1+tDs/thetashut);
    
    % dDs/dt = (4.1) in the GW thesis
    dy(1) = muB*(Qblood/Qspleen)*Db - aD*Ds - bDE*Ds.*Es;

    % dtDs/dt = (4.2) in the GW thesis
    dy(2) = muB*(Qblood/Qspleen)*tDb - aI*tDs - bIR*tDs.*Rs;

    % dEs/dt = (4.3) in the GW thesis
    dy(3) = muBSE*(Qblood/Qspleen)*Eb - muSB_D.*Es + bE*Ds*Ems...
        + aE*((Tnaive/Qspleen)-Es) - muE*Es.*Rs - ram*Es + bP*((Ds.*Es)./(thetaD+Ds));

    % dRs/dt = (4.5) in the GW thesis
    dy(4) = muBSE*(Qblood/Qspleen)*Rb - muSB_tD.*Rs + bR*tDs.*Ems + aR*((Tnaive/Qspleen) - Rs)...
        - muE*Es.*Rs - ram*Rs + bP*(tDs.*Rs)./(thetaD + tDs); %muR = muE, recycled value


    % dEms/dt = (4.6) in the GW thesis
    dy(5) = muBSE*(Qblood/Qspleen)*Emb - muSB_D.*Ems + ram*(Es+Rs) - (aEm+bE*Ds+bR*tDs).*Ems;

    % dDb/dt = (4.7) in the GW thesis
    dy(6) = -muB*Db + muPB*(Qpanc/Qblood)*Dpanc;

    % dtDb/dt = (4.8) in the GW thesis
    dy(7) = -muB*tDb + muPB*(Qpanc/Qblood)*tDpanc;

    % dEb/dt = (4.9) in the GW thesis
    dy(8) = muSB_D.*(Qspleen/Qblood)*Es + muPB*(Qpanc/Qblood)*Epanc - (muBP + muBSE)*Eb;

    % dRb/dt = (4.10) in the GW thesis
    dy(9) = muSB_tD.*(Qspleen/Qblood).*Rs + muPB*(Qpanc/Qblood)*Rpanc - (muBP + muBSE)*Rb;

    % dEmb/dt = (4.11) in the GW thesis
    dy(10) = muSB_D.*(Qspleen/Qblood)*Ems + muPB*(Qpanc/Qblood)*Empanc - (muBP+muBSE)*Emb;

    % dMb/dt = (4.12) in the GW thesis
    dy(11) = -J + c*(Qpanc/Qblood)*M;

    % dB/dt = (4.13) in the GW thesis
    dy(12) = (alphaB*G.^2./(G.^2+Ghb^2)).*B - deltaB*B - W...
        - eta_vary*((sE*Epanc).^2./(1+(sE*Epanc).^2+(sR*Rpanc).^2)).*B;

    % dBa/dt = (4.14) in the GW thesis
    dy(13) = W*Bconv/Qpanc + eta_vary*((sE*Epanc)^2./(1+(sE*Epanc).^2 + (sR*Rpanc).^2)).*B*Bconv/Qpanc...
        - fMt*M.*Ba-fMat*Ma.*Ba - d*Ba + deltaB*B*Bconv/Qpanc - ftD*(Dss-Dpanc).*Ba - fD*Dpanc.*Ba;

    % dBn/dt = (4.15) in the GW thesis
    dy(14) = d*Ba-fMt*M.*Bn - fMat*Ma.*Bn - ftD*(Dss-Dpanc).*Bn - fD*Dpanc.*Bn;

    % dDpanc/dt = (4.16) in the GW thesis
    dy(15) = ftD*Bn.*(Dss - Dpanc) - muPB*Dpanc;

    % dtDpanc/dt = (4.17) in the GW thesis
    dy(16) = ftD*Ba.*(Dss - Dpanc - tDpanc) - ftD*Bn.*tDpanc - muPB*tDpanc;

    % dEpanc/dt = (4.18) in the GW thesis
    dy(17) = muBP*Eb*(Qblood/Qpanc) - muPB*Epanc;

    %dRpanc/dt = (4.19) in the GW thesis
    dy(18) = muBP*Rb*(Qblood/Qpanc) - muPB*Rpanc;

    %DEmpanc/dt = (4.20) in the GW thesis
    dy(19) = muBP*Emb*(Qblood/Qpanc) - muPB*Empanc;

    %dM/dt = (4.21) in the GW thesis
    dy(20) = J*(Qblood/Qpanc) + (k+b)*Ma-c*M - fMt*M.*Ba - fMt*M.*Bn - e1*M.*(M+Ma);

    %dMa/dt = (4.22) in the GW thesis
    dy(21) = fMt*M.*Ba + fMt*M.*Bn - k*Ma - e2*Ma.*(M+Ma);

    %dG/dt = (4.23) in the GW thesis
    dy(22) = R0 - (G0 + (SI*I)).*G;

    %dI/dt = (4.24) in the GW thesis
    dy(23) = sigmaI*(G.^2/(G.^2 + GI.^2))*B - deltaI*I;
    end

end

