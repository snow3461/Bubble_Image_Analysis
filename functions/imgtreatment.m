function [ output_image ] = imgtreatment( input_image, winsize )
%imgtreatment Convert images to gray, threshold it, remove small particules

% if dim(input_image)==3
% end

if (nargin<2)
    winsize=15;%default value for size if not specified
end

validateImage(input_image);

% input_image=illumination_correction(input_image);
if ndims(input_image)==3%if rgb image
im=rgb2gray(input_image);%convert to grayscale
else
    im=input_image;
end%if already grayscale, do nothing

% imshow(im)
% im=imadjust(im);%can actually make thresholding a lot harder....
% imshowpair(im,im_adjust,'montage');


%% multilevel thresholding using otsu methods
% multilevel=multithresh(im,2);% multilevel thresholding using otsu method
% newlevel=min(multilevel); % we want only the darkest one
% BW=imquantize(im,newlevel);% actual segmentation of the image
% BW=im2bw(BW,[0 0 0; 1 1 1]); % convert to binrary (logical image) using a color map [0 0 0; 1 1 1]

%% adptative thresholding using custom function,carefull with windows size
BW=adaptivethreshold(im,800);

%% adptative thresholding using bult-in matalb function
% BW=adaptivethreshold(im,801);
T=adaptthresh(im,0.5,'NeighborhoodSize',[57 57],'Statistic','mean','ForegroundPolarity','dark');
% imshow(T)
BW = imbinarize(im,T);
% figure;
% imshow(BW);


BW=imcomplement(BW); %inverse color
% imshow(BW)

%remove small element
se=strel('disk',winsize);
BW=imopen(BW,se);% equivalent to bwmorph(input_image,'open')
output_image=imfill(BW,'holes');% fills holes

% 
% figure;
% imshowpair(input_image,output_image,'montage');


function validateImage(I)

supportedClasses = {'uint8','uint16','uint32','int8','int16','int32','single','double'};
supportedAttribs = {'real','nonsparse','2d'};
validateattributes(I,supportedClasses,supportedAttribs,mfilename,'I');

end


end

