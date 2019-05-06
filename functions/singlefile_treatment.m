function [ data ] = singlefile_treatment(fullpaths)
%singlefile_treatment Launch image analysis with parallel threading

fileNames=fullpaths;
nImages=length(fileNames);
data={};


for k = 1:nImages    
   data{k} = DetectParticles(fileNames{k});  
end

