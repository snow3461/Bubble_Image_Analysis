function [ data ] = identifybubble( data, tabl )
%identifybubble Regroup result of extractmeasure function into cell array
%of table, one table for each bubble
%   Detailed explanation goes here

%% populate data array with first measurements
if isempty(data);
    for i=1:height(tabl)
        transtable=tabl(i,:);
        transtable.Properties.Description=strjoin({'Bulle',num2str(i)});
        data{i,1}=transtable;
    end
    return; % exist function
end
if isempty(tabl)
     msg='No object detected in this image';
    error(msg,num);
    return;
end


 
%%take each entry of table, comppare centroid with last entry in each
%%table in data cell arrays

read=tabl.Centroid; %read matrix of centroids
result=zeros(size(read(:,2)));% create result vector


%% identify bubble by proximity of centroids coordinates
for i=1:numel(data)
    origin=data{i}.Centroid(end,:); % take centroid coordinates of end of results table
    dist=sqrt(sum([read(:,1)-origin(1,1) read(:,2)-origin(1,2)].^2,2));% take
    [~,minindex]= min(dist);%min index give index 
    result(minindex)=i;
end

for i=1:height(tabl)
    if result(i)~=0
    data{result(i)}=[data{result(i)};tabl(i,:)]; %add row to corresponding table
    end
end



end

%% TODO
% - handle case where no bubble was detected. (on totally balck image for
% example



% if result return 0,  must handle taht as well (not previously found
% bubble, surely artefacts