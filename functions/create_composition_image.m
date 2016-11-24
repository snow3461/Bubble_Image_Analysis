function [] = create_composition_image(im,L,filename)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


[folder,name,~] = fileparts(filename);%retrive folder name

testdir=strcat(folder,'\Processed_images');
if ~(exist(testdir,'dir')==7)
mkdir(folder, 'Processed_images');%create a new folder in this folder
end

%compose label image and original RGB image
mask=label2rgb(L,@jet,'k');

%%M following portion is to make basic composition, no blending...before
%%finding custom imfuse function
sel=(L>0);
processed=uint8(zeros(size(im)));
if ndims(im)==3
for k=1:1:3 % 1 is red, 2 is green, 3 is blue
    ai=im(:,:,k);%retrive data from channel on original image
    maski=mask(:,:,k);% retrive data from channel on mask image
    ai(sel)=maski(sel);% change data from original to mask, only where needed?
    processed(:,:,k)=ai;
end
else
    for k=1:1:3 % 1 is red, 2 is green, 3 is blue
    ai=im;%retrive data from channel on original image
    maski=mask(:,:,k);% retrive data from channel on mask image
    ai(sel)=maski(sel);% change data from original to mask, only where needed?
    processed(:,:,k)=ai;
    end
end
processed=imfuse_custom(im,processed,'blend'); % blending with modified image to keep intensity in rest of image
processed=imresize(processed,0.5,'bicubic');
writepath=fullfile(folder,'Processed_images',strcat(name,'_processed','.jpg'));
imwrite(processed,writepath,'jpg');

end

