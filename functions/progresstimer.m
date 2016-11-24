function t = progresstimer(nimages,folder_name)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

t = timer;
t.StartFcn = @progressTimerStart;
t.TimerFcn = @updatebar;
t.StopFcn = @TimerCleanup;
t.Period = 5;
t.StartDelay = 5;
t.ExecutionMode = 'fixedSpacing';
t.TasksToExecute=Inf;
t.UserData={folder_name};


    function progressTimerStart(mTimer,~)
        nproc=0;
        x=nproc/nimages;
        h=waitbar(x,'Images Processing in progress...');%store waitbar handles in UserData field
        t.UserData=[t.UserData;{h}];
    end

    function updatebar(mTimer,~)
        data=t.UserData;
        folder_name=data{1};
        h=data{2};
        nproc=numel(dir(fullfile(folder_name,'Processed_images','*.jpg')));
        x=nproc/nimages;
        waitbar(x,h,sprintf('%d/%d images processed, please wait....',nproc,nimages));%update waitbar
    end

    function TimerCleanup(mTimer,~)
        data=t.UserData;
        close(data{2});%close the waitbar
    end














end

