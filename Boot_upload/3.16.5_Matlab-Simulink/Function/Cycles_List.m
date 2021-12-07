function cycle_name = Cycles_List()

%% Add folder
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
path_folder = strrep(pathstr,'\Function','\Speed_Cycle');

Files=dir(fullfile(path_folder,'*.mat'));

SZ = size(Files);

i1 = 1;
while i1 <=  SZ(1)
    pack_name2{i1} =  cellstr(Files(i1,1).name);
    
    pack_name1(i1) = pack_name2{1,i1};
    
    cycle_name(i1) = strrep(pack_name1(1,i1),'.mat','');
    
    i1 = i1 + 1;
end

addpath(genpath(path_folder))

end














