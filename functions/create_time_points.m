function [ timetbl ] = create_time_points(nimages)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%% promt intervall
prompt = {'Enter the intervall in seconds between images'};
dlg_title = 'Intervalle';
num_lines =1;
def= {'1'};
answer=inputdlg(prompt,dlg_title,num_lines,def);

if isempty(answer)
    msg='You hit the cancel button ! I quit';
    error(msg,num);
    return;
end     
time_interval=str2num(answer{1});% intervall between images in second

timetbl=table([0:time_interval:time_interval*nimages]','VariableNames',{'Time'}); %table with coressponding time to each images

end

