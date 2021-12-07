%% load results
load('Simulation_Results\HVBS_15kWh_wip2.mat');

%% plots
% % speed profile
% figure
% yyaxis left
% plot(Simulink.Speed(:,1),Simulink.Speed(:,2),'LineWidth',1)
% ylabel('speed [km/h]')
% yyaxis right
% plot(Simulink.Speed(:,1),GPSAltm,'LineWidth',1)
% ylabel('altitude [m]')
% grid on
% grid minor
% xlabel('time [s]')

% reqSpeed vs actSpeed
figure
plot(Sim_Results.INPT.INPT_vReq_kph.Time,Sim_Results.INPT.INPT_vReq_kph.Data,'LineWidth',1)
hold on
plot(Sim_Results.VLD.VLD_vActVhcl_kph.Time,Sim_Results.VLD.VLD_vActVhcl_kph.Data,'LineWidth',1)
ylabel('speed [km/h]')
grid on
grid minor
xlabel('time [s]')
legend('requested','actual')
set(gcf, 'Position',  [100, 100, 900, 400])

% battery power & SoC
figure
yyaxis left
plot(Sim_Results.BTR.BTR_PPackEst_W.Time,Sim_Results.BTR.BTR_PPackEst_W.Data/1000,'LineWidth',1)
ylabel('battery power [kW]')
yyaxis right
plot(Sim_Results.BTR.BTR_SocPack_Ptc.Time,Sim_Results.BTR.BTR_SocPack_Ptc.Data,'LineWidth',1)
ylabel('battery SoC [%]')
grid on
grid minor
xlabel('time [s]')
set(gcf, 'Position',  [100, 100, 900, 400])

% motors torque & power
figure
yyaxis left
plot(Sim_Results.MTR.MTR_TFrtMtr_Nm.Time,Sim_Results.MTR.MTR_TFrtMtr_Nm.Data/2,'LineWidth',1)
ylabel('motor torque [Nm]')
yyaxis right
plot(Sim_Results.MTR.MTR_PElectTot_W.Time,Sim_Results.MTR.MTR_PElectTot_W.Data/4000,'LineWidth',1)
ylabel('motor power [kW]')
grid on
grid minor
xlabel('time [s]')
set(gcf, 'Position',  [100, 100, 900, 400])