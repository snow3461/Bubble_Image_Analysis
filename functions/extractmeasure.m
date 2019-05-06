function [ tabl, B, L ] = extractmeasure( input_image )
%extractmeasure Function responsible of 
%   Detailed explanation goes here

%% extract connected object, label them, and count them
[B,L,N,~] = bwboundaries(input_image);
% if num > 1
%     msg='There is %d objects detected, that is more than one and this program can not handle it yet,sorry'
% error(msg,num)
% end

%% create row label
% rownames=[];
% template={'Bulle '}
% for i=1:num
%     indice={num2str(i)};
%     rownames=[rownames; strcat(template,indice)];
% end




%% Display the label matrix and draw each boundary
% lab=imshow(label2rgb(L, @jet, [.5 .5 .5]))% optional, for debugging purpose only
% hold on
% for k = 1:length(B)
%   boundary = B{k};
%   plot(boundary(:,2), boundary(:,1), 'k', 'LineWidth', 2)
% end
stats=regionprops(L,'Area','Centroid','Perimeter','MajorAxisLength','MinorAxisLength','EquivDiameter','Perimeter','ConvexArea');

%% compute some more caracteristics
for i=1:numel(stats)
    stats(i).Circularity=4*pi*stats(i).Area/(stats(i).Perimeter^2);
    stats(i).AspectRatio= stats(i).MajorAxisLength/stats(i).MinorAxisLength;
    stats(i).Roundness= 4*stats(i).Area/(pi*stats(i).MajorAxisLength^2);
    stats(i).Solidity = stats(i).Area/stats(i).ConvexArea;
end


%convert to table
tabl=struct2table(stats);
% tabl.Properties.Rownames=rownames
% threshold=0.94;


end

