function [ data_table ] = identifybubble( data_array )
%identifybubble Regroup result of extractmeasure function into cell array
%of table, one table for each bubble
%   Detailed explanation goes here

%% populate data array with first measurements
data_table={};
for k=1:length(data_array)
    
if isempty(data_table);
    for i=1:height(data_array{k})%for each buble
        transtable=data_array{k}(i,:);%temporarytable
        transtable.Properties.Description=strjoin({'Bulle',num2str(i)});
        data_table{i,1}=transtable; %initalise one table per bubble
    end
    continue;% then go to next iteration of k
end
if isempty(data_array{k})
    msg='No object detected in this image';
    error(msg);
    continue;
end


 
%%take each entry of table, comppare centroid with last entry in each
%%table in data cell arrays

read=data_array{k}.Centroid; %read matrix of centroids
result=zeros(size(read(:,2)));% create result vector


%% identify bubble by proximity of centroids coordinates
for i=1:numel(data_table)
    origin=data_table{i}.Centroid(end,:); % take centroid coordinates of end of results table
    dist=sqrt(sum([read(:,1)-origin(1,1) read(:,2)-origin(1,2)].^2,2));% take
    [~,minindex]= min(dist);%min index give index 
    result(minindex)=i;
end

for i=1:height(data_array{k})
    if result(i)~=0
    data_table{result(i)}=[data_table{result(i)};data_array{k}(i,:)]; %add row to corresponding table
    end
end



end
end


%% TODO
% - handle case where no bubble was detected. (on totally balck image for
% example



% if result return 0,  must handle that as well (not previously found
% bubble, surely artefacts