%% Plots

Time_step = HVBS_26kWh_6modules.getElement('VLD_vActVhcl_kph').Values.Time(2) - HVBS_26kWh_6modules.getElement('VLD_vActVhcl_kph').Values.Time(1);

%% Figure 1
% Speed Profiles and SoC different capacity options
figure(1)
hold on
    % Speed Profiles comparison
subplot(3,1,1)
plot(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_26kWh_6modules.getElement('VLD_vActVhcl_kph').Values.Data)
hold on
plot(HVBS_22kWh_5modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_22kWh_5modules.getElement('VLD_vActVhcl_kph').Values.Data)
plot(HVBS_18kWh_4modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_18kWh_4modules.getElement('VLD_vActVhcl_kph').Values.Data)
plot(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_26kWh_6modules.getElement('DRV_vReq_kph').Values.Data)
grid on
grid minor
xlabel('Distance [km]')
ylabel('speed [km/h]')
legend('26.4kWh opt','22kWh opt','17.6kWh opt','Tgt Speed Profile [km/h]')
 
title('Speed profiles & Battery SOC')
    % SoC Comparison
subplot(3,1,2)
plot(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_26kWh_6modules.getElement('HVB_SOC').Values.Data)
hold on
plot(HVBS_22kWh_5modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_22kWh_5modules.getElement('HVB_SOC').Values.Data)
plot(HVBS_18kWh_4modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_18kWh_4modules.getElement('HVB_SOC').Values.Data)
grid on
grid minor
xlabel('Distance [km]')
ylabel('BTR SoC [%]')
legend('26.4kWh opt','22kWh opt','17.6kWh opt')

    % Velocity profiles in time
subplot(3,1,3)
plot(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Time,HVBS_26kWh_6modules.getElement('VLD_vActVhcl_kph').Values.Data)
hold on
plot(HVBS_22kWh_5modules.getElement('VLD_lActVhcl_km').Values.Time,HVBS_22kWh_5modules.getElement('VLD_vActVhcl_kph').Values.Data)
plot(HVBS_18kWh_4modules.getElement('VLD_lActVhcl_km').Values.Time,HVBS_18kWh_4modules.getElement('VLD_vActVhcl_kph').Values.Data)
grid on
grid minor
xlabel('Time [s]')
ylabel('speed [km/h]')
legend('26.4kWh opt','22kWh opt','17.6kWh opt')


%% Motors working conditions

figure(2)
hold on
Samples = length(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Data);
Time_end = max(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Time);
Dist_end = max(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Data);
Trq_cont = ones(Samples,1)*254;
Trq_peak = ones(Samples,1)*468;

    % Reference speed profile
subplot(3,1,1)
plot(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_26kWh_6modules.getElement('DRV_vReq_kph').Values.Data,'m')
grid on
grid minor
xlabel('Distance [km]')
ylabel('Speed [km/h]')
legend('Tgt Speed Profile [km/h]')
title('Reference ICE Boot Speed Profile')
    % Front motors torque profiles
subplot(3,1,2)
plot(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_26kWh_6modules.getElement('MTR_TFrtMtr_Nm').Values.Data)
hold on
plot(HVBS_22kWh_5modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_22kWh_5modules.getElement('MTR_TFrtMtr_Nm').Values.Data)
plot(HVBS_18kWh_4modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_18kWh_4modules.getElement('MTR_TFrtMtr_Nm').Values.Data)
plot(HVBS_18kWh_4modules.getElement('VLD_lActVhcl_km').Values.Data,Trq_cont,'r--')
plot(HVBS_18kWh_4modules.getElement('VLD_lActVhcl_km').Values.Data,Trq_peak,'k--')
grid on
grid minor
xlabel('Distance [km]')
ylabel('Torque [Nm]')
legend('26.4kWh opt','22kWh opt','17.6kWh opt','Cont Trq Limit','Peak Trq Limit')
 
title('Front Motor Torque [Nm]')
axis([0 Dist_end 0 500])

    % Rear motors torque profiles
subplot(3,1,3)
plot(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_26kWh_6modules.getElement('MTR_TRrMtr_Nm').Values.Data/2)
hold on
plot(HVBS_22kWh_5modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_22kWh_5modules.getElement('MTR_TRrMtr_Nm').Values.Data/2)
plot(HVBS_18kWh_4modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_18kWh_4modules.getElement('MTR_TRrMtr_Nm').Values.Data/2)
plot(HVBS_18kWh_4modules.getElement('VLD_lActVhcl_km').Values.Data,Trq_cont,'r--')
plot(HVBS_18kWh_4modules.getElement('VLD_lActVhcl_km').Values.Data,Trq_peak,'k--')
grid on
grid minor
xlabel('Distance [km]')
ylabel('Torque [Nm]')
legend('26.4kWh opt','22kWh opt','17.6kWh opt','Cont Trq Limit','Peak Trq Limit')
axis([0 Dist_end 0 500])
title('Rear Motors Torque [Nm]')

%% EE Compartment working conditions

figure(3)

Tot_EPower_26kWh = ( HVBS_26kWh_6modules.getElement('HVB_P').Values.Data + HVBS_26kWh_6modules.getElement('FC_P').Values.Data)/1000;  % Tot Electric Power [kW]

subplot(2,2,1)
plot(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Data,Tot_EPower_26kWh,'r')
hold on
grid on
grid minor
xlabel('Distance [km]')
ylabel('EPower [kW]')
legend('Total Electric Power (FC+HVB) [kW]')
title('EPower')
subplot(2,2,2)
plot(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_26kWh_6modules.getElement('HVB_P').Values.Data/1000)
grid on
grid minor
xlabel('Distance [km]')
ylabel('Battery Power [kW]')
legend('HVB P [kW]')
title('Battery Output Power [kW]')
subplot(2,2,3)
plot(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_26kWh_6modules.getElement('FC_P').Values.Data/1000,'m')
grid on
grid minor
xlabel('Distance [km]')
ylabel('Fuel Cell Power [kW]')
legend('FC P [kW]')
title('Fuel Cell Output Power [kW]')
subplot(2,2,4)
plot(HVBS_26kWh_6modules.getElement('VLD_lActVhcl_km').Values.Data,HVBS_26kWh_6modules.getElement('HVB_SOC').Values.Data,'k')
grid on
grid minor
xlabel('Distance [km]')
ylabel('Battery SoC [%]')
legend('HVB SoC [%]')
title('Battery Pack SoC [%]')

Tot_Energy_cons_kWh = trapz(Tot_EPower_26kWh)/(3600/Time_step);
fprintf('Total Energy consumed in the simulation is %5.3f kWh.\n',Tot_Energy_cons_kWh)
