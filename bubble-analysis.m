
clear all;
close all;

addpath('functions');%add the functions directory to the path for this session only.
fullpaths=get_paths('D:\Thèse_INSA\Experiences\');

timetbl=create_time_points(length(fullpaths));

tablearray=parallel_treatment(fullpaths);%treat_images

tablearray=populate_timepoint(tablearray,timetbl);%add time correspondance

%% attribute to each bubbles
data=identifybubble(tablearray);

%% apply scaling
data=apply_scaling(data);

%%save file

save_results( data )