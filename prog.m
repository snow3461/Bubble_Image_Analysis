
clear all;
close all;

%% set up folder containing images
folder_name=uigetdir('D:\Thèse_INSA\Experiences\','Choose a folder to process');
if folder_name==0
    msg='No folder selected, I quit';
    error(msg);
    return;
end

y=dir(folder_name)
%need to handle .jpg, .png, or .tiff
y=y(~[y.isdir]);%remove every folder form the list
y=y(find(cellfun(@(str) ~isempty(regexp(str(end-2:end),'(jpg|png|tiff)', 'once')),{y(:).name})));%select only image file with png, jpg, or tiff extension
filenames={y.name};
fullpaths=(fullfile(folder_name,filesep,filenames))';


%% initiliaze some variables
nimages=length(fullpaths);

%% promt intervall
prompt = {'Enter the intervall in seconds between images'};
dlg_title = 'Intervalle';
num_lines =1;
def= {'1'};
answer=inputdlg(prompt,dlg_title,num_lines,def);

if isempty(answer)
    msg='You hit the cancel button ! I quit';
    error(msg,num);
    return;
end     
time_interval=str2num(answer{1});% intervall between images in second

timetbl=table([0:time_interval:time_interval*nimages]','VariableNames',{'Time'}); %table with coressponding time to each images


%% trying to use parallel toolbox
p=gcp('nocreate');%check if a pool is available
if isempty(p)%if no pool, create one
pool=parpool(4);%4 workers for an quad-core CPU
end
t=progresstimer(nimages,folder_name);
start(t);
tablearray=batchDetectParticles(fullpaths,@DetectParticles);
stop(t);
%delete(pool);%optionnaly shut down the pool
tablearray=populate_timepoint(tablearray,timetbl);
data=identifybubble(tablearray);

%% apply scaling
data=apply_scaling(data);

%%save file

FilterSpec = {'*.xls', 'Excel Spreadsheet (*.xls)'}; %set the filter for the next ui dialog that allows to select files !
[Filenames, Pathname, FilterIndex] = uiputfile(FilterSpec,'Save to',folder_name); %open ui dialog to select files and store filenames and path....
fullpaths=strcat(Pathname,Filenames);
for i=1:numel(data)
   writetable(data{i},fullpaths,'Filetype','spreadsheet','Sheet',i);
end