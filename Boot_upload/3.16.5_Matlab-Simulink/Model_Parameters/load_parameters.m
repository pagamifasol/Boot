% Load parameters
dirInput = strcat('Model_Parameters\',Settings.vInput);

%% VHCL
VHCL1       = readtable(strcat(dirInput,'\VHCL.xlsx'),'Sheet','VHCL');
VHCL2       = readtable(strcat(dirInput,'\VHCL.xlsx'),'Sheet','1.1.90');
VHCL3       = readtable(strcat(dirInput,'\VHCL.xlsx'),'Sheet','1.2.90');
VHCL        = table2struct(array2table(VHCL1{:,3}','VariableNames',VHCL1{:,2}));
VHCL.Front  = table2struct(array2table(VHCL2{:,3}','VariableNames',VHCL2{:,2}));
VHCL.Rear   = table2struct(array2table(VHCL3{:,3}','VariableNames',VHCL3{:,2}));
clear VHCL1 VHCL2 VHCL3

%% BTR
load(strcat(dirInput,'\BTR.mat'))

%% WHL
WHL1        = readtable(strcat(dirInput,'\WHL.xlsx'),'Sheet','Front');
WHL2        = readtable(strcat(dirInput,'\WHL.xlsx'),'Sheet','Rear');
WHL.Front   = table2struct(array2table(WHL1{:,3}','VariableNames',WHL1{:,2}));
WHL.Rear    = table2struct(array2table(WHL2{:,3}','VariableNames',WHL2{:,2}));
WHL.Front.long      = readmatrix(strcat(dirInput,'\WHL.xlsx'),'Sheet','2.1.90');
WHL.Front.lat       = readmatrix(strcat(dirInput,'\WHL.xlsx'),'Sheet','2.1.91');
WHL.Rear.long       = readmatrix(strcat(dirInput,'\WHL.xlsx'),'Sheet','2.2.90');
WHL.Rear.lat        = readmatrix(strcat(dirInput,'\WHL.xlsx'),'Sheet','2.2.91');
clear WHL1 WHL2

%% MTR & INV
INV1            = readtable(strcat(dirInput,'\INV.xlsx'),'Sheet','Front');
INV2            = readtable(strcat(dirInput,'\INV.xlsx'),'Sheet','Rear');
MTR1            = readtable(strcat(dirInput,'\MTR.xlsx'),'Sheet','Front');
MTR2            = readtable(strcat(dirInput,'\MTR.xlsx'),'Sheet','Rear');
losmf            = readmatrix(strcat(dirInput,'\MTR.xlsx'),'Sheet','3.0.90');
losmr            = readmatrix(strcat(dirInput,'\MTR.xlsx'),'Sheet','3.0.91');
losi            = readmatrix(strcat(dirInput,'\INV.xlsx'),'Sheet','4.0.90');
INV.Front       = table2struct(array2table(INV1{:,3}','VariableNames',INV1{:,2}));
INV.Rear        = table2struct(array2table(INV2{:,3}','VariableNames',INV2{:,2}));
MTR.Front       = table2struct(array2table(MTR1{:,3}','VariableNames',MTR1{:,2}));
MTR.Rear        = table2struct(array2table(MTR2{:,3}','VariableNames',MTR2{:,2}));
INV.Front.Number    = str2double(INV.Front.Number);
INV.Rear.Number     = str2double(INV.Rear.Number);
MTR.Front.bp_RPM    = [0,200,500:500:16500]';
MTR.Front.bp_V      = [3,3.67,4.2]*BTR.cell_p.n_series;
% MTR.Front.bp_V      = [430,580,730];
MTR.Rear.bp_RPM     = MTR.Front.bp_RPM;
MTR.Rear.bp_V       = MTR.Front.bp_V;
MTR.Front.PLoss_T_bp_base   = losmf(2:22,2);
MTR.Front.PLoss_n_bp        = losmf(1,3:end);
% MTR.Front.PLoss_V_bp        = [2.5,3,3.67,4.2]*BTR.cell_p.n_series;
MTR.Front.PLoss_V_bp        = [550 750];
MTR.Front.PLoss_table_base(:,:,1)   = losmf(2:22,3:end);
MTR.Front.PLoss_table_base(:,:,2)   = losmf(24:44,3:end);
% MTR.Front.PLoss_table_base(:,:,3)   = losmf(46:66,3:end);
% MTR.Front.PLoss_table_base(:,:,4)   = losmf(68:88,3:end);
MTR.Rear.PLoss_T_bp_base    = losmr(2:22,2);
MTR.Rear.PLoss_n_bp         = losmr(1,3:end);
% MTR.Rear.PLoss_V_bp         = [2.5,3,3.67,4.2]*BTR.cell_p.n_series;
MTR.Rear.PLoss_V_bp         = [550 750];
MTR.Rear.PLoss_table_base(:,:,1)    = losmr(2:22,3:end);
MTR.Rear.PLoss_table_base(:,:,2)    = losmr(24:44,3:end);
% MTR.Rear.PLoss_table_base(:,:,3)    = losmr(46:66,3:end);
% MTR.Rear.PLoss_table_base(:,:,4)    = losmr(68:88,3:end);
INV.Front.PLoss_T_bp_base   = losi(2:22,2);
INV.Front.PLoss_n_bp        = losi(1,3:end);
INV.Front.PLoss_V_bp        = [2.5,3,3.67,4.2]*BTR.cell_p.n_series;
% INV.Front.PLoss_V_bp        = [450 550 650 750];
INV.Front.PLoss_table_base(:,:,1)   = losi(2:22,3:end);
INV.Front.PLoss_table_base(:,:,2)   = losi(24:44,3:end);
INV.Front.PLoss_table_base(:,:,3)   = losi(46:66,3:end);
INV.Front.PLoss_table_base(:,:,4)   = losi(68:88,3:end);
INV.Rear.PLoss_T_bp_base    = losi(2:22,2);
INV.Rear.PLoss_n_bp         = losi(1,3:end);
INV.Rear.PLoss_V_bp         = [2.5,3,3.67,4.2]*BTR.cell_p.n_series;
% INV.Rear.PLoss_V_bp         = [450 550 650 750];
INV.Rear.PLoss_table_base(:,:,1)    = losi(2:22,3:end);
INV.Rear.PLoss_table_base(:,:,2)    = losi(24:44,3:end);
INV.Rear.PLoss_table_base(:,:,3)    = losi(46:66,3:end);
INV.Rear.PLoss_table_base(:,:,4)    = losi(68:88,3:end);

clear i INV1 INV2 MTR1 MTR2 losi losm

%% TRSM
TRSM1           = readtable(strcat(dirInput,'\TRSM.xlsx'),'Sheet','Front');
TRSM2           = readtable(strcat(dirInput,'\TRSM.xlsx'),'Sheet','Rear');
mapl            = readmatrix(strcat(dirInput,'\TRSM.xlsx'),'Sheet','5.0.90');
TRSM.Front      = table2struct(array2table(TRSM1{:,3}','VariableNames',TRSM1{:,2}));
TRSM.Rear       = table2struct(array2table(TRSM2{:,3}','VariableNames',TRSM2{:,2}));
TRSM.Front.bp_Torque_Nm_Mtr_base    = mapl(2:end,1);
TRSM.Front.bp_RPM_Mtr       = mapl(1,2:end);
TRSM.Front.PLoss_base       = mapl(2:end,2:end);
TRSM.Rear.bp_Torque_Nm_Mtr_base     = mapl(2:end,1);
TRSM.Rear.bp_RPM_Mtr        = mapl(1,2:end);
TRSM.Rear.PLoss_base        = mapl(2:end,2:end);
clear TRSM1 TRSM2 mapl

%% BRK
BRK1        = readtable(strcat(dirInput,'\BRK.xlsx'),'Sheet','Front');
BRK2        = readtable(strcat(dirInput,'\BRK.xlsx'),'Sheet','Rear');
map1        = readmatrix(strcat(dirInput,'\BRK.xlsx'),'Sheet','6.1.90');
map2        = readmatrix(strcat(dirInput,'\BRK.xlsx'),'Sheet','6.2.90');
BRK.Front   = table2struct(array2table(BRK1{:,3}','VariableNames',BRK1{:,2}));
BRK.Rear    = table2struct(array2table(BRK2{:,3}','VariableNames',BRK2{:,2}));
BRK.Front.HTC_v_bp  = map1(1,2:end);
BRK.Front.HTC_map   = map1(2,2:end);
BRK.Rear.HTC_v_bp   = map2(1,2:end);
BRK.Rear.HTC_map    = map2(2,2:end);
clear BRK1 BRK2 map1 map2

%% RAD
RAD1        = readtable(strcat(dirInput,'\RAD.xlsx'),'Sheet','Front');
RAD2        = readtable(strcat(dirInput,'\RAD.xlsx'),'Sheet','Rear');
mapr1       = readmatrix(strcat(dirInput,'\RAD.xlsx'),'Sheet','8.1.90');
mapr2       = readmatrix(strcat(dirInput,'\RAD.xlsx'),'Sheet','8.1.91');
mapr3       = readmatrix(strcat(dirInput,'\RAD.xlsx'),'Sheet','8.2.90');
RAD.Front   = table2struct(array2table(RAD1{:,3}','VariableNames',RAD1{:,2}));
RAD.Rear    = table2struct(array2table(RAD2{:,3}','VariableNames',RAD2{:,2}));
RAD.Front.FC_dma_bp         = mapr1(2:end,1);
RAD.Front.FC_dmw_bp         = mapr1(1,2:end);
RAD.Front.FC_normHR         = mapr1(2:end,2:end);
RAD.Front.FS_dma_bp         = mapr2(2:end,1);
RAD.Front.FS_dmw_bp         = mapr2(1,2:end);
RAD.Front.FS_normHR         = mapr2(2:end,2:end);
RAD.Rear.RS_dma_bp          = mapr3(2:end,1);
RAD.Rear.RS_dmw_bp          = mapr3(1,2:end);
RAD.Rear.RS_normHR          = mapr3(2:end,2:end);
clear RAD1 RAD2 mapr1 mapr2 mapr3

%% DCDC
DCDC1           = readmatrix(strcat(dirInput,'\DCDC.xlsx'),'Sheet','DCDC');
DCDC.bp_power   = DCDC1(2:end,1);
DCDC.bp_V       = DCDC1(1,2:end);
DCDC.eff        = DCDC1(2:end,2:end);
clear DCDC1

%% CHRG
CHRG1        = readtable(strcat(dirInput,'\CHRG.xlsx'),'Sheet','CHRG');
CHRG         = table2struct(array2table(CHRG1{:,3}','VariableNames',CHRG1{:,2}));
clear CHRG1

%% FAN
FAN1        = readtable(strcat(dirInput,'\FAN.xlsx'),'Sheet','Front');
FAN2        = readtable(strcat(dirInput,'\FAN.xlsx'),'Sheet','Rear');
mapF1       = readmatrix(strcat(dirInput,'\FAN.xlsx'),'Sheet','9.1.90');
mapF2       = readmatrix(strcat(dirInput,'\FAN.xlsx'),'Sheet','9.1.91');
mapF3       = readmatrix(strcat(dirInput,'\FAN.xlsx'),'Sheet','9.1.92');
mapF4       = readmatrix(strcat(dirInput,'\FAN.xlsx'),'Sheet','9.1.93');
mapF5       = readmatrix(strcat(dirInput,'\FAN.xlsx'),'Sheet','9.1.94');
mapF6       = readmatrix(strcat(dirInput,'\FAN.xlsx'),'Sheet','9.1.95');
mapF7       = readmatrix(strcat(dirInput,'\FAN.xlsx'),'Sheet','9.2.90');
mapF8       = readmatrix(strcat(dirInput,'\FAN.xlsx'),'Sheet','9.2.91');
FAN.Front   = table2struct(array2table(FAN1{:,3}','VariableNames',FAN1{:,2}));
FAN.Rear    = table2struct(array2table(FAN2{:,3}','VariableNames',FAN2{:,2}));
FAN.Front.f10_V_bp      = mapF1(2:end,1);
FAN.Front.f10_RPM_bp    = mapF1(1,2:end);
FAN.Front.f10_dm_air    = mapF1(2:end,2:end);
FAN.Front.f10_power     = mapF2(2:end,2:end);
FAN.Front.f11_V_bp      = mapF3(2:end,1);
FAN.Front.f11_RPM_bp    = mapF3(1,2:end);
FAN.Front.f11_dm_air    = mapF3(2:end,2:end);
FAN.Front.f11_power     = mapF4(2:end,2:end);
FAN.Front.f15_V_bp      = mapF5(2:end,1);
FAN.Front.f15_RPM_bp    = mapF5(1,2:end);
FAN.Front.f15_dm_air    = mapF5(2:end,2:end);
FAN.Front.f15_power     = mapF6(2:end,2:end);
FAN.Rear.f11_V_bp       = mapF7(2:end,1);
FAN.Rear.f11_RPM_bp     = mapF7(1,2:end);
FAN.Rear.f11_dm_air     = mapF7(2:end,2:end);
FAN.Rear.f11_power      = mapF8(2:end,2:end);
clear FAN1 FAN2 mapF1 mapF2 mapF3 mapF4 mapF5 mapF6 mapF7 mapF8

%% PUMP
PUMP1       = readtable(strcat(dirInput,'\PUMP.xlsx'),'Sheet','Front');
PUMP2       = readtable(strcat(dirInput,'\PUMP.xlsx'),'Sheet','Rear');
mapP1       = readmatrix(strcat(dirInput,'\PUMP.xlsx'),'Sheet','7.1.90');
mapP2       = readmatrix(strcat(dirInput,'\PUMP.xlsx'),'Sheet','7.1.91');
mapP3       = readmatrix(strcat(dirInput,'\PUMP.xlsx'),'Sheet','7.1.92');
mapP4       = readmatrix(strcat(dirInput,'\PUMP.xlsx'),'Sheet','7.1.93');
mapP5       = readmatrix(strcat(dirInput,'\PUMP.xlsx'),'Sheet','7.2.90');
mapP6       = readmatrix(strcat(dirInput,'\PUMP.xlsx'),'Sheet','7.2.91');
mapP7       = readmatrix(strcat(dirInput,'\PUMP.xlsx'),'Sheet','7.2.92');
mapP8       = readmatrix(strcat(dirInput,'\PUMP.xlsx'),'Sheet','7.2.93');
PUMP.Front  = table2struct(array2table(PUMP1{:,3}','VariableNames',PUMP1{:,2}));
PUMP.Rear   = table2struct(array2table(PUMP2{:,3}','VariableNames',PUMP2{:,2}));
PUMP.Front.BCS_RPM_bp1  = mapP1(1,2:end);
PUMP.Front.BCS_dV       = mapP1(2,2:end);
PUMP.Front.BCS_RPM_bp2  = mapP2(1,2:end);
PUMP.Front.BCS_power    = mapP2(2,2:end);
PUMP.Front.PWT_RPM_bp1  = mapP3(1,2:end);
PUMP.Front.PWT_dV       = mapP3(2,2:end);
PUMP.Front.PWT_RPM_bp2  = mapP4(1,2:end);
PUMP.Front.PWT_power    = mapP4(2,2:end);
PUMP.Rear.MTR_RPM_bp1   = mapP5(1,2:end);
PUMP.Rear.MTR_dV        = mapP5(2,2:end);
PUMP.Rear.MTR_RPM_bp2   = mapP6(1,2:end);
PUMP.Rear.MTR_power     = mapP6(2,2:end);
PUMP.Rear.INV_RPM_bp1   = mapP7(1,2:end);
PUMP.Rear.INV_dV        = mapP7(2,2:end);
PUMP.Rear.INV_RPM_bp2   = mapP8(1,2:end);
PUMP.Rear.INV_power     = mapP8(2,2:end);
clear PUMP1 PUMP2 mapP1 mapP2 mapP3 mapP4 mapP5 mapP6 mapP7 mapP8
