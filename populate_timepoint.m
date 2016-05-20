function [ data ] = populate_timepoint( data, timetbl )
%populate_timepoint will append calculated timepoint totablecorresponding
%to each images in the data array of table


for k=1:length(data)
    
if ~isempty(data{k})
    timepoint=timetbl(k,:);
    while height(timepoint)< height(data{k})
            timepoint=[timepoint ; timepoint(1,:)];%append the same timepoint to table
    end
    data{k}=[timepoint, data{k}];
end

end

