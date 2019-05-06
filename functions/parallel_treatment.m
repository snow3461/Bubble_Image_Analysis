function [ tablearray ] = parallel_treatment( fullpaths )
    %parallel_treatment Launch image analysis with parallel threading
    disp('Starting image treatment in parralel...');
    [folder_name,~,~]=fileparts(fullpaths{1});
    p=gcp('nocreate');%check if a pool is available
    
    if isempty(p)%if no pool, create one
        pool=parpool(4);%4 workers for an quad-core CPU
    end%
    
    nimages=length(fullpaths);% initialize some variables
    
    t=progresstimer(nimages,folder_name);%create a timer to probe progress
    start(t); % start timer
    tablearray=batchDetectParticles(fullpaths,@DetectParticles);
    stop(t);
    %delete(pool);%optionnaly shut down the pool
end