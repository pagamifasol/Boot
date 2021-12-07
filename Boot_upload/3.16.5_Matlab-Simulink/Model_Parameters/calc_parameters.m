% calc_parameters

%% VHCL
VHCL.Front.CRRgain  = VHCL.Front.CRRtar/VHCL.CRR_SAE;
VHCL.Rear.CRRgain   = VHCL.Rear.CRRtar/VHCL.CRR_SAE;
VHCL.Front.mu       = 1;
VHCL.Rear.mu        = 1;

%% MTR & INV
MTR.Front.weight_kg = 35+MTR.Front.Max_Power_W*MTR.Front.Number_of_Motors*300e-6;
MTR.Rear.weight_kg  = 35+MTR.Rear.Max_Power_W*MTR.Rear.Number_of_Motors*300e-6;
MTR.Front.Torque_Nm = zeros(length(MTR.Front.bp_RPM),length(MTR.Front.bp_V));
MTR.Rear.Torque_Nm  = zeros(length(MTR.Front.bp_RPM),length(MTR.Front.bp_V));
for ii = 1:length(MTR.Front.bp_RPM)
    if ii == 1
        MTR.Front.Torque_Nm(ii,:)    = [1 1 1]*MTR.Front.Max_Torque_Nm/2;
        MTR.Rear.Torque_Nm(ii,:)     = [1 1 1]*MTR.Rear.Max_Torque_Nm/2;
    elseif ii == length(MTR.Front.bp_RPM)
        MTR.Front.Torque_Nm(ii,:)    = zeros(1,length(MTR.Front.bp_V));
        MTR.Rear.Torque_Nm(ii,:)     = zeros(1,length(MTR.Front.bp_V));
    else
        MTR.Front.Torque_Nm(ii,:)    = min([1 1 1]*MTR.Front.Max_Torque_Nm,...
        [1 1 1]*MTR.Front.Max_Power_W/(MTR.Front.bp_RPM(ii)*pi/30));
        MTR.Rear.Torque_Nm(ii,:)     = min([1 1 1]*MTR.Rear.Max_Torque_Nm,...
        [1 1 1]*MTR.Rear.Max_Power_W/(MTR.Front.bp_RPM(ii)*pi/30));
    end
end
i                           = ceil(length(MTR.Front.PLoss_T_bp_base)/2);
j                           = ceil(length(MTR.Rear.PLoss_T_bp_base)/2);
MTR.Front.PLoss_T_bp        = MTR.Front.PLoss_T_bp_base*MTR.Front.Max_Torque_Nm;
% MTR.Front.PLoss_table       = MTR.Front.PLoss_table_base.*abs(MTR.Front.PLoss_T_bp*MTR.Front.PLoss_n_bp*pi/30);
MTR.Front.PLoss_table       = MTR.Front.PLoss_table_base.*MTR.Front.Max_Power_W;
MTR.Front.PLoss_table(i,:,:)= MTR.Front.PLoss_table_base(i,:,:)*MTR.Front.Max_Power_W;
MTR.Rear.PLoss_T_bp         = MTR.Rear.PLoss_T_bp_base*MTR.Rear.Max_Torque_Nm;
% MTR.Rear.PLoss_table        = MTR.Rear.PLoss_table_base.*abs(MTR.Rear.PLoss_T_bp*MTR.Rear.PLoss_n_bp*pi/30);
MTR.Rear.PLoss_table        = MTR.Rear.PLoss_table_base.*MTR.Rear.Max_Power_W;
MTR.Rear.PLoss_table(i,:,:) = MTR.Rear.PLoss_table_base(j,:,:)*MTR.Rear.Max_Power_W;
INV.Front.PLoss_T_bp        = INV.Front.PLoss_T_bp_base*MTR.Front.Max_Torque_Nm;
INV.Front.PLoss_table       = INV.Front.PLoss_table_base.*abs(MTR.Front.PLoss_T_bp*MTR.Front.PLoss_n_bp*pi/30);
INV.Front.PLoss_table(i,:,:)= INV.Front.PLoss_table_base(i,:,:)*MTR.Front.Max_Power_W;
INV.Rear.PLoss_T_bp         = INV.Rear.PLoss_T_bp_base*MTR.Rear.Max_Torque_Nm;
INV.Rear.PLoss_table        = INV.Rear.PLoss_table_base.*abs(MTR.Rear.PLoss_T_bp*MTR.Rear.PLoss_n_bp*pi/30);
INV.Rear.PLoss_table(i,:,:) = INV.Rear.PLoss_table_base(j,:,:)*MTR.Rear.Max_Power_W;
clear ii i j

%% TRSM
TRSM.Front.bp_Torque_Nm_Mtr = TRSM.Front.bp_Torque_Nm_Mtr_base*MTR.Front.Max_Torque_Nm;
TRSM.Front.PLoss            = TRSM.Front.PLoss_base*MTR.Front.Max_Power_W*MTR.Front.Max_Torque_Nm/280;
TRSM.Front.TLoss            = TRSM.Front.PLoss./(max(1,TRSM.Front.bp_RPM_Mtr)*pi/30);
TRSM.Rear.bp_Torque_Nm_Mtr  = TRSM.Rear.bp_Torque_Nm_Mtr_base*MTR.Front.Max_Torque_Nm;
TRSM.Rear.PLoss             = TRSM.Rear.PLoss_base*MTR.Rear.Max_Power_W*MTR.Rear.Max_Torque_Nm/280;
TRSM.Rear.TLoss             = TRSM.Rear.PLoss./(max(1,TRSM.Rear.bp_RPM_Mtr)*pi/30);

%% BTR
BTR.weight_kg   = BTR.cell_p.n_series*BTR.cell_p.n_parallel*BTR.cell_p.weight/0.7;
BTR.EPack_kWh   = BTR.cell_p.n_series*BTR.cell_p.n_parallel*BTR.cell_p.capacity_nom*BTR.cell_p.voltage_nom*94e-5;

%% total weight
VHCL.tot_mass_kg    = VHCL.Mass_kg+(BTR.weight_kg+MTR.Front.weight_kg+MTR.Rear.weight_kg+205+75)*0;
