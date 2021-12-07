function [Simulink] = Cycle_generator(Settings)


%% Multiple Cycle generator

Cycle = load(Settings.cycle_name);
fieldname = Settings.cycle_name;


time      = Cycle.(fieldname)(:,1); % [s]
speed     = Cycle.(fieldname)(:,2); % [km/h]
slope     = Cycle.(fieldname)(:,3); % [%]
chrg_pwr  = Cycle.(fieldname)(:,4); % [W]
distance  = cumtrapz(time,max(1e-3,speed/3.6))/1000;  % [km]

n_cyc = Settings.number_cycles; 

time2_init = 0;
time2      = time;
n2         = length (time2);

time_bis     = time2;
speed_bis    = zeros(n2,n_cyc);
slope_bis    = zeros(n2,n_cyc);
chrg_pwr_bis = zeros(n2,n_cyc);
distance_bis = zeros(n2,n_cyc);



speed_bis(:,1)    = speed;
slope_bis(:,1)    = slope;
chrg_pwr_bis(:,1) = chrg_pwr;
distance_bis(:,1) = distance;


j = 2;
while j <= n_cyc
    time_bis(:,j)     =  time2+time_bis(end,j-1)-time2_init;
    speed_bis(:,j)    = speed;
    slope_bis(:,j)    = slope;
    chrg_pwr_bis(:,j) = chrg_pwr;
    distance_bis(:,j) = distance_bis(end,j-1)+distance+1e-5;
    j = j+1;
end


Simulink.t_end = round(time(end))*n_cyc;


Simulink.Speed(:,1) = reshape(time_bis,[n_cyc*n2,1]);  % [s]
Simulink.Speed(:,2) = reshape(speed_bis,[n_cyc*n2,1]); % [km/h]


Simulink.Slope(:,1) = reshape(time_bis,[n_cyc*n2,1]);  % [s]
Simulink.Slope(:,2) = reshape(slope_bis,[n_cyc*n2,1]); % [km/h]


Simulink.Chrg_Pwr(:,1) = reshape(time_bis,[n_cyc*n2,1]);  % [s]
Simulink.Chrg_Pwr(:,2) = reshape(-chrg_pwr_bis,[n_cyc*n2,1]); % [W] (charge powr must be negative)


Simulink.Distance(:,1) = reshape(time_bis,[n_cyc*n2,1]);        % [s]
Simulink.Distance(:,2) = reshape(distance_bis,[n_cyc*n2,1]);    % [km]

%% Slip model and time fixed step definition

Simulink.slip = Settings.slip;

if Settings.slip == 0
    Simulink.dt = 0.1; %s
elseif Settings.slip == 1
    Simulink.dt = 0.01; %s
end


%% Initialisation parameters

Simulink.INIT_SocBtr_Pct      = Settings.INIT_SocBtr_Pct;
Simulink.INIT_TEnv_degC       = Settings.INIT_TEnv_degC;
Simulink.INIT_TSys_degC       = Settings.INIT_TSys_degC;
% Simulink.INIT_dVBtr_lpm       = Settings.INIT_dVBtr_lpm;
% Simulink.INIT_dVPwrT_lpm      = Settings.INIT_dVPwrT_lpm;
Simulink.INIT_rRegen          = Settings.INIT_Regen_ptc/100;




end