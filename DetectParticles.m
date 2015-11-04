function Particle = DetectParticles(filename)

%% for each filename, read images
im=imread(filename);

%% treat image

imt=imgtreatment(im,5);

%% extract measurements

[Particle, ~, L] = extractmeasure(imt);
[folder,name,~] = fileparts(filename);%retrive folder name
mkdir(folder, 'Processed_images');%create a new folder in this folder

%compose label image and original RGB image
mask=label2rgb(L,@jet,'k');
sel=(L>0);
processed=uint8(zeros(size(im)));
for k=1:1:3 % 1 is red, 2 is green, 3 is blue
    ai=im(:,:,k);%retrive data from channel on original image
    maski=mask(:,:,k);% retrive data from channel on mask image
    ai(sel)=maski(sel);% change data from original to mask, only where needed?
    processed(:,:,k)=ai;
end
writepath=fullfile(folder,'Processed_images',strcat(name,'_processed','.png'));
imwrite(processed,writepath,'png');

%%optionnaly, write image with region in a folder

end