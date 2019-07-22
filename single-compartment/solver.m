% Undergrad team edit on 06.11.19:

params;

%Initial values
EndTime = 315;
Tspan = [0 EndTime]; %time in days
IC = [4.77*10^5 0 0 0 300 100 10 0 0 0 0 0]; % using Topp healthy rest state for beta cells, glucose, insulin

%LdeP Decide before whether to turn the wave on or off
% 06.11 Removed waveon term

[Tn Yn] = ode15s(@(t,y)rhs(t,y,fMan,fMn, 0),Tspan,IC);
[Tb Yb] = ode15s(@(t,y)rhs(t,y,fMab,fMb, 0),Tspan,IC);

[TnWave YnWave] = ode15s(@(t,y)rhs(t,y,fMan,fMn, 1),Tspan,IC);
[TbWave YbWave] = ode15s(@(t,y)rhs(t,y,fMab,fMb, 1),Tspan,IC);


%Convert days into weeks
EndTime=EndTime./7;
Tn=Tn./7;
TnWave=TnWave./7;
Tb = Tb./7;
TbWave = TbWave./7;

%Plot B, G, I:
%=========================
figure;
subplot(2,2,1)
semilogy(Tn,Yn(:,5), 'linewidth', 1.75);
hold on
semilogy(Tn,Yn(:,6), 'linewidth', 1.75);
semilogy(Tn,Yn(:,7), 'linewidth', 1.75);
legend('B','G','I');
ylim([10^0 10^3])
xlabel('Time in Weeks');
ylabel('Concentrations');
xlim([0 EndTime])
title('T1D simulation for Balb/c, With Wave');

subplot(2,2,2)
semilogy(Tb,Yb(:,5), 'linewidth', 1.75);
hold on
semilogy(Tb,Yb(:,6), 'linewidth', 1.75);
semilogy(Tb,Yb(:,7), 'linewidth', 1.75);
legend('B','G','I');
ylim([10^0 10^3])
xlabel('Time in Weeks');
ylabel('Concentrations');
xlim([0 EndTime])
title('T1D simulation for Balb/c, With Wave');

subplot(2,2,3)
semilogy(TnWave,YnWave(:,5), 'linewidth', 1.75);
hold on
semilogy(TnWave,YnWave(:,6), 'linewidth', 1.75);
semilogy(TnWave,YnWave(:,7), 'linewidth', 1.75);
legend('B','G','I');
ylim([10^0 10^3])
xlabel('Time in Weeks');
ylabel('Concentrations');
xlim([0 EndTime])
title('T1D simulation for Balb/c, With Wave');

subplot(2,2,4)
semilogy(TbWave,YbWave(:,5), 'linewidth', 1.75);
hold on
semilogy(TbWave,YbWave(:,6), 'linewidth', 1.75);
semilogy(TbWave,YbWave(:,7), 'linewidth', 1.75);
legend('B','G','I');
ylim([10^0 10^3])
xlabel('Time in Weeks');
ylabel('Concentrations');
xlim([0 EndTime])
title('T1D simulation for Balb/c, With Wave');


%Plot E, R, Em:
%=========================
figure;
subplot(2,2,1)
semilogy(Tn,Yn(:,10), 'linewidth', 1.75);
hold on
semilogy(Tn,Yn(:,11), 'linewidth', 1.75);
semilogy(Tn,Yn(:,12), 'linewidth', 1.75);
legend('E','R','Em');
ylim([10^0 10^10])
xlabel('Time in Weeks');
ylabel('Concentrations');
xlim([0 EndTime])
title('T1D simulation for Balb/c, With Wave');

subplot(2,2,2)
semilogy(Tb,Yb(:,10), 'linewidth', 1.75);
hold on
semilogy(Tb,Yb(:,11), 'linewidth', 1.75);
semilogy(Tb,Yb(:,12), 'linewidth', 1.75);
legend('E','R','Em');
ylim([10^0 10^10])
xlabel('Time in Weeks');
ylabel('Concentrations');
xlim([0 EndTime])
title('T1D simulation for Balb/c, With Wave');

subplot(2,2,3)
semilogy(TnWave,YnWave(:,10), 'linewidth', 1.75);
hold on
semilogy(TnWave,YnWave(:,11), 'linewidth', 1.75);
semilogy(TnWave,YnWave(:,12), 'linewidth', 1.75);
legend('E','R','Em');
ylim([10^0 10^10])
xlabel('Time in Weeks');
ylabel('Concentrations');
xlim([0 EndTime])
title('T1D simulation for Balb/c, With Wave');

subplot(2,2,4)
semilogy(TbWave,YbWave(:,10), 'linewidth', 1.75);
hold on
semilogy(TbWave,YbWave(:,11), 'linewidth', 1.75);
semilogy(TbWave,YbWave(:,12), 'linewidth', 1.75);
legend('E','R','Em');
ylim([10^0 10^10])
xlabel('Time in Weeks');
ylabel('Concentrations');
xlim([0 EndTime])
title('T1D simulation for Balb/c, With Wave');

%Plot Ba, Bn, tD, D:
%=========================
figure;
subplot(2,2,1)
semilogy(Tn,Yn(:,3), 'linewidth', 1.75);
hold on
semilogy(Tn,Yn(:,4), 'linewidth', 1.75);
semilogy(Tn,Yn(:,9), 'linewidth', 1.75);
semilogy(Tn,Yn(:,8), 'linewidth', 1.75);
legend('Ba','Bn','tD','D');
ylim([10^0 10^10])

xlabel('Time in Weeks');
ylabel('Concentrations');
xlim([0 EndTime])
title('T1D simulation for NOD, No Wave');

subplot(2,2,2)
semilogy(Tb,Yb(:,3), 'linewidth', 1.75);
hold on
semilogy(Tb,Yb(:,4), 'linewidth', 1.75);
semilogy(Tb,Yb(:,9), 'linewidth', 1.75);
semilogy(Tb,Yb(:,8), 'linewidth', 1.75);
legend('Ba','Bn','tD','D');
ylim([10^0 10^10])

xlabel('Time in Weeks');
ylabel('Concentrations');
xlim([0 EndTime])
title('T1D simulation for Balb/c, No Wave');

subplot(2,2,3)
semilogy(TnWave,YnWave(:,3), 'linewidth', 1.75);
hold on
semilogy(TnWave,YnWave(:,4), 'linewidth', 1.75);
semilogy(TnWave,YnWave(:,9), 'linewidth', 1.75);
semilogy(TnWave,YnWave(:,8), 'linewidth', 1.75);
legend('Ba','Bn','tD','D');
ylim([10^0 10^10])

xlabel('Time in Weeks');
ylabel('Concentrations');
xlim([0 EndTime])
title('T1D simulation for NOD, With Wave');

subplot(2,2,4)
semilogy(TbWave,YbWave(:,3), 'linewidth', 1.75);
hold on
semilogy(TbWave,YbWave(:,4), 'linewidth', 1.75);
semilogy(TbWave,YbWave(:,9), 'linewidth', 1.75);
semilogy(TbWave,YbWave(:,8), 'linewidth', 1.75);
legend('Ba','Bn','tD','D');
ylim([10^0 10^10])

xlabel('Time in Weeks');
ylabel('Concentrations');
xlim([0 EndTime])
title('T1D simulation for Balb/c, With Wave');


