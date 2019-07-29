function dy = rhs(t,y,fMat,fMt, WaveBin)

% Call param.m script
params;

dy = zeros(12,1);

M = y(1);
Ma = y(2);
Ba = y(3);
Bn = y(4);
B = y(5);
G = y(6);
I = y(7);
D = y(8);
tD = y(9);
E = y(10);
R = y(11);
Em = y(12);

% Eta function --> (6) in the paper;
eta_e = (eta) + (0).*(eta).*(1+(tanh(Ae.*(t-Be.*7))));

% Wave function --> (7) in the paper
if WaveBin == 1
 W = (0.1)*(B)*(exp( -(((t-9)/3)^2)));
else
 W = 0;
end

% K1(G) --> (4) in the paper
K1_G = ((G.^2)/((G.^2)+(Ghb.^2)));

% K2(E,R) --> (5) in the paper
K2_ER = ((sE.*E).^2)/(1+((sE*E).^2)+((sR.*R).^2));

% dM/dt = (1) in the paper
dy(1) = J + (k + b).*(Ma) - c.*M -(fMt).*M.*(Ba)-(fMt).*M.*(Bn) - (e1).*M.*(M+Ma);

% dMa/dt = (2) in the paper
dy(2) = (fMt).*M.*(Ba) + (fMt).*M.*(Bn) - k.*(Ma) - (e2).*(Ma).*(M+(Ma));

% dBa/dt = (8) in the paper
dy(3) = ((Bconv)./(Qpanc)).*(dB).*(B) + ((Bconv)./(Qpanc)).*(eta_e).*(K2_ER).*B + (Bconv/Qpanc).*W - d.*Ba - fMt.*M.*Ba-fMat.*Ma.*Ba - ftD.*Ba.*(Dss-D);

% dBn/dt = (9) in the paper
dy(4) = d.*Ba - fMt.*M.*Bn - fMat.*Ma.*Bn - ftD.*Bn.*(Dss-D) - fD.*D.*Bn;

% dB/dt = (3) in the paper
dy(5) = Ab.*K1_G.*B - dB.*B - eta_e.*K2_ER.*B - W;

% dG/dt = (10) in the paper
dy(6) = R0 - (G0+(SI.*I)).*(G);

% dI/dt = (11) in the paper
dy(7) = (sigmaI).*(K1_G).*B-dI.*I;

% dD/dt = (12) in the paper
dy(8) = ftD.*Bn.*(Dss-D-tD)+ftD.*Bn.*tD-bDE.*E.*D-mD.*D;

% dtD/dt = (13) in the paper
dy(9) = ftD.*Ba.*(Dss-D-tD)+ftD.*Bn.*tD-bIR.*R.*tD-mD.*tD;

% dE/dt = (14) in the paper
dy(10) = aE.*(Tnaive-E) + bP.*((D.*E)./(thetaD+D)) - ram.*E + bE.*D.*Em - mE.*E.*R;

% dR/dt = (15) in the paper
dy(11) = aR.*(Tnaive-R) + bP.*((tD.*R)/(thetaD+tD)) - ram.*R + bR.*D.*Em - mR.*E.*R;

%dEm/dt = (16) in the paper
dy(12) = ram.*(E+R) - (aEm+bE.*D+bR.*tD).*Em;

end
