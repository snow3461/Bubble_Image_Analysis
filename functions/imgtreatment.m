function [ output_image ] = imgtreatment( input_image, winsize )
%imgtreatment Convert images to gray, threshold it, inverse, remove small particules

if (nargin<2)
    winsize=60;%default value for size if not specified
end
%validateImage(im);
if ndims(input_image)==3%if rgb image
im=rgb2gray(input_image);%convert to grayscale
else
    im=input_image;
end%if already grayscale, do nothing



%% adptative thresholding using bult-in matalb function
T=adaptthresh(im,0.45,'NeighborhoodSize',[101 101],'Statistic','mean','ForegroundPolarity','dark');
BW = imbinarize(im,T);

BW=imcomplement(BW); %inverse color

%remove small element
BW=imfill(BW,'holes');% fills holes
se=strel('disk',winsize);%structuring element is a disk
output_image=imopen(BW,se);% equivalent to bwmorph(input_image,'open');


function validateImage(I)

supportedClasses = {'uint8','uint16','uint32','int8','int16','int32','single','double'};
supportedAttribs = {'real','nonsparse','2d'};
validateattributes(I,supportedClasses,supportedAttribs,mfilename,'I');

end


end

