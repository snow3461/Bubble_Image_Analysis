clear all;
close all;


im=imread('test.PNG');
imgray=rgb2gray(im);

% %to get ride of uneven illumination
% se=strel('disk',50);
% tophatfiltered=imtophat(imgray,se);
% imshow(tophatfiltered);

imgray=imadjust(imgray);
imshow(imgray)
level=graythresh(imgray);
BW=im2bw(imgray,level);
BW=imcomplement(BW); %inverse color
realIm=(I3~=0)
imshow(BW)



%%filter small object from binary image using a disk structuring element
se=strel('disk',2);
BW=imopen(BW,se);
BW=imfill(BW,'holes');
figure;
imshowpair(im,BW,'montage');


%% extract connected object, label them, and count them
[B,L,num,A] = bwboundaries(BW);
% if num > 1
%     msg='There is %d objects detected, that is more than one and this program can not handle it yet,sorry'
% error(msg,num)
% end
% Display the label matrix and draw each boundary
lab=imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2), boundary(:,1), 'k', 'LineWidth', 2)
end
stats=regionprops(L,'Area','Centroid','Perimeter','MajorAxisLength','MinorAxisLength','EquivDiameter','Perimeter');
threshold=0.60;

% loop over the boundaries
for k = 1:length(B)
    
     % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};

  % compute a simple estimate of the object's perimeter
  perimeter = stats(k).Perimeter;

  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;

  % compute the roundness metric
  metric = 4*pi*area/perimeter^2;

  % display the results
  metric_string = sprintf('%2.2f',metric);

  % mark objects above the threshold with a black circle
  if metric > threshold
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'wo');
  end

  text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y',...
       'FontSize',14,'FontWeight','bold');

end

FilterSpec = {'*.csv;*.xls','(*.csv;*.xls)'};
% FilterSpec = {'*.csv;*.xls','(*.csv;*.xls)' ;'*.xls', 'Excel Spreasheet (*.xls)';'*.csv','Comma-Separated Values'} %set the filter for the next ui dialog that allows to select files !
[Filenames, Pathname, FilterIndex] = uiputfile(FilterSpec,'Save to','E:\Thèse_INSA\Experiences\'); %open ui dialog to select files and store filenames and path....
fullpath=strcat(Pathname,Filenames)
writetable(stats,fullpath,'Delimiter','\t')
