
clear all;
close all;

folder_name=uigetdir('E:\Thèse_INSA\Experiences\','Choose a folder to process');
y=dir(fullfile(folder_name,'*.png'));
y=y(find(~cellfun(@(isdir) isdir==1,{y(:).isdir}))); %remove every folder from list
filenames={y.name};
fullpath=(fullfile(folder_name,filesep,filenames))';
nimages=length(fullpath);
data={};%initialise data array
time_interval= 1; % intervall between images in second
timetbl=table([0:time_interval:time_interval*nimages]','VariableNames',{'Time'});



for k=1:nimages
    tabl = DetectParticles(fullpath{k});
    
    if ~isempty(tabl)% if resulting table is not empty, do this
        
        timepoint=timetbl(k,:);% populate the timepoint
        while height(timepoint)< height(tabl) % if several buubles, need the same timepoint for all of them...
            timepoint=[timepoint ; timepoint(1,:)]; % so append the time point as necessary
        end
        tabl=[timepoint, tabl];
        
        %% identify buuble and tie measure to results table
        
        data = identifybubble( data, tabl );
        
    end
end

FilterSpec = {'*.xls', 'Excel Spreadsheet (*.xls)'} %set the filter for the next ui dialog that allows to select files !
[Filenames, Pathname, FilterIndex] = uiputfile(FilterSpec,'Save to','E:\Thèse_INSA\Experiences\'); %open ui dialog to select files and store filenames and path....
fullpath=strcat(Pathname,Filenames)
for i=1:numel(data)
   writetable(data{i},fullpath,'Filetype','spreadsheet','Sheet',i)
end
