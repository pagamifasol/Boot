%% add path of subfolders
addpath('Model_Parameters')
addpath(genpath('Simulink_Model'))
addpath('Library')
addpath('Speed_Cycle')
addpath('Function')
addpath('Simulation_Results')

%% Load Input settings
[Settings, canceled] = input_setting();
if canceled == 1
    error('Error. \nThe operation was cancelled by the user %s',[])
end

%% load electric vehicle parameter
run('load_parameters')
BTR.cell_p.n_parallel = BTR.cell_p.n_parallel*26.4/15;
VHCL.Front.CRRtar   = 0;
VHCL.Rear.CRRtar    = 0;
run('calc_parameters')

%% cycle generator for simulink simulation
[Simulink] = Cycle_generator(Settings);

%% open simulink model
open_system('Vehicle_Model_WIP.slx')

%% run simulation

