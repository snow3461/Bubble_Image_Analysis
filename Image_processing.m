clear all;
close all;

Time=[0:5:230]'
ResultTable=table(Time)

im=imread('test.PNG');
imGPU = gpuArray(im); %%read image and put it as treated by GPU
imGPUgray=rgb2gray(imGPU);%convert to grayscale
imGPUadjust=imadjust(imGPUgray);
% imshowpair(im,im_adjust,'montage');

level=arrayfun(@graythresh,imGPUadjust)

im=im_adjust;
level=graythresh(im);
BW=im2bw(im,level);
BW=imcomplement(BW); %inverse color
BW=imfill(BW,'holes');
figure;
imshowpair(im,BW,'montage')

%%filter small object from binary image using a disk structuring element
se=strel('disk',50);
BW1=imopen(BW,se);
figure;
imshowpair(BW,BW1,'montage');

%% extract connected object, label them, and count them
[B,L,num,A] = bwboundaries(BW1);
if num > 1
    msg='There is %d objects detected, that is more than one and this program can not handle it yet,sorry'
error(msg,num)
end
% Display the label matrix and draw each boundary
lab=imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
stats=regionprops('table',L,'Area','Centroid','MajorAxisLength','MinorAxisLength');
threshold=0.94;

% loop over the boundaries
for k = 1:length(B)

  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};

  % compute a simple estimate of the object's perimeter
  delta_sq = diff(boundary).^2;
  perimeter = sum(sqrt(sum(delta_sq,2)));

  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;

  % compute the roundness metric
  metric = 4*pi*area/perimeter^2;
  stats{4}.

  % display the results
  metric_string = sprintf('%2.2f',metric);

  % mark objects above the threshold with a black circle
  if metric > threshold
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');
  end

  text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y',...
       'FontSize',14,'FontWeight','bold');

end

S=struct2table(stats)

FilterSpec = {'*.csv;*.xls','(*.csv;*.xls)'};
% FilterSpec = {'*.csv;*.xls','(*.csv;*.xls)' ;'*.xls', 'Excel Spreasheet (*.xls)';'*.csv','Comma-Separated Values'} %set the filter for the next ui dialog that allows to select files !
[Filenames, Pathname, FilterIndex] = uiputfile(FilterSpec,'Save to','E:\Thèse_INSA\Experiences\'); %open ui dialog to select files and store filenames and path....
fullpath=strcat(Pathname,Filenames)
writetable(stats,fullpath,'Delimiter','\t')
