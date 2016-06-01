
clear all;
close all;

%% set up folder containing images
folder_name=uigetdir('D:\Thèse_INSA\Experiences\','Choose a folder to process');
if folder_name==0
    msg='No folder selected, I quit';
    error(msg);
    return;
end

y=dir(fullfile(folder_name,'*.jpg'));
y=y(find(~cellfun(@(isdir) isdir==1,{y(:).isdir}))); %remove every folder from list
filenames={y.name};
fullpath=(fullfile(folder_name,filesep,filenames))';

%% initiliaze some variables
nimages=length(fullpath);

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


%% trying to use parallel box
p=gcp('nocreate');%check if a pool is available
if isempty(p)%if no pool, create one
pool=parpool(4);%4 workers for an quad-core CPU
end
tablearray=batchDetectParticles(fullpath,@DetectParticles);
%delete(pool);%optionnaly shut down the pool
tablearray=populate_timepoint(tablearray,timetbl);
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