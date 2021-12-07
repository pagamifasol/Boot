function [VHCL,MTR,TRSM,BTR]  = set_input(VHCL,MTR,TRSM,BTR,parameter,value)
%SET_INPUT sets the value of the desired parameter (selected from a list)

    if strcmp(parameter,'Non_ePT_Mass_kg')
        VHCL.NePT_Mass_kg       = value;
    elseif strcmp(parameter,'Aero_Cx*A')
        VHCL.Aero_Cx_LD         = value/VHCL.Aero_surf;
    elseif strcmp(parameter,'Aux_power_tot_W')
        VHCL.Aux_PWR_W          = value;
    elseif strcmp(parameter,'drive_ratio')
        TRSM.Front.Trans_Tau    = value;
        TRSM.Rear.Trans_Tau     = value;
    elseif strcmp(parameter,'front_motor_power_W')
        MTR.Front.Max_Power_W   = value;
        MTR.Front.Max_Torque_Nm = value*2.5e-3;
    elseif strcmp(parameter,'rear_motor_power_W')
        MTR.Rear.Max_Power_W    = value;
        MTR.Rear.Max_Torque_Nm  = value*2.5e-3;
    elseif strcmp(parameter,'motor_power_ratio')
        VHCL.TrqDistr           = (1-value);
        MTR.Front.Max_Power_W   = round(300*(1-value))*1e3;
        MTR.Rear.Max_Power_W    = 300e3-MTR.Front.Max_Power_W;
        MTR.Front.Max_Torque_Nm = MTR.Front.Max_Power_W*2.5e-3;
        MTR.Rear.Max_Torque_Nm  = MTR.Rear.Max_Power_W*2.5e-3;
    elseif strcmp(parameter,'TrqDistrFr')
        VHCL.TrqDistr           = value;
    elseif strcmp(parameter,'CRR_SAE2452')
        VHCL.Front.CRRtar       = value;
        VHCL.Rear.CRRtar        = value;
    elseif strcmp(parameter,'battery_energy_kWh')
        BTR.cell_p.n_parallel   = value/(BTR.cell_p.n_series*BTR.cell_p.capacity_nom*BTR.cell_p.voltage_nom*1e-3);
    elseif strcmp(parameter,'h_COG')
        VHCL.CG_height_m        = value;
    end
end

