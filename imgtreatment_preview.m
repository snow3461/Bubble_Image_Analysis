function [ output_image ] = imgtreatment_preview( input_image )
%imgtreatment Convert images to gray, threshold it, remove small particules

im=rgb2gray(input_image);%convert to grayscale
% imshow(im)
im=imadjust(im);
% imshowpair(im,im_adjust,'montage');

%% multilevel thresholding using otsu methods
% multilevel=multithresh(im,2);% multilevel thresholding using otsu method
% newlevel=min(multilevel); % we want only the darkest one
% BW=imquantize(im,newlevel);% actual segmentation of the image
% BW=im2bw(BW,[0 0 0; 1 1 1]); % convert to binrary (logical image) using a color map [0 0 0; 1 1 1]

%% adptative thresholding
BW=adaptivethreshold(im,800);

%%
BW=imcomplement(BW); %inverse color
% imshow(BW)

%remove small element
se=strel('disk',30);
BW1=imopen(BW,se);% equivalent to bwmorph(input_image,'open')
imt=imfill(BW1,'holes');% fills holes
% imshow(imt)


%% extract measurements

[~, ~, L] = extractmeasure(imt);

%compose label image and original RGB image
mask=label2rgb(L,@jet,'k');

%%M following portion is to make basic composition, no blending...before
%%finding custom imfuse function
im=input_image;
sel=(L>0);
processed=uint8(zeros(size(im)));
for k=1:1:3 % 1 is red, 2 is green, 3 is blue
    ai=im(:,:,k);%retrive data from channel on original image
    maski=mask(:,:,k);% retrive data from channel on mask image
    ai(sel)=maski(sel);% change data from original to mask, only where needed?
    processed(:,:,k)=ai;
end
output_image =imfuse_custom(im,processed,'blend'); % blending with modified image to keep intensity in rest of image

% 
% figure;
% imshowpair(input_image,output_image,'montage');

end

