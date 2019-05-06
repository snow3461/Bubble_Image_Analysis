function [ data ] = singlefile_treatment(fileNames)
    %singlefile_treatment Launch image analysis with single threading
    disp('Starting image treatment with a single thread...');
    nImages=length(fileNames);
    data={};
    
    %% check folder presence
    [folder_name,~,~]=fileparts(fileNames{1});
    testdir=strcat(folder_name,'\Processed_images'); %we will place the processed images in a separate folder
    if (exist(testdir,'dir')==7)
        warning('Processed_images folder already exist, removing directory');
        rmdir(testdir,'s');
    end
    mkdir(folder_name, 'Processed_images');%if not exist, create the folder
    
    %% timer creation
    t=progresstimer(nImages,folder_name);%create a timer to probe progress
    start(t); % start timer
    %% launch image analysis
    for k = 1:nImages
        data{k} = DetectParticles(fileNames{k});
    end
    %% stop timer
    stop(t)
end