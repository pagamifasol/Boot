function i2API(workspace, folder, freq)
    % Use i2 API (must have a valid license) to convert .mat files - workspace (without .mat) - folder (complete path) - freq (in Hz)
    clc; 
        
	% Create the i2 COM server and make it visible		
    i2 = actxserver('MoTeC.i2Application');     
        i2.DataSources.CloseAll();
    i2.Visible = 1;    
          
    destination=strcat(folder,workspace,'.ld');
    
    i2_CreateData(i2,workspace,freq); %create new data   
    i2.DataSources.ExportMain(destination);

    %i2_SwapMainRef(i2);    
    
    i2.Exit();
end

function i2_StartSection(section)
    fprintf('########################### start %s section ###########################\n',section);
end

function i2_EndSection()
    fprintf('###############################################################################\n\n');
end


function i2_CreateData(i2,workspace,freq)
    %%%%%%%%%%%%%%%%%%%%% Create log file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    load(workspace);
    matrix=whos;
    L=length(matrix); 
    new_ds = i2.DataSources.Create(length(Time)*freq*100); % correct length
    normal = new_ds.Layers.Item('');  % normal logging is specified as an empty string ''
    channels = normal.Channels;

    %%%%%%%%%%%%%%%%%%%%%% Create Channels %%%%%%%%%%%%%%%%
    
    for j = 1:L
        if( strcmp(matrix(j).name,'i2') || strcmp(matrix(j).name,'workspace') || strcmp(matrix(j).name,'freq') )
        else
            i2_CreateChannel(channels, matrix(j).name, freq, eval(matrix(j).name));
        end
    end
          
    new_ds.Details.AddString('Event', workspace);
    new_ds.Details.AddString('Venue', workspace);
    new_ds.Details.AddString('Driver', 'N/A');
    new_ds.Details.AddString('Vehicle Id', 'P094');
    new_ds.Details.AddDateTime('Log Date', datestr(now, 'dd/mm/yyyy'));
    new_ds.Details.AddDateTime('Log Time', datestr(now,'HH:MM:SS')); % time only
    new_ds.Details.AddString('Short Comment', 'Generated with i2API');

    %%%%%%%%%%%%%%%%%%%%%%Create Laps%%%%%%%%%%%%%%%%
    %i2_CreateLaps(normal);
    
    % update any dependant data
    i2.DataSources.Refresh(new_ds);
    
    %i2.DataSources.Refresh(ds)			 		' tell i2 to refresh its ranges (this call already existed)
    %Laps = normal.RangeGroups("Outings:Laps")	' get the set of lap ranges
    %i2.DataSources.Main = Laps(0)		 		' select the first lap (out lap) as the main range
end

function i2_CreateChannel(channels,name,rate,array)
    c = channels.Add(name, 'MoTeC.Float');
    d = c.Descriptor;
    d.DPS = 3;
    d.Interpolate = true;
    d.ScaleMin = -10;
    d.ScaleMax = 10;
    d.ColorIndex = 8 * randi(100);

    a = c.CreateDataArray(rate);
    %u = a.Count;
    u = length(array);
    %data and flags should be 1 column (not 1 row) matrices for further
    %conversion to single dimension SAFEARRAY
    data = zeros(u,1);
    flags = zeros(u,1,'uint8');
    for i = 1:u 
        data(i) = array(i);
        flags(i) = 1;
    end

    %The default data conversion rules for MATLAB's COM interface convert
    %all non-scalar MATLAB arrays into 2-dimensional SAFEARRAYs. 
    %Following line converts a single column matrix 
    %to a 1 dimensional array when passed to a COM object.
    feature('COM_SafeArraySingleDim', 1);

    a.Samples = data;
    a.SampleFlags = flags;
    a.Unit = '';

    %to reset the default behaviour of MATLAB of passing all data as
    %two-dimensional arrays
    feature('COM_SafeArraySingleDim', 0);

    c.DataArray = a;
end
