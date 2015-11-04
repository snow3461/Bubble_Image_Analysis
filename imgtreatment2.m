function [ output_image ] = imgtreatment( input_image )
%imgtreatment Convert images to gray, threshold it, remove small particules

im=rgb2gray(input_image);%convert to grayscale
% imshow(im)
% im=imadjust(im);
% imshowpair(im,im_adjust,'montage');

multilevel=multithresh(im,2);% multilevel thresholding using otsu method
newlevel=min(multilevel); % we want only the darkest one
BW=imquantize(im,newlevel);% actual segmentation of the image
BW=im2bw(BW,[0 0 0; 1 1 1]); % convert to binrary (logical image) using a color map [0 0 0; 1 1 1]

BW=imcomplement(BW); %inverse color
% imshow(BW)

%remove small element
se=strel('disk',30);
BW=imopen(BW,se);% equivalent to bwmorph(input_image,'open')
output_image=imfill(BW,'holes');% fills holes

% 
% figure;
% imshowpair(input_image,output_image,'montage');

end

