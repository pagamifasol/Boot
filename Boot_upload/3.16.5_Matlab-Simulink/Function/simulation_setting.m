function [Sim_name , canceled] = simulation_setting()

%%
sim_name = Simulation_List();

Title = 'Electric Vehicle Simulation Input';

%%%% SETTING DIALOG OPTIONS
Options.WindowStyle  = 'modal';
Options.Resize       = 'on';
Options.Interpreter  = 'tex';
Options.CancelButton = 'on';
Options.ApplyButton  = 'on';
Options.ButtonNames  = {'Ok','Cancel'}; %<- default names, included here just for illustration

i1 = 1;
Prompt(i1,:)             = {'---------------------------------------------    Simulation    ---------------------------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];
i1 = i1 +1;

Prompt(i1,:) = {'Select Simulation        ','sim_name',[]};
Formats(i1,1).type = 'list';
Formats(i1,1).size       = [250 20];
Formats(i1,1).style = 'popupmenu';
Formats(i1,1).items = sim_name;


i1 = i1 +1;

Prompt(i1,:)             = {'-------------------------------------------------------------------------------------------------------------',[],[]};
Formats(i1,1).type       = 'text';
Formats(i1,1).size       = [1000 0];


[Answer,canceled] = inputsdlg(Prompt,Title,Formats,[],Options);



%%


Sim_name       = sim_name{Answer.sim_name};


end



