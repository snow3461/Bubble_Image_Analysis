function [ output_image ] = imgtreatment( input_image, winsize )
    %imgtreatment Convert images to gray, threshold it, inverse, remove small particules
    
    if (nargin<2)
        winsize=60;%default value for size if not specified
    end
    validateImage(input_image);%check if real image
    if ndims(input_image)==3%if rgb image
        input_image=rgb2gray(input_image);%convert to grayscale
    end%if already grayscale, do nothing
    
    %% adptative thresholding using bult-in matalb function
    T=adaptthresh(input_image,0.45,'NeighborhoodSize',[101 101],'Statistic','mean','ForegroundPolarity','dark');%compute locally adaptative threshold
    input_image = imbinarize(input_image,T);%make binary
    input_image=imcomplement(input_image); %inverse color
    
    %remove small element
    input_image=imfill(input_image,'holes');% fills holes
    se=strel('disk',winsize);%structuring element is a disk
    output_image=imopen(input_image,se);% equivalent to bwmorph(input_image,'open'), morphological opening;
    
    
    function validateImage(I)
        
        supportedClasses = {'uint8','uint16','uint32','int8','int16','int32','single','double'};
        supportedAttribs = {'real','nonsparse','2d'};
        validateattributes(I,supportedClasses,supportedAttribs,mfilename,'I');
        
    end
    
    
end

