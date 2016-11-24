function [] = save_results( fullpaths,data )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[folder_name,~,~]=fileparts(fullpaths{1});
FilterSpec = {'*.xls', 'Excel Spreadsheet (*.xls)'}; %set the filter for the next ui dialog that allows to select files !
[Filenames, Pathname, FilterIndex] = uiputfile(FilterSpec,'Save to',folder_name); %open ui dialog to select files and store filenames and path....
fullpath=strcat(Pathname,Filenames);
for i=1:numel(data)
   writetable(data{i},fullpath,'Filetype','spreadsheet','Sheet',i);
end

end

