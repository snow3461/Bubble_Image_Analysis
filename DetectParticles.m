function Particle = DetectParticles(filename)

%% for each filename, read images
im=imread(filename);

%% treat image

imt=imgtreatment(im,15);

%% extract measurements

[Particle, ~, L] = extractmeasure(imt);


%% compose label image and original RGB image
create_composition_image(im,L,filename);
% replaced by function.deleting of following if that works.

% [folder,name,~] = fileparts(filename);%retrive folder name
% mkdir(folder, 'Processed_images');%create a new folder in this folder

%mask=label2rgb(L,@jet,'k');
% %following portion is to make basic composition, no blending...before
% %%finding custom imfuse function
%
% sel=(L>0);
% processed=uint8(zeros(size(im)));
% for k=1:1:3 % 1 is red, 2 is green, 3 is blue
%     ai=im(:,:,k);%retrive data from channel on original image
%     maski=mask(:,:,k);% retrive data from channel on mask image
%     ai(sel)=maski(sel);% change data from original to mask, only where needed?
%     processed(:,:,k)=ai;
% end
% processed=imfuse_custom(im,processed,'blend'); % blending with modified image to keep intensity in rest of image
% writepath=fullfile(folder,'Processed_images',strcat(name,'_processed','.png'));
% imwrite(processed,writepath,'png');
% 
% %%optionnaly, write image with region in a folder
% 
end