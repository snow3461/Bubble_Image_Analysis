overlay=zeros(size(im,2));

overlay(B{1})=1;

[row,col]=find(overlay);
test=[row, col]
if test == B{1}

for i=1:length(B{1})
overlay(B{1}(i,1),B{1}(i,2))=1;
end
imshow(overlay)
figure;
perim=bwperim(overlay);
imshow(perim);



figure;
imshow(im);
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2), boundary(:,1), 'b', 'LineWidth', 3)
end
saveas(gcf,'export.png')


%compose label image and original RGB image
mask=label2rgb(L,@jet,'k');
sel=(L~=0);
for k=1:3 % 1 is red, 2 is green, 3 is blue
    ai=im(:,:,k);%retrive data from channel
    maski=mask(:,:,k);
    if k==1 ||k==2
        ai(sel)=maski(sel);
    end
    if k==3
        ai(sel)=maski(sel);
    end
    im2(:,:,k)=ai; %
end
figure;
imshow(im2)