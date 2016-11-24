function [ tablearray ] = parallel_treatment( fullpaths )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[folder_name,~,~]=fileparts(fullpaths{1});
p=gcp('nocreate');%check if a pool is available
if isempty(p)%if no pool, create one
pool=parpool(4);%4 workers for an quad-core CPU
end%
nimages=length(fullpaths);% initialize some variables
t=progresstimer(nimages,folder_name);
start(t);
tablearray=batchDetectParticles(fullpaths,@DetectParticles);
stop(t);
%delete(pool);%optionnaly shut down the pool
end

