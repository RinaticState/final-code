 % setappdata and getappdata functions provide a convenient way to 
% share data between callbacks or between separate User Interface

%May 23: ParametersLHS is the file specifically used for this routine
% it will update fms and fmas in the LHS routine 

scale_factor = .0623; % works for scale factor between .0604 and .0635 (to that many sig figs)


% Clearance rates for BalbC and NOD mouse are our control values

%BalbC parameters: 
 f1b = 2; f2b = 5;
  f1  = scale_factor*f1b*10^(-5); %ml cell^-1d^-1 %wt basal phagocytosis rate per M
  f2  = scale_factor*f2b*10^(-5);%ml cell^-1d^-1 %wt activated phagocytosis rate per Ma

%NOD parameters
 f1nod =1; f2nod = 1;
 f1n = scale_factor*f1nod*10^(-5); %ml cell^-1d^-1 %nod basal phagocytosis rate per M 
 f2n = scale_factor*f1nod*10^(-5); %ml cell^-1d^-1 % nod activated phagocytosis rate per Ma 
  

% An's modification:
% setappdata was set in the main executing file
% Parameter file use getappdata to call back the values assign in the main
% file. 

% An's modification: eFAST routine 
% Assume f1s and f2s to be fixed at NOD values
% While other parameters from the U-subset


%% eFAST parameters assignment 
sE     = getappdata(0,'sE_var'); %saturation terms for effector killing
sR     = getappdata(0,'sR_var'); %control of trefs over effector killing
D_ss = getappdata(0,'Dss_var');
aEmday = getappdata(0,'aEmday_var');    % per day; death rate of memory CTL cells [ESTIMATED, =ln(2)/(69 days)]
eta_basal = getappdata(0,'etabasal_var');
alpha_eta= getappdata(0,'alpha_e_var'); %This value seems to control the jump slope
beta_eta=getappdata(0,'beta_e_var');% This afects the time to sick


f1s = getappdata(0,'fms_var');
f2s = getappdata(0,'fmas_var');
f1t  = scale_factor*f1s*10^(-5); %ml cell^-1d^-1 %wt basal phagocytosis rate per M
f2t  = scale_factor*f2s*10^(-5);%ml cell^-1d^-1 %wt activated phagocytosis rate per Ma



%% From Table 1
J = getappdata(0,'J_var'); % cells ml^-1d^-1 : normal resting macrophage influx
k = getappdata(0,'k_var'); %d^-1: Ma deactivation rate
b = getappdata(0,'b_var'); %d^-1: recruitment rate of M by Ma
c = getappdata(0,'c_var'); %d^-1: macrophage egress rate
e1= getappdata(0,'e1_var'); %cell^-1d^-1: anti-crowding terms for macrophages
e2= getappdata(0,'e2_var'); %cell^-1d^-1: anti-crowding terms for macrophages
scale_factor = .0623; % works for scale factor between .0604 and .0635 (to that many sig figs)


% Added parameters
alpha_B =getappdata(0,'alphaB_var');
delta_B = getappdata(0,'deltaB_var');
% B_tot = 7.76*10^7; % Measured in cells, computed from Maree and Paredes
B_conv = 2.59*10^5; % Units: cell/mg, Computed using the Maree value for density of cells in healthy pancreas and Topp value for mg beta cells in healthy pancreas
Ghb = getappdata(0,'Ghb_var');
R0      = getappdata(0,'R0_var'); %mg per dl
EG0     = getappdata(0,'EG0_var'); %per day
SI      = getappdata(0,'SI_var'); % ml per muU per day
sigmaI  = getappdata(0,'sigmaI_var'); %muU per ml per day per mg
deltaI  = getappdata(0,'deltaI_var'); %per day
GI      = getappdata(0,'GI_var'); %mg per dl
Qpanc = getappdata(0,'Qpanc_var'); % ml

Qblood  = 3.00; % ml
Qspleen = 0.10; % ml

mu_PB = getappdata(0,'muPB_var');        % per day, original value
mu_BP = getappdata(0,'muBP_var');         % per day


DCtoM = 5.49 * 10^(-2);
tDCtoM = 3.82 * 10^(-1);

% Note: fD and ftD are assumed to be fixed.


bDEday = getappdata(0,'bDEday_var'); % ml/cell/day, per capita elimination rate of DC by CTL
bIRday = getappdata(0,'bIRday_var');    %ml/cell/day, per capita elimination rate of iDC by Tregs
aEaday = getappdata(0,'aEaday_var');    % per day; BUT I DON'T THINK THIS CAN BE RIGHT!  [ESTIMATED, =ln(2)/(5.78 days)]
T_naive = getappdata(0,'Tnaive_var');   % cells, number of naive cells contributing to primary clonal expansion
bpday = getappdata(0,'bpday_var');         % per day, maximal expansion factor of activated CTL
ramday = getappdata(0,'ramday_var');      % per day, reversion rate of active CTL to memory CTL
baEday =  getappdata(0,'baEday_var'); %BSH distinguish activation rate for effector memory cells by DC
baRday =  getappdata(0,'baRday_var'); %BSH distinguish activation rate for Treg memore cell by iDC


thetaD = getappdata(0,'thetaD_var'); % cells/ml;  Threshold in DC density in the spleen for half maximal proliferation rate of CTL [7.5e2,1.2e4]
d    = getappdata(0,'d_var'); % d^(-1)  rate of apoptotic cell decay into a necrotic cell

fDs = getappdata(0,'fDs_var'); 
ftDs = getappdata(0,'ftDs_var'); 


fD = fDs*DCtoM;
ftD = ftDs*tDCtoM;

mues_r = getappdata(0,'mues_r_var');     %per day;  rate of CTL-Treg removal equal to death rate of memory CTL
mues_e = getappdata(0,'mues_e_var');


% eta function 
% alpha_eta=0.11; %This value seems to control the jump slope
% beta_eta=21;% This afects the time to sick 
%eta    = 0.03;% effectiveness of effectors

