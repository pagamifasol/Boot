function [loops,canceled] = loop_setting()

Title = 'Electric Vehicle Simulation Input';

%%%% SETTING DIALOG OPTIONS
Options.WindowStyle     = 'modal';
Options.Resize          = 'on';
Options.Interpreter     = 'tex';
Options.CancelButton    = 'on';
Options.ApplyButton     = 'on';
Options.ButtonNames     = {'Ok','Cancel'}; %<- default names, included here just for illustration

parameters              = {'Non_ePT_Mass_kg';'Aero_Cx*A';'Aux_power_tot_W';'TrqDistrFr';'drive_ratio';'motor_power_ratio';'front_motor_power_W';'rear_motor_power_W';'CRR_SAE2452';'battery_energy_kWh';'h_COG'};

i1 = 1;

Prompt(i1,:)             = {'-------------------------    Parameters variation    -------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];
i1 = i1 +1;

Prompt(i1,:) = {'Number of parameters       ','n_loop',[]};
Formats(i1,1).type = 'list';
Formats(i1,1).size       = [50 0];
Formats(i1,1).style = 'popupmenu';
Formats(i1,1).items = {'0';'1';'2';'3';'4';'5'};
i1 = i1 +1;

Prompt(i1,:)             = {'-   (Select 0 to perform a single simulation without variations)   -',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];
i1 = i1 +1;

Prompt(i1,:) = {'Parameter 1                ','parameter1',[]};
Formats(i1,1).type = 'list';
Formats(i1,1).size       = [120 0];
Formats(i1,1).style = 'popupmenu';
Formats(i1,1).items = parameters;
DefAns.parameter1   = 1;
i1 = i1 +1;

Prompt(i1,:) = {'Parameter 2                ','parameter2',[]};
Formats(i1,1).type = 'list';
Formats(i1,1).size       = [120 0];
Formats(i1,1).style = 'popupmenu';
Formats(i1,1).items = parameters;
DefAns.parameter2   = 2;
i1 = i1 +1;

Prompt(i1,:) = {'Parameter 3                ','parameter3',[]};
Formats(i1,1).type = 'list';
Formats(i1,1).size       = [120 0];
Formats(i1,1).style = 'popupmenu';
Formats(i1,1).items = parameters;
DefAns.parameter3   = 3;
i1 = i1 +1;

Prompt(i1,:) = {'Parameter 4                ','parameter4',[]};
Formats(i1,1).type = 'list';
Formats(i1,1).size       = [120 0];
Formats(i1,1).style = 'popupmenu';
Formats(i1,1).items = parameters;
DefAns.parameter4   = 4;
i1 = i1 +1;

Prompt(i1,:) = {'Parameter 5                ','parameter5',[]};
Formats(i1,1).type = 'list';
Formats(i1,1).size       = [120 0];
Formats(i1,1).style = 'popupmenu';
Formats(i1,1).items = parameters;
DefAns.parameter5   = 5;
i1 = i1 +1;


Prompt(i1,:)             = {'-------------------------------    Parameter 1    ------------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];
i1 = i1 +1;

Prompt(i1,:) = {'starting value          ','init_value1',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.init_value1 = 1;
i1 = i1 + 1;

Prompt(i1,:) = {'step                         ','step1',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.step1 = 0.1;
i1 = i1 + 1;

Prompt(i1,:) = {'final value                ','fin_value1',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.fin_value1 = 1.5;
i1 = i1 + 1;


Prompt(i1,:)             = {'-------------------------------    Parameter 2    ------------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];
i1 = i1 +1;

Prompt(i1,:) = {'starting value          ','init_value2',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.init_value2 = 1;
i1 = i1 + 1;

Prompt(i1,:) = {'step                         ','step2',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.step2 = 0.1;
i1 = i1 + 1;

Prompt(i1,:) = {'final value                ','fin_value2',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.fin_value2 = 1.5;
i1 = i1 + 1;


Prompt(i1,:)             = {'-------------------------------    Parameter 3    ------------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];
i1 = i1 +1;

Prompt(i1,:) = {'starting value          ','init_value3',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.init_value3 = 1;
i1 = i1 + 1;

Prompt(i1,:) = {'step                         ','step3',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.step3 = 0.1;
i1 = i1 + 1;

Prompt(i1,:) = {'final value                ','fin_value3',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.fin_value3 = 1.5;
i1 = i1 + 1;

Prompt(i1,:)             = {'-------------------------------    Parameter 4    ------------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];
i1 = i1 +1;

Prompt(i1,:) = {'starting value          ','init_value4',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.init_value4 = 1;
i1 = i1 + 1;

Prompt(i1,:) = {'step                         ','step4',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.step4 = 0.1;
i1 = i1 + 1;

Prompt(i1,:) = {'final value                ','fin_value4',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.fin_value4 = 1.5;
i1 = i1 + 1;


Prompt(i1,:)             = {'-------------------------------    Parameter 5    ------------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];
i1 = i1 +1;

Prompt(i1,:) = {'starting value          ','init_value5',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.init_value5 = 1;
i1 = i1 + 1;

Prompt(i1,:) = {'step                         ','step5',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.step5 = 0.1;
i1 = i1 + 1;

Prompt(i1,:) = {'final value                ','fin_value5',[]};
Formats(i1,1).type = 'edit';
Formats(i1,1).format = 'float';
Formats(i1,1).size = 80;
DefAns.fin_value5 = 1.5;
i1 = i1 + 1;


Prompt(i1,:)             = {'-----------------------------------------------------------------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];


[Answer,canceled] = inputsdlg(Prompt,Title,Formats,DefAns,Options);



%%
if (Answer.n_loop-1) > 0
    loops.parameter1        = parameters(Answer.parameter1);
    loops.Change1           = Answer.init_value1:Answer.step1:Answer.fin_value1;
    loops.loopsi            = length(loops.Change1);
    loops.Change2           = 0;
    loops.loopsj            = 0;
    loops.Change3           = 0;
    loops.loopsk            = 0;
    loops.Change4           = 0;
    loops.loopsm            = 0;
    loops.Change5           = 0;
    loops.loopsn            = 0;
    if (Answer.n_loop-1) > 1
        loops.parameter2        = parameters(Answer.parameter2);
        loops.Change2           = Answer.init_value2:Answer.step2:Answer.fin_value2;
        loops.loopsj            = length(loops.Change2);
        loops.Change3           = 0;
        loops.loopsk            = 0;
        loops.Change4           = 0;
        loops.loopsm            = 0;
        loops.Change5           = 0;
        loops.loopsn            = 0;
        if (Answer.n_loop-1) > 2
            loops.parameter3        = parameters(Answer.parameter3);
            loops.Change3           = Answer.init_value3:Answer.step3:Answer.fin_value3;
            loops.loopsk            = length(loops.Change3);
            loops.Change4           = 0;
            loops.loopsm            = 0;
            loops.Change5           = 0;
            loops.loopsn            = 0;
            if (Answer.n_loop-1) > 3
                loops.parameter4        = parameters(Answer.parameter4);
                loops.Change4           = Answer.init_value4:Answer.step4:Answer.fin_value4;
                loops.loopsm            = length(loops.Change4);
                loops.Change5           = 0;
                loops.loopsn            = 0;
                if (Answer.n_loop-1) > 4
                    loops.parameter5        = parameters(Answer.parameter5);
                    loops.Change5           = Answer.init_value5:Answer.step5:Answer.fin_value5;
                    loops.loopsn            = length(loops.Change5);
                end
            end
        end
    end
else
    loops.Change1           = 0;
    loops.loopsi            = 0;
    loops.Change2           = 0;
    loops.loopsj            = 0;
    loops.Change3           = 0;
    loops.loopsk            = 0;
    loops.Change4           = 0;
    loops.loopsm            = 0;
    loops.Change5           = 0;
    loops.loopsn            = 0;
end



