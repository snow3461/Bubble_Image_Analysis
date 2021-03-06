clear all;
close all;

addpath('functions');%add the functions directory to the path for this session only.
fullpaths=get_paths('D:\Th�se_INSA\Experiences\Matlab_Programs\Image_Analysis');

timetbl=create_time_points(length(fullpaths));

tablearray=singlefile_treatment(fullpaths);
% tablearray=parallel_treatment(fullpaths);%treat_images

tablearray=populate_timepoint(tablearray,timetbl);%add time correspondance previously generated

%% attribute to each bubbles
data=identifybubble(tablearray);

%% apply scaling
data = apply_scaling(data);

%%save file

save_results( fullpaths,data );