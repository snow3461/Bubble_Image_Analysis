function [ fullpaths ] = get_paths( default_folder )
%get_paths Ask the user for the folder containing iamges to analyse

folder_name=uigetdir(default_folder,'Choose a folder to process'); % UI prompt

if folder_name==0
    msg='No folder selected, I quit';
    error(msg);
    return;
end

y=dir(folder_name);
%need to handle .jpg, .png, or .tiff
y=y(~[y.isdir]);%remove every folder form the list
y=y(find(cellfun(@(str) ~isempty(regexp(str(end-2:end),'(jpg|png|tiff|tif|jpeg)', 'once')),{y(:).name})));%select only image file with png, jpg, or tiff extension
filenames={y.name}; %retrieve only filenames
fullpaths=(fullfile(folder_name,filesep,filenames))';%get fullpath for every file.
end

