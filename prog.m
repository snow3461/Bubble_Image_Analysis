
clear all;
close all;

%% set up folder containing images
folder_name=uigetdir('D:\Thèse_INSA\Experiences\','Choose a folder to process');
if folder_name==0
    msg='No folder selected, I quit';
    error(msg);
    return;
end

y=dir(fullfile(folder_name,'*.png'));
y=y(find(~cellfun(@(isdir) isdir==1,{y(:).isdir}))); %remove every folder from list
filenames={y.name};
fullpath=(fullfile(folder_name,filesep,filenames))';

%% initiliaze some variables
nimages=length(fullpath);
data={};%initialise data array

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

timetbl=table([0:time_interval:time_interval*nimages]','VariableNames',{'Time'});


%% run analysis algorythm
h= waitbar(0,[num2str(1) ' / ' num2str(nimages)],'Name','Analysing images, computing segmentation and region props...');
for k=1:nimages
    
    
    
    tabl = DetectParticles(fullpath{k});
    
    if ~isempty(tabl)% if resulting table is not empty, do this
        
        timepoint=timetbl(k,:);% populate the timepoint
        while height(timepoint)< height(tabl) % if several buubles, need the same timepoint for all of them...
            timepoint=[timepoint ; timepoint(1,:)]; % so append the time point as necessary
        end
        tabl=[timepoint, tabl];
        
        %% identify bubble and tie measure to results table
        
        data = identifybubble( data, tabl );
        
    end
    waitbar(k/nimages,h,[num2str(k) ' / ' num2str(nimages)]);
end
close(h)
%% apply scaling
data=apply_scaling(data);

%%save file

FilterSpec = {'*.xls', 'Excel Spreadsheet (*.xls)'}; %set the filter for the next ui dialog that allows to select files !
[Filenames, Pathname, FilterIndex] = uiputfile(FilterSpec,'Save to',folder_name); %open ui dialog to select files and store filenames and path....
fullpath=strcat(Pathname,Filenames);
for i=1:numel(data)
   writetable(data{i},fullpath,'Filetype','spreadsheet','Sheet',i);
end

clear all;
close all;
