function [Settings , canceled] = input_setting()

%%
cycles_list         = Cycles_List();
version_list        = Version_List();

Title = 'Electric Vehicle Simulation Input';

%%%% SETTING DIALOG OPTIONS
Options.WindowStyle  = 'modal';
Options.Resize       = 'on';
Options.Interpreter  = 'tex';
Options.CancelButton = 'on';
Options.ApplyButton  = 'on';
Options.ButtonNames  = {'Ok','Cancel'}; %<- default names, included here just for illustration

i1 = 1;

Prompt(i1,:)             = {'---------------------------------------------    Vehicle    ---------------------------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];
i1 = i1 +1;

Prompt(i1,:) = {'Vehicle Configuration     ','Mtr',[]};
Formats(i1,1).type = 'list';
Formats(i1,1).size       = [50 0];
Formats(i1,1).format = 'text';
Formats(i1,1).style = 'radiobutton';
Formats(i1,1).items = {'1 Motors Front 2 Motors Rear (EDU WP3)';'2 Motors Front 2 Motors Rear (EDU WP4)'};
DefAns.Mtr = '2 Motors Front 2 Motors Rear (EDU WP4)';
i1 = i1 +1;

Prompt(i1,:) = {'Select Input Version     ','vInput',[]};
Formats(i1,1).type = 'list';
Formats(i1,1).size       = [250 20];
Formats(i1,1).style = 'popupmenu';
Formats(i1,1).items = version_list;
i1 = i1 +1;



Prompt(i1,:)             = {'---------------------------------------------    Cycle    ---------------------------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];
i1 = i1 +1;

Prompt(i1,:) = {'Select Cycle        ','CycleName',[]};
Formats(i1,1).type = 'list';
Formats(i1,1).size       = [250 20];
Formats(i1,1).style = 'popupmenu';
Formats(i1,1).items = cycles_list;

i1 = i1 +1;
Prompt(i1,:) = {'Number of cycle                             ','n_cyc','  [%]'};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'integer';
Formats(i1,1).size = 80;
DefAns.n_cyc = 1;


i1 = i1 +1;
Prompt(i1,:) = {'Initial SOC                                      ','SOC_Init','  [%]'};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'integer';
Formats(i1,1).size = 80;
DefAns.SOC_Init = 95;


i1 = i1 +1;
Prompt(i1,:) = {'Ambient Temperature                    ','Temp_env','  [°C]'};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.Temp_env = 23;

i1 = i1 +1;
Prompt(i1,:) = {'Initial System Temperature            ','Temp_Sys_Init','  [°C]'};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.Temp_Sys_Init = 23;

i1 = i1 + 1;

% Prompt(i1,:) = {'Battery Coolant Flow Rate             ','B_Mass_Flow','  [{l}/{min}]'};
% Formats(i1,1).type = 'edit';
% Formats(i1,1).format = 'float';
% Formats(i1,1).size = 80;
% DefAns.B_Mass_Flow = 60;
% 
% i1 = i1 + 1;
% Prompt(i1,:) = {'Power Train Coolant Flow Rate     ','PT_Mass_Flow','  [{l}/{min}]'};
% Formats(i1,1).type = 'edit';
% Formats(i1,1).format = 'float';
% Formats(i1,1).size = 80;
% DefAns.PT_Mass_Flow = 10;
% i1 = i1 + 1;

Prompt(i1,:) = {'Regenerative power                       ','regen','  [%]'};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.regen = 0;
i1 = i1 + 1;


Prompt(i1,:)             = {'---------------------------------------------    Slip Model    ---------------------------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];
i1 = i1 +1;

Prompt(i1,:) = {'Slip model     ','slip',[]};
Formats(i1,1).type = 'list';
Formats(i1,1).size       = [50 0];
Formats(i1,1).format = 'text';
Formats(i1,1).style = 'radiobutton';
Formats(i1,1).items = {'yes (slower simulation only for WOT)';'no (faster simulation for range and cycle'};
DefAns.slip = 'no (faster simulation for range and cycle';
i1 = i1 +1;


Prompt(i1,:)             = {'-------------------------------------------------------------------------------------------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];


[Answer,canceled] = inputsdlg(Prompt,Title,Formats,DefAns,Options);



%%

if strcmp(Answer.Mtr,'1 Motors Front 2 Motors Rear (EDU WP3)')
    Settings.mtr = 3;
elseif strcmp(Answer.Mtr,'2 Motors Front 2 Motors Rear (EDU WP4)')
    Settings.mtr = 4;
end


if strcmp(Answer.slip,'no (faster simulation for range and cycle')
    Settings.drivemode = 2;
    Settings.slip = 0;
elseif strcmp(Answer.slip,'yes (slower simulation only for WOT)')
    Settings.drivemode = 5;
    Settings.slip = 1;
end


Settings.cycle_name         = cycles_list{Answer.CycleName};
Settings.vInput             = version_list{Answer.vInput};
Settings.number_cycles      = Answer.n_cyc;

Settings.INIT_SocBtr_Pct  = Answer.SOC_Init;

Settings.INIT_TEnv_degC   = Answer.Temp_env;
Settings.INIT_TSys_degC   = Answer.Temp_Sys_Init;
% Settings.INIT_dVBtr_lpm   = Answer.B_Mass_Flow;
% Settings.INIT_dVPwrT_lpm  = Answer.PT_Mass_Flow;
Settings.INIT_Regen_ptc   = Answer.regen;


end



