function [ timetbl ] = create_time_points(nimages)
    %create_time_points Thisfunction generate a table wth the time variable
    %   User is asked for timeintervall between images, and the functon geerate a table with all the values of the time variable
    disp('Creating time points table...');
    %------ promt intervall
    prompt = {'Enter the intervall in seconds between images'}; % promt dialog
    dlg_title = 'Intervalle';%prompt title
    num_lines =1; %num of lines
    def= {'1'};%defaut value
    answer=inputdlg(prompt,dlg_title,num_lines,def);
    
    %% check if input is empty, and return nothing.
    if isempty(answer)
        msg='You hit the cancel button ! I quit';
        error(msg,num);
        return;
    end
    
    time_interval=str2num(answer{1}); % convert entered intervall to number
    
    timetbl=table([0:time_interval:time_interval*nimages]','VariableNames',{'Time'}); %table with coressponding time to each images
    
end

