function Particle = DetectParticles(filename)
    %DetectParticle will binarize the image, extract features from it,
    %create a composition image to evaluate the results and return
    
    %% for each filename, read images
    
    im=imread(filename);
    
    %% treat image
    
    imt=imgtreatment(im);
    
    %% extract measurements on binary image
    
    [Particle, ~, L] = extractmeasure(imt);
    
        %% compose label image and original RGB image
    create_composition_image(im,L,filename);
     
   end