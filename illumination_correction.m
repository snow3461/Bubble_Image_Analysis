function [result] = illumination_correction(input_image)

%need to convert to double and normalise image
imdbl=double(input_image);
for i=1:1:3 % 1 is red, 2 is green, 3 is blue
    channel=(imdbl(:,:,i));
    maxvalue=max(channel(:));
    imdbl(:,:,i)=imdbl(:,:,i)./maxvalue;
end

result = shadowremoval(imdbl, 'additive');

end