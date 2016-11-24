function [ data ] = singlefile_treatment(fullpaths)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
fileNames=fullpaths;
nImages=length(fileNames);
data={};


for k = 1:nImages    
   data{k} = DetectParticles(fileNames{k});  
end

