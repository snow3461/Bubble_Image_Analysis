
clear all;
close all;

fullpaths=get_paths('D:\Thèse_INSA\Experiences\');

timetbl=create_time_points(length(fullpaths));

%% trying to use parallel toolbox
p=gcp('nocreate');%check if a pool is available
if isempty(p)%if no pool, create one
pool=parpool(4);%4 workers for an quad-core CPU
end%
nimages=length(fullpaths);% initialize some variables
t=progresstimer(nimages,folder_name);
start(t);
tablearray=batchDetectParticles(fullpaths,@DetectParticles);
stop(t);
%delete(pool);%optionnaly shut down the pool
tablearray=populate_timepoint(tablearray,timetbl);

%% attribute to each bubbles
data=identifybubble(tablearray);

%% apply scaling
data=apply_scaling(data);

%%save file

FilterSpec = {'*.xls', 'Excel Spreadsheet (*.xls)'}; %set the filter for the next ui dialog that allows to select files !
[Filenames, Pathname, FilterIndex] = uiputfile(FilterSpec,'Save to',folder_name); %open ui dialog to select files and store filenames and path....
fullpath=strcat(Pathname,Filenames);
for i=1:numel(data)
   writetable(data{i},fullpath,'Filetype','spreadsheet','Sheet',i);
end