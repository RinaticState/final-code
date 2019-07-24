%% The results should be compared to the PRCC results section in
%% Supplementary Material D and Table D.1 for different N (specified by
%% "runs" in the script below
clear all;
close all;

%% Sample size N
runs=10000;

%% LHS MATRIX  %%
% make vectors of parameter values 

Parameter_settings_LHS;
%PRCC_var={'sE', 'sR','D_{ss}','a_{Em}','\eta_{basal}','\alpha_e','\beta_e',...
%    'f_m', 'f_{ma}','J','k','b','c','e_1','e_2','\alpha_B','\delta_B','G_{hb}',...
%    'R_0','EG0','S_I','\sigma_I','\delta_I','GI','Q_{panc}','\mu_{PB}',...
%    '\mu_{BP}','b_{DE}','b_{IR}','a_{Ea}','T_{n}','b_{p}','r_{am}',...
%    'b_{aE}','b_{aR}','\theta_D','d','dummy'};%,

k = size(pmax,1); 
LHSmatrix = zeros(runs, k); 

for i =1 : k 
    LHSmatrix(:,i) = LHS_Call(pmin(i), baseline(i), pmax(i), 0 ,runs,'unif');
end 

csvwrite('LHS.csv', LHSmatrix); %save LHS matrix

