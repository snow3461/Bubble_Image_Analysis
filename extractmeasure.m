function [ tabl, B, L ] = extractmeasure( input_image )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%% extract connected object, label them, and count them
[B,L,~,~] = bwboundaries(input_image);
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
stats=regionprops(L,'Area','Centroid','Perimeter','MajorAxisLength','MinorAxisLength','EquivDiameter','Perimeter');
tabl=struct2table(stats);
% tabl.Properties.Rownames=rownames
% threshold=0.94;


%%
% for k = 1:length(B)
%     
%      % obtain (X,Y) boundary coordinates corresponding to label 'k'
%   boundary = B{k};
% 
%   % compute a simple estimate of the object's perimeter
%   perimeter = stats(k).Perimeter;
% 
%   % obtain the area calculation corresponding to label 'k'
%   area = stats(k).Area;
% 
%   % compute the roundness metric
%   metric = 4*pi*area/perimeter^2;
% 
%   % display the results
%   metric_string = sprintf('%2.2f',metric);
% 
%   % mark objects above the threshold with a black circle
%   if metric > threshold
%     centroid = stats(k).Centroid;
%     plot(centroid(1),centroid(2),'wo');
%   end
% 
%   text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y',...
%        'FontSize',14,'FontWeight','bold');
% 
% end







end

