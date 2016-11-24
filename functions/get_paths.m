function [ fullpaths ] = get_paths( default_folder )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


folder_name=uigetdir(default_folder,'Choose a folder to process');
if folder_name==0
    msg='No folder selected, I quit';
    error(msg);
    return;
end

y=dir(folder_name);
%need to handle .jpg, .png, or .tiff
y=y(~[y.isdir]);%remove every folder form the list
y=y(find(cellfun(@(str) ~isempty(regexp(str(end-2:end),'(jpg|png|tiff|tif|jpeg)', 'once')),{y(:).name})));%select only image file with png, jpg, or tiff extension
filenames={y.name};
fullpaths=(fullfile(folder_name,filesep,filenames))';
end

