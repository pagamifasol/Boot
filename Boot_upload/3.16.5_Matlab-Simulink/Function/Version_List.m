function version_list = Version_List()

%% Add folder
files = dir('Model_Parameters');
Folders = files([files.isdir]);

SZ = size(Folders,1);

i = 3;
while i <=  SZ
    version_list(i-2) = cellstr(Folders(i).name);
    i = i + 1;
end

end














